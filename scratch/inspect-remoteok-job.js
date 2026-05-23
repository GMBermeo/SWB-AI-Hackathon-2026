async function main() {
  const url = "https://remoteok.com/api";
  const UA = "Lighthouse/1.0 (+https://github.com/GMBermeo/SWB-AI-Hackathon-2026)";

  const res = await fetch(url, {
    headers: { accept: "application/json", "user-agent": UA },
  });

  const data = await res.json();
  console.log("Total jobs in feed:", data.length);

  const target = data.find(j => String(j.id) === "1131773" || (j.url && j.url.includes("1131773")));
  if (target) {
    console.log("Found target job:", JSON.stringify(target, null, 2));
  } else {
    console.log("Job 1131773 not found in the current feed. Printing first 3 jobs instead:");
    console.log(JSON.stringify(data.slice(1, 4), null, 2));
  }
}

main();
