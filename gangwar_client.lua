-- Client-side Gangwar Script

local isInGangwar = false
local currentZone = nil
local gangwarPoints = {}

RegisterNetEvent("gangwar:start")
AddEventHandler("gangwar:start", function(zone, faction)
    if not isInGangwar then
        currentZone = zone
        isInGangwar = true

        -- Lade den Spieler in die Gangwar-Dimension
        local playerPed = PlayerPedId()
        SetEntityCoords(playerPed, zone.x, zone.y, zone.z)
        SetEntityDimension(playerPed, zone.dimension)

        -- Starte Gangwar-Anzeige
        SendNUIMessage({ type = "showGangwarUI", faction = faction, points = gangwarPoints })
    end
end)

RegisterNetEvent("gangwar:updatePoints")
AddEventHandler("gangwar:updatePoints", function(points)
    gangwarPoints = points
    SendNUIMessage({ type = "updatePoints", points = points })
end)

RegisterNetEvent("gangwar:end")
AddEventHandler("gangwar:end", function(zoneIndex)
    if currentZone and currentZone.zoneIndex == zoneIndex then
        isInGangwar = false
        currentZone = nil

        -- Schließe Gangwar-UI
        SendNUIMessage({ type = "hideGangwarUI" })
    end
end)
