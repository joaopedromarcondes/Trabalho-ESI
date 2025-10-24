console.log("JavaScript loaded");

// Entry point for the build script in your package.json

// JavaScript para gravar audio
let mediaRecorder;
let audioChunks = [];
let startTime;

function startRecording() {
  console.log("Attempting to start recording...");
  navigator.mediaDevices.getUserMedia({ audio: true })
    .then(stream => {
      console.log("Microphone access granted");
      mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();
      startTime = Date.now();

      mediaRecorder.addEventListener("dataavailable", event => {
        console.log("Data available:", event.data);
        audioChunks.push(event.data);
      });

      mediaRecorder.addEventListener("stop", () => {
        console.log("Recording stopped");
        const audioBlob = new Blob(audioChunks);
        const audioUrl = URL.createObjectURL(audioBlob);
        const audio = new Audio(audioUrl);
        audio.play();

        // calcula duracao do audio
        const durationSeconds = Math.round((Date.now() - startTime) / 1000);
        console.log("Recording duration:", durationSeconds);

        // coloca a duracao no formulario
        const durationInput = document.createElement("input");
        durationInput.type = "hidden";
        durationInput.name = "audio_submission[duration_seconds]";
        durationInput.value = durationSeconds;
        document.querySelector("form").appendChild(durationInput);

        // integra blob de audio com o form
        const audioInput = document.createElement("input");
        audioInput.type = "hidden";
        audioInput.name = "audio_submission[audio]";
        audioInput.value = audioBlob;
        document.querySelector("form").appendChild(audioInput);
      });
    })
    .catch(error => {
      console.error("Microphone access denied or error occurred:", error);
    });
}

function stopRecording() {
  console.log("Stopping recording...");
  mediaRecorder.stop();
}

document.getElementById("start-recording").addEventListener("click", () => {
  console.log("Start Recording button clicked");
  startRecording();
});

document.getElementById("stop-recording").addEventListener("click", () => {
  console.log("Stop Recording button clicked");
  stopRecording();
});

