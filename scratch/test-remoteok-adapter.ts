import { remoteok } from "../src/lib/sources/remoteok";

async function main() {
  console.log("Running RemoteOK adapter test...");
  try {
    const postings = await remoteok.fetchLatest(100);
    console.log(`Fetched ${postings.length} postings from RemoteOK (after filtering).`);

    // Check if the Brazilian Portuguese job is in the results
    const foundBadJob = postings.some(p => p.url.includes("1131773") || p.sourceExternalId === "1131773");
    if (foundBadJob) {
      console.error("FAIL: Brazilian Portuguese job 1131773 was NOT filtered out!");
    } else {
      console.log("SUCCESS: Brazilian Portuguese job 1131773 was correctly filtered out!");
    }

    // Print sample of remaining postings to verify
    console.log("Sample of accepted postings:");
    console.log(postings.slice(0, 5).map(p => ({
      title: p.title,
      company: p.company,
      location: p.location,
      url: p.url
    })));

  } catch (e) {
    console.error("Adapter test failed with exception:", e);
  }
}

main();
