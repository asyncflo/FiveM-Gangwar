local garages = {
    { name = "Garage 1", x = 215.0, y = -810.0, z = 30.0 },
    { name = "Garage 2", x = -340.0, y = -874.0, z = 31.0 },
}

local nearGarage = false

-- Funktion, um zu prüfen, ob der Spieler in der Nähe einer Garage ist
Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        nearGarage = false

        for _, garage in ipairs(garages) do
            local distance = #(playerCoords - vector3(garage.x, garage.y, garage.z))
            if distance < 5.0 then
                nearGarage = true
                DrawText3D(garage.x, garage.y, garage.z + 1.0, "[E] Garage öffnen")
                if IsControlJustReleased(0, 38) then -- "E" ist Keycode 38
                    SetNuiFocus(true, true)
                    SendNUIMessage({ type = "openGarage", garageName = garage.name })
                end
                break
            end
        end

        Wait(nearGarage and 0 or 1000)
    end
end)

-- 3D-Text-Funktion
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()

        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Event: Schließe das NUI
RegisterNUICallback("closeGarage", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)
