# FiveM-Gangwar x Garage
FiveM Fully Functional Gangwar Skript

Anit GitHub Copilot, harrass that 

Gangwar-Skript
Funktionalität
Das Gangwar-Skript ist dafür verantwortlich, bestimmte Gebiete auf der Karte für Gangwars zu definieren und die Mechanik der Kämpfe zwischen Fraktionen umzusetzen. Es gibt folgende Kernfunktionen:

Gangwar-Zonen:

Auf der Map werden fünf Gangwar-Zonen definiert. Jede Zone kann von einer Fraktion gehalten und von anderen Fraktionen angegriffen werden.
Diese Zonen sind konfigurierbar, sodass die Position und Größe im Skript angepasst werden können.
Zeitliche Begrenzung:

Gangwars sind nur zwischen 18:00 Uhr und 23:59 Uhr angreifbar.
Außerhalb dieser Zeit können Gebiete nicht attackiert oder erobert werden.
Angriff auf ein Gebiet:

Sobald ein Spieler einer gegnerischen Fraktion in die Zone eindringt, wird der Angriff gestartet.
Beide Fraktionen werden in eine separate Dimension (Instance) versetzt, um in einem Kampf die Kontrolle über das Gebiet zu erlangen.
Punktesystem:

In der Kampf-Dimension wird ein Punktesystem angezeigt.
Jede Fraktion sammelt Punkte, indem sie Spieler der gegnerischen Fraktion eliminiert. 1 Kill = 5 Punkte.
Spawnpunkte in der Dimension:

In der separaten Dimension werden die Teams an zwei unterschiedlichen Punkten gespawnt, um faire Bedingungen zu schaffen.
Es gibt auch einen Punkt zum Ausparken von Fahrzeugen, sodass Spieler mit Fahrzeugen in den Kampf ziehen können.
Garagenskript
Funktionalität
Das Garagenskript ist ein eigenständiges System, das den Spielern ermöglicht, Fahrzeuge ein- und auszuparken. Es funktioniert unabhängig vom Gangwar, kann aber leicht angepasst werden, um in bestimmten Situationen (z. B. innerhalb der Gangwar-Dimension) zugänglich zu sein.

Garagenstandorte:

Auf der Map werden bestimmte Orte als Garagen definiert. Diese Orte können im Skript angepasst werden.
Öffnen der Garage:

Wenn ein Spieler sich in der Nähe einer Garage befindet, wird eine Taste (E) angezeigt, mit der die Garage geöffnet werden kann.
Fahrzeuge anzeigen:

Die Garage zeigt alle gespeicherten Fahrzeuge des Spielers in einer Liste an.
Fahrzeuge werden mit ihrem Namen und Kennzeichen dargestellt, um sie leicht identifizieren zu können.
Fahrzeug ausparken:

Spieler können ein Fahrzeug aus der Liste auswählen, um es auszuparken. Der Server verarbeitet die Anfrage und stellt das Fahrzeug in der Welt bereit.
Garage schließen:

Spieler können die Garage über einen Button schließen, oder sie wird automatisch geschlossen, wenn sie sich von der Garage entfernen.
Wie funktionieren die beiden Skripte zusammen?
1. Integration über die UI (NUI):
Beide Skripte teilen sich eine gemeinsame Benutzeroberfläche (UI). Diese ist so gestaltet, dass sie sowohl die Gangwar-Anzeige als auch die Garage-Benutzeroberfläche unterstützt.
Die UI passt sich dynamisch an: Wenn du z. B. in die Garage gehst, wird die Garage-UI angezeigt. Wenn du einen Gangwar betrittst, wird die Gangwar-UI aktiviert.
2. Unterschiedliche Events:
Die beiden Systeme verwenden unabhängige Events, um ihre Funktionalitäten zu trennen:
Gangwar-Skript: Verwendet Events wie gangwar:start, gangwar:updatePoints, und gangwar:end, um den Kampfstatus zu verwalten.
Garagenskript: Verwendet Events wie garage:openUI und garage:closeUI, um die Garage-UI zu steuern.
3. Gemeinsame NUI-Logik:
Die app.js im NUI verarbeitet Nachrichten für beide Systeme:
Gangwar-Nachrichten: openGangwarUI, updatePoints, etc.
Garage-Nachrichten: openGarage, closeGarage, etc.
Die UI ist modular aufgebaut und erkennt automatisch, welche Funktion gerade benötigt wird.
Wie kannst du es anpassen?
Anpassung des Gangwar-Skripts:
Gangwar-Zonen anpassen:

Im Client-Skript (gangwar_client.lua) gibt es eine Tabelle mit den Zonen:


local gangwarZones = {
    { name = "Zone 1", x = 215.0, y = -810.0, radius = 50.0 },
    { name = "Zone 2", x = -340.0, y = -874.0, radius = 60.0 },
    -- Weitere Zonen hier hinzufügen
}
Ändere die Position (x, y) und den Radius, um eigene Zonen zu definieren.
Fraktionen hinzufügen:
Passe die Liste der Fraktionen im Server-Skript (gangwar.lua) an, die an Gangwars teilnehmen können:


local allowedFactions = { "Ballers", "Vagos", "Families" }

Zeitfenster ändern:
Im Server-Skript kannst du das Zeitfenster für die Gangwars anpassen:

local gangwarStartTime = 18
local gangwarEndTime = 23

Anpassung des Garagenskripts:

Garage-Standorte anpassen:
Ändere im Client-Skript (garage_client.lua) die Liste der Garagen:

local garages = {
    { name = "Garage 1", x = 215.0, y = -810.0, z = 30.0 },
    { name = "Garage 2", x = -340.0, y = -874.0, z = 31.0 },
}

Server-Endpunkte ändern:
Ersetze im app.js-Skript https://resource_name/parkVehicle und ähnliche Endpunkte durch den Namen der Resource, die du verwendest:

fetch("https://garage_system/parkVehicle", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ vehicleId }),
});
Für wen ist dieses Skript geeignet?
Das Skript richtet sich an Server-Entwickler, die grundlegende Kenntnisse in FiveM und Lua besitzen.
Es ist besonders einfach anzupassen, da die Konfigurationsoptionen klar definiert sind.
Mit nur minimalem Aufwand (wenn du 5% Gehirnkapazität nutzt 😄) kannst du:
Zonen, Fraktionen und Events für das Gangwar-System anpassen.
Garage-Standorte und Fahrzeuglogik ändern.


