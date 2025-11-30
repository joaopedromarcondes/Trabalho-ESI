// Entry point for the build script in your package.json

console.log("JavaScript loaded");
try {
	require('./profile_menu');
} catch (e) {
	console.warn('profile_menu not loaded', e);
}
try {
  require('./photo_lightbox');
} catch (e) {
  console.warn('photo_lightbox not loaded', e);
}
try {
  require('./noise_history_map');
} catch (e) {
  console.warn('noise_history_map not loaded', e);
}

