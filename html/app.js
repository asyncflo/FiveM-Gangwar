// Gangwar UI Interaktion
window.addEventListener("message", (event) => {
    const data = event.data;

    if (data.type === "showGangwarUI") {
        document.getElementById("gangwar-ui").style.display = "block";
        document.getElementById("gangwar-faction").innerText = data.faction;

        const pointsList = document.getElementById("gangwar-points");
        pointsList.innerHTML = "";

        for (const [faction, points] of Object.entries(data.points)) {
            const li = document.createElement("li");
            li.textContent = `${faction}: ${points} Punkte`;
            pointsList.appendChild(li);
        }
    }

    if (data.type === "updatePoints") {
        const pointsList = document.getElementById("gangwar-points");
        pointsList.innerHTML = "";

        for (const [faction, points] of Object.entries(data.points)) {
            const li = document.createElement("li");
            li.textContent = `${faction}: ${points} Punkte`;
            pointsList.appendChild(li);
        }
    }

    if (data.type === "hideGangwarUI") {
        document.getElementById("gangwar-ui").style.display = "none";
    }

    if (data.type === "openGarage") {
        document.getElementById("garage-ui").style.display = "block";
        document.getElementById("garage-vehicles").innerHTML = ""; // Liste leeren

        data.vehicles.forEach((vehicle) => {
            const li = document.createElement("li");
            li.textContent = vehicle.name;
            li.addEventListener("click", () => {
                fetch("https://resource_name/parkVehicle", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ vehicleId: vehicle.id }),
                }).then(() => console.log("Fahrzeug geparkt."));
            });
            document.getElementById("garage-vehicles").appendChild(li);
        });
    }

    if (data.type === "closeGarage") {
        document.getElementById("garage-ui").style.display = "none";
    }
});

// Schließen der UI
document.getElementById("close-gangwar-ui").addEventListener("click", () => {
    document.getElementById("gangwar-ui").style.display = "none";
    fetch("https://resource_name/closeGangwarUI", { method: "POST" });
});

document.getElementById("close-garage-ui").addEventListener("click", () => {
    document.getElementById("garage-ui").style.display = "none";
    fetch("https://resource_name/closeGarage", { method: "POST" });
});
