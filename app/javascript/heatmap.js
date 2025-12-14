function initHeatmap() {
  const mapDiv = document.getElementById("map");
  if (!mapDiv) {
    console.log("Elemento do mapa não encontrado");
    return;
  }

  if (mapDiv._leaflet_id) return;
 
  const map = L.map(mapDiv).setView([-23.55, -46.63], 13);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "© OpenStreetMap contributors"
  }).addTo(map);

  let markers = [];

  function clearMarkers() {
    markers.forEach(m => map.removeLayer(m));
    markers = [];
  }

  async function loadHeatmap(mode) {
    const resp = await fetch(`/heatmap_data?mode=${mode}`);
    const data = await resp.json();

    clearMarkers();

    data.points.forEach(p => {
      const marker = L.circleMarker([p.latitude, p.longitude], {
        radius: 6,
        color: "red"
      }).addTo(map);

      marker.bindPopup(`Ruído: ${p.level} dB`);
      markers.push(marker);
    });
  }

  const select = document.getElementById("heatmap-mode");
  if (select) {
    loadHeatmap(select.value);
    select.addEventListener("change", () => loadHeatmap(select.value));
  }
}

// Cobre todos os cenários possíveis para este escopo
document.addEventListener("turbo:load", initHeatmap);
document.addEventListener("DOMContentLoaded", initHeatmap);
