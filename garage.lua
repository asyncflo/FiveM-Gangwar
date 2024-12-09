local garages = {
    { name = "Garage 1", x = 215.0, y = -810.0, z = 30.0 },
    { name = "Garage 2", x = -340.0, y = -874.0, z = 31.0 },
}

RegisterCommand("openGarage", function(source)
    TriggerClientEvent("garage:openUI", source)
end, false)
