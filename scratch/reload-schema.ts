import pg from "pg";

const { Client } = pg;

async function main() {
  const connectionString = "postgresql://postgres:m7TE8w9acgc31DAv@aws-0-ca-central-1.pooler.supabase.com:6543/postgres";
  console.log("Connecting to Supabase ca-central-1 pooler as postgres...");

  const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    console.log("Connected to database via Supavisor pooler.");

    // Run the schema reload notify
    const res = await client.query("NOTIFY pgrst, 'reload schema';");
    console.log("Reload notify sent successfully:", res);

    // Check columns
    const columnsRes = await client.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'inspections' AND table_schema = 'public';
    `);
    console.log("Columns of 'inspections' table:", columnsRes.rows);

  } catch (e) {
    console.error("Database operation failed:", e);
  } finally {
    await client.end();
  }
}

main();
