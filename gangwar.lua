-- Gangwar System for FiveM
-- Author: asyncflo

local gangwarZones = { -- Konfiguration für Gangwar-Gebiete
    { name = "Zone 1", x = 123.0, y = 456.0, z = 78.0, radius = 50.0, dimension = 1001 },
    { name = "Zone 2", x = 789.0, y = 123.0, z = 45.0, radius = 60.0, dimension = 1002 },
    -- Weitere Zonen können hinzugefügt werden
}

local factionAccess = { "Ballas", "Vagos", "Families" } -- Fraktionen, die teilnehmen können
local activeGangwars = {} -- Speichert aktive Gangwars
local gangwarTimers = {} -- Für Gebietsangriffe (Zeitfenster)
local GANGWAR_TIMEFRAME = { start = 18, stop = 23 } -- Gangwar-Zeitraum (18:00 - 23:59)

local gangwarPoints = {} -- Punkte für Fraktionen in laufenden Gangwars

-- Hilfsfunktion: Prüfen, ob eine Fraktion teilnehmen kann
local function canFactionJoin(faction)
    for _, allowedFaction in ipairs(factionAccess) do
        if allowedFaction == faction then
            return true
        end
    end
    return false
end

-- Hilfsfunktion: Prüfen, ob die Zeit im Gangwar-Zeitfenster liegt
local function isGangwarTime()
    local hour = tonumber(os.date("%H"))
    return hour >= GANGWAR_TIMEFRAME.start and hour <= GANGWAR_TIMEFRAME.stop
end

-- Event: Starte Gangwar in einer Zone
RegisterServerEvent("gangwar:start")
AddEventHandler("gangwar:start", function(zoneIndex, faction)
    local source = source
    if not isGangwarTime() then
        TriggerClientEvent("chat:addMessage", source, { args = { "[Gangwar]", "Gangwars können nur zwischen 18:00 und 23:59 gestartet werden!" } })
        return
    end

    if not canFactionJoin(faction) then
        TriggerClientEvent("chat:addMessage", source, { args = { "[Gangwar]", "Deine Fraktion kann nicht an diesem Gangwar teilnehmen!" } })
        return
    end

    local zone = gangwarZones[zoneIndex]
    if not zone then
        TriggerClientEvent("chat:addMessage", source, { args = { "[Gangwar]", "Ungültige Zone ausgewählt!" } })
        return
    end

    if activeGangwars[zoneIndex] then
        TriggerClientEvent("chat:addMessage", source, { args = { "[Gangwar]", "Diese Zone ist bereits in einem Gangwar!" } })
        return
    end

    -- Starte Gangwar
    activeGangwars[zoneIndex] = { faction = faction, points = 0 }
    gangwarPoints[faction] = 0
    TriggerClientEvent("gangwar:start", -1, zone, faction) -- Informiere alle Spieler
end)

-- Event: Punkte hinzufügen
RegisterServerEvent("gangwar:addKillPoint")
AddEventHandler("gangwar:addKillPoint", function(faction)
    if gangwarPoints[faction] then
        gangwarPoints[faction] = gangwarPoints[faction] + 5
        TriggerClientEvent("gangwar:updatePoints", -1, gangwarPoints)
    end
end)

-- Event: Gangwar beenden
RegisterServerEvent("gangwar:end")
AddEventHandler("gangwar:end", function(zoneIndex)
    local zone = gangwarZones[zoneIndex]
    if not zone then return end

    local winnerFaction, maxPoints = nil, 0
    for faction, points in pairs(gangwarPoints) do
        if points > maxPoints then
            winnerFaction, maxPoints = faction, points
        end
    end

    activeGangwars[zoneIndex] = nil
    gangwarPoints = {}

    TriggerClientEvent("chat:addMessage", -1, { args = { "[Gangwar]", "Die Fraktion " .. winnerFaction .. " hat den Gangwar in " .. zone.name .. " gewonnen!" } })
    TriggerClientEvent("gangwar:end", -1, zoneIndex)
end)
