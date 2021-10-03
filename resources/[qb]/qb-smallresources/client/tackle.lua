--[[
 ______ _           __  __      _ _    
|  ____(_)         |  \/  |    | | |   
| |__   ___   _____| \  / |  __| | | __
|  __| | \ \ / / _ \ |\/| | / _` | |/ /
| |    | |\ V /  __/ |  | || (_| |   < 
|_|    |_| \_/ \___|_|  |_(_)__,_|_|\_\

Vores sider:
  • Hjemmesiden: https://fivem.dk
  • Patreon: https://patreon.com/dkfivem
  • Facebook: https://facebook.com/dkfivem
  • Discord: https://discord.gg/dkfivem
  • DybHosting: https://dybhosting.eu/ - Rabatkode: dkfivem10
]]

Citizen.CreateThread(function()
    while true do 
        if QBCore ~= nil then
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) and GetEntitySpeed(ped) > 2.5 then
                if IsControlJustPressed(1, 19) then --- Venstre ALT knap
                    Tackle()
                end
            else
                Citizen.Wait(250)
            end
        end

        Citizen.Wait(1)
    end
end)

RegisterNetEvent('tackle:client:GetTackled')
AddEventHandler('tackle:client:GetTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(1000, 6000), math.random(1000, 6000), 0, 0, 0, 0) 
	TimerEnabled = true
	Citizen.Wait(1500)
	TimerEnabled = false
end)

function Tackle()
    closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if(distance ~= -1 and distance < 2) then
        TriggerServerEvent("tackle:server:TacklePlayer", GetPlayerServerId(closestPlayer))
        TackleAnim()
    end
end

function TackleAnim()
    local ped = PlayerPedId()
    if not QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] and not IsPedRagdoll(ped) then
        RequestAnimDict("swimming@first_person@diving")
        while not HasAnimDictLoaded("swimming@first_person@diving") do
            Citizen.Wait(1)
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Citizen.Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, 0, 0, 0)
        end
    end
end