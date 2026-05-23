import { describe, expect, it, vi, beforeEach } from "vitest";
import { checkRateLimit } from "@/lib/rateLimit";
import * as supabaseLib from "@/lib/supabase";

// Mock the entire supabase client
vi.mock("@/lib/supabase", () => {
  const mockFrom = vi.fn();
  return {
    supabase: () => ({
      from: mockFrom,
    }),
  };
});

describe("checkRateLimit Utility", () => {
  beforeEach(() => {
    vi.resetAllMocks();
    process.env.RATE_LIMIT_WINDOW_SEC = "600";
    process.env.RATE_LIMIT_MAX_REQUESTS = "3"; // Small limit for testing
  });

  it("should allow request if under the limit", async () => {
    const mockSelect = vi.fn().mockReturnValue({
      eq: vi.fn().mockReturnValue({
        gte: vi.fn().mockResolvedValue({ count: 1, error: null }),
      }),
    });

    const mockInsert = vi.fn().mockResolvedValue({ error: null });
    const mockDelete = vi.fn().mockReturnValue({
      lt: vi.fn().mockResolvedValue({ error: null }),
    });

    const supabaseMock = supabaseLib.supabase() as any;
    supabaseMock.from.mockImplementation((table: string) => {
      if (table === "verify_rate_limits") {
        return {
          select: mockSelect,
          insert: mockInsert,
          delete: mockDelete,
        };
      }
      return null;
    });

    const result = await checkRateLimit("192.168.1.1");

    expect(result.allowed).toBe(true);
    expect(result.count).toBe(2);
    expect(result.max).toBe(3);
    expect(result.windowSec).toBe(600);
    expect(mockSelect).toHaveBeenCalled();
    expect(mockInsert).toHaveBeenCalled();
  });

  it("should block request if at or over the limit", async () => {
    const mockSelect = vi.fn().mockReturnValue({
      eq: vi.fn().mockReturnValue({
        gte: vi.fn().mockResolvedValue({ count: 3, error: null }),
      }),
    });

    const mockInsert = vi.fn();

    const supabaseMock = supabaseLib.supabase() as any;
    supabaseMock.from.mockImplementation((table: string) => {
      if (table === "verify_rate_limits") {
        return {
          select: mockSelect,
          insert: mockInsert,
        };
      }
      return null;
    });

    const result = await checkRateLimit("192.168.1.1");

    expect(result.allowed).toBe(false);
    expect(result.count).toBe(3);
    expect(result.max).toBe(3);
    expect(result.windowSec).toBe(600);
    expect(mockSelect).toHaveBeenCalled();
    expect(mockInsert).not.toHaveBeenCalled();
  });

  it("should fail-open and allow the request if the database query fails", async () => {
    const mockSelect = vi.fn().mockReturnValue({
      eq: vi.fn().mockReturnValue({
        gte: vi.fn().mockResolvedValue({ count: null, error: new Error("DB Error") }),
      }),
    });

    const supabaseMock = supabaseLib.supabase() as any;
    supabaseMock.from.mockImplementation((table: string) => {
      if (table === "verify_rate_limits") {
        return {
          select: mockSelect,
        };
      }
      return null;
    });

    const result = await checkRateLimit("192.168.1.1");

    expect(result.allowed).toBe(true);
    expect(result.count).toBe(0);
    expect(result.max).toBe(3);
  });
});
