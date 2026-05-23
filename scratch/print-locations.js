async function main() {
  const url = "https://remoteok.com/api";
  const UA = "Lighthouse/1.0 (+https://github.com/GMBermeo/SWB-AI-Hackathon-2026)";

  const res = await fetch(url, {
    headers: { accept: "application/json", "user-agent": UA },
  });

  const data = await res.json();
  const locations = data.slice(1).map(j => ({
    id: j.id,
    location: j.location || "",
    position: j.position || "",
    tags: j.tags || []
  }));

  console.log("Sample locations in the feed:");
  console.log(JSON.stringify(locations.slice(0, 30), null, 2));
}

main();
