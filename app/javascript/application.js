// Entry point for the build script in your package.json


console.log("Hello from JavaScript!, Eu estou Aqui!");

function sucess(pos) {
    console.log("sucess");
    console.log(pos);
}

navigator.geolocation.getCurrentPosition(sucess);