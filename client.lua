local ESX = exports['es_extended']:getSharedObject()

CreateThread(function()

    Wait(800)

    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped, false)
    local wasInVehicle = inVehicle

    SendNUIMessage({
        action = "setHudSide",
        mode = inVehicle and "center" or "left"
    })

    while true do
        Wait(300)

        ped = PlayerPedId()
        inVehicle = IsPedInAnyVehicle(ped, false)

        if inVehicle and not wasInVehicle then
            SendNUIMessage({ action = "setHudSide", mode = "center" })
            wasInVehicle = true

        elseif not inVehicle and wasInVehicle then
            SendNUIMessage({ action = "setHudSide", mode = "left" })
            wasInVehicle = false
        end
    end
end)




RegisterNetEvent('esx_status:onTick', function(status)
    local health = GetEntityHealth(PlayerPedId()) / 2
    if health > 100 then health = 100 end

    SendNUIMessage({
        action = 'updateStatus',
        health = math.floor(health),
        armor = math.floor(GetPedArmour(PlayerPedId())),
        hunger = math.floor(status[1].percent),
        thirst = math.floor(status[2].percent),
        stamina = math.floor(100 - GetPlayerSprintStaminaRemaining(PlayerId()))
    })
end)


CreateThread(function()
    while true do
        Wait(500)

        local ped = PlayerPedId()
        local isDead = IsEntityDead(ped)

        SendNUIMessage({
            action = 'toggle',
            show = not isDead
        })
    end
end)
