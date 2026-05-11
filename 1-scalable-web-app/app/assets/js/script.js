// A simple script to display the user's current time on the dashboard
document.addEventListener("DOMContentLoaded", () => {
  const timeDisplay = document.getElementById("client-time");

  function updateTime() {
    const now = new Date();
    timeDisplay.textContent = now.toLocaleTimeString();
  }

  // Update immediately, then every second
  updateTime();
  setInterval(updateTime, 1000);

  console.log("Optimize-ops web assets loaded successfully via CloudFront.");
});
