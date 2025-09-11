// Exemplo simplificado de webpack.config.js
const path = require("path");

module.exports = {
  entry: "./app/javascript/packs/application.js", // Ponto de entrada
  output: {
    filename: "application.js",
    path: path.resolve(__dirname, "app/assets/builds"), // Para onde os arquivos vão
  },
  // ... loaders, plugins, etc.
};