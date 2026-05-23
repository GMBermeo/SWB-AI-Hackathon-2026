async function main() {
  const url = "http://localhost:3000/api/verify";
  const jobUrl = "https://remoteOK.com/remote-jobs/remote-asset-protection-specialist-burnaby-the-home-depot-canada-1131715";

  console.log("Sending POST request to /api/verify for job URL:", jobUrl);
  console.log("This will trigger Gemini API and database insertion. Please wait ~20-30 seconds...");

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({ url: jobUrl })
    });

    console.log("Response status:", res.status, res.statusText);
    const json = await res.json();
    console.log("Response JSON:");
    console.log(JSON.stringify(json, null, 2));

    if (res.ok && json.posting) {
      console.log("\nSUCCESS: Verification completed successfully!");
      console.log("Returned Posting ID:", json.posting.id);
      if (json.posting.id.startsWith("live-")) {
        console.warn("WARNING: The ID is still the temporary 'live-xxxxxx' ID! This means the database upsert returned null (PostgREST schema cache is still stale on the hosted Supabase instance).");
      } else {
        console.log("PERFECT: A database UUID was successfully returned! The PostgREST schema cache has reloaded and is functional.");
      }
    } else {
      console.error("\nFAIL: Verification failed!");
    }

  } catch (e) {
    console.error("HTTP request failed:", e);
  }
}

main();
