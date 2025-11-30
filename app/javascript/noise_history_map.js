function initializeNoiseHistoryMap() {
  const mapElement = document.getElementById('noise-history-map');
  
  if (!mapElement) {
    console.log('Elemento do mapa não encontrado');
    return;
  }
  
  console.log('Inicializando mapa de histórico de ruído...');

  let map;
  let markers = [];
  let selectedArea = null;
  let centerLat = -23.5505;
  let centerLng = -46.6333;

  function initMap() {
    try {
      console.log('Criando mapa Leaflet...');
      map = L.map('noise-history-map').setView([centerLat, centerLng], 12);

      L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
      }).addTo(map);
      
      console.log('Mapa criado com sucesso');
      setTimeout(() => {
        map.invalidateSize();
      }, 100);
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          centerLat = position.coords.latitude;
          centerLng = position.coords.longitude;
          map.setView([centerLat, centerLng], 13);
          loadMeasurements();
        }, function() {
          loadMeasurements();
        });
      } else {
        loadMeasurements();
      }
      map.on('click', function(e) {
        centerLat = e.latlng.lat;
        centerLng = e.latlng.lng;
        updateSelectedArea();
      });
    } catch (error) {
      console.error('Erro ao inicializar mapa:', error);
    }
  }
  function getMarkerColor(level) {
    if (level <= 50) return '#4CAF50';
    if (level <= 70) return '#FFC107';
    if (level <= 85) return '#FF9800';
    return '#F44336';
  }
  function getMarkerClass(level) {
    if (level <= 50) return 'low';
    if (level <= 70) return 'medium';
    if (level <= 85) return 'high';
    return 'extreme';
  }


  function createMarkerIcon(level) {
    const color = getMarkerColor(level);
    const markerClass = getMarkerClass(level);
    
    return L.divIcon({
      className: `custom-marker marker-${markerClass}`,
      html: `<div class="marker-pin" style="background-color: ${color};">
               <span class="marker-label">${level}</span>
             </div>`,
      iconSize: [30, 42],
      iconAnchor: [15, 42],
      popupAnchor: [0, -42]
    });
  }

  function loadMeasurements() {
    clearMarkers();

    const measurements = window.noiseMeasurementsData || [];
    
    measurements.forEach(function(measurement) {
      const icon = createMarkerIcon(measurement.level);
      const marker = L.marker([measurement.latitude, measurement.longitude], { icon: icon })
        .addTo(map);
      
      const popupContent = `
        <div class="marker-popup">
          <strong>${measurement.level} dB</strong><br>
          <small>${new Date(measurement.created_at).toLocaleString('pt-BR')}</small><br>
          <small>Lat: ${measurement.latitude.toFixed(4)}, Lng: ${measurement.longitude.toFixed(4)}</small>
        </div>
      `;
      
      marker.bindPopup(popupContent);
      markers.push(marker);
    });
  }

  function clearMarkers() {
    markers.forEach(marker => map.removeLayer(marker));
    markers = [];
  }

  function updateSelectedArea() {
    if (selectedArea) {
      map.removeLayer(selectedArea);
    }

    const radius = parseFloat(document.getElementById('radius').value) || 5;
    selectedArea = L.circle([centerLat, centerLng], {
      color: 'blue',
      fillColor: '#30f',
      fillOpacity: 0.1,
      radius: radius * 1000
    }).addTo(map);
  }

  document.getElementById('apply-filters').addEventListener('click', function() {
    const startDate = document.getElementById('start-date').value;
    const endDate = document.getElementById('end-date').value;
    const radius = document.getElementById('radius').value;

    const params = new URLSearchParams();
    if (startDate) params.append('start_date', startDate);
    if (endDate) params.append('end_date', endDate);
    if (radius) params.append('radius', radius);
    params.append('lat', centerLat);
    params.append('lng', centerLng);

    fetch(`/noise_history.json?${params.toString()}`)
      .then(response => response.json())
      .then(data => {
        window.noiseMeasurementsData = data.measurements;
        updateStats(data.stats);
        updateMeasurementsList(data.measurements);
        loadMeasurements();
        updateSelectedArea();
      })
      .catch(error => console.error('Erro ao carregar medições:', error));
  });

  document.getElementById('clear-filters').addEventListener('click', function() {
    document.getElementById('start-date').value = '';
    document.getElementById('end-date').value = '';
    document.getElementById('radius').value = '5';
    
    if (selectedArea) {
      map.removeLayer(selectedArea);
      selectedArea = null;
    }
    
    window.location.href = '/noise_history';
  });

  function updateStats(stats) {
    document.getElementById('stat-count').textContent = stats.count;
    document.getElementById('stat-average').textContent = stats.average + ' dB';
    document.getElementById('stat-min').textContent = stats.min + ' dB';
    document.getElementById('stat-max').textContent = stats.max + ' dB';
  }

  function updateMeasurementsList(measurements) {
    const container = document.getElementById('measurements-container');
    
    if (measurements.length === 0) {
      container.innerHTML = '<p class="no-data">Nenhuma medição encontrada para os filtros aplicados.</p>';
      return;
    }

    const sorted = measurements.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
    const limited = sorted.slice(0, 10);

    container.innerHTML = limited.map(m => {
      const levelClass = getMarkerClass(m.level);
      const date = new Date(m.created_at).toLocaleString('pt-BR', { 
        year: 'numeric', month: 'short', day: 'numeric', 
        hour: '2-digit', minute: '2-digit' 
      });
      
      return `
        <div class="measurement-item" data-lat="${m.latitude}" data-lng="${m.longitude}">
          <div class="measurement-level level-${levelClass}">
            ${m.level} dB
          </div>
          <div class="measurement-info">
            <div class="measurement-date">${date}</div>
            <div class="measurement-coords">
              Lat: ${m.latitude.toFixed(4)}, Lng: ${m.longitude.toFixed(4)}
            </div>
          </div>
        </div>
      `;
    }).join('');

    container.querySelectorAll('.measurement-item').forEach(item => {
      item.addEventListener('click', function() {
        const lat = parseFloat(this.dataset.lat);
        const lng = parseFloat(this.dataset.lng);
        map.setView([lat, lng], 16);
        markers.forEach(marker => {
          const markerLat = marker.getLatLng().lat;
          const markerLng = marker.getLatLng().lng;
          if (Math.abs(markerLat - lat) < 0.0001 && Math.abs(markerLng - lng) < 0.0001) {
            marker.openPopup();
          }
        });
      });
    });
  }
  initMap();
}
document.addEventListener('DOMContentLoaded', initializeNoiseHistoryMap);
document.addEventListener('turbolinks:load', initializeNoiseHistoryMap);

if (document.readyState === 'loading') {
    //esperar acabar
} else {
  initializeNoiseHistoryMap();
}
