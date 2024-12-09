// Globale Event-Listener für NUI-Nachrichten
window.addEventListener("message", (event) => {
    const data = event.data;

    // Öffne die Garage-UI
    if (data.type === "openGarage") {
        showGarageUI(data.vehicles, data.garageName);
    }

    // Schließe die Garage-UI
    if (data.type === "closeGarage") {
        hideGarageUI();
    }
});

// Funktion: Garage-UI anzeigen
function showGarageUI(vehicles, garageName) {
    const garageUI = document.getElementById("garage-ui");
    const vehicleList = document.getElementById("garage-vehicles");

    // Titel setzen
    document.querySelector("#garage-ui h1").innerText = `${garageName}`;

    // Fahrzeugliste dynamisch füllen
    vehicleList.innerHTML = ""; // Liste leeren
    vehicles.forEach((vehicle) => {
        const li = document.createElement("li");
        li.textContent = `${vehicle.name} (Kennzeichen: ${vehicle.plate})`;
        li.addEventListener("click", () => selectVehicle(vehicle.id));
        vehicleList.appendChild(li);
    });

    // UI anzeigen
    garageUI.style.display = "block";
    setNuiFocus(true, true);
}

// Funktion: Fahrzeug auswählen
function selectVehicle(vehicleId) {
    fetch("https://resource_name/parkVehicle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ vehicleId }),
    }).then(() => {
        console.log(`Fahrzeug mit ID ${vehicleId} ausgewählt.`);
    });
}

// Funktion: Garage-UI ausblenden
function hideGarageUI() {
    const garageUI = document.getElementById("garage-ui");
    garageUI.style.display = "none";
    setNuiFocus(false, false);
}

// Button-Event: Garage schließen
document.getElementById("close-garage-ui").addEventListener("click", () => {
    hideGarageUI();
    fetch("https://resource_name/closeGarage", { method: "POST" });
});
