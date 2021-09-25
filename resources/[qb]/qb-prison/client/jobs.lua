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

local currentLocation = 0 
currentBlip = nil
local isWorking = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if inJail and currentJob ~= nil then 
            if currentLocation ~= 0 then
                if not DoesBlipExist(currentBlip) then
                    CreateJobBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 200, 50, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1 and not isWorking then
                        isWorking = true
                        QBCore.Functions.Progressbar("work_electric", "Arbejder med elektricitet..", math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            JobDone()
                        end, function() -- Cancel
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            QBCore.Functions.Notify("Afbrudt..", "error")
                        end)
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreateJobBlip()
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

function JobDone()
    if math.random(1, 100) <= 50 then
        QBCore.Functions.Notify("Du har arbejdet noget tid af din afsogning")
        jailTime = jailTime - math.random(1, 2)
    end
    local newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    while (newLocation == currentLocation) do
        Citizen.Wait(100)
        newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    end
    currentLocation = newLocation
    CreateJobBlip()
end

function CreateJobBlip()
    if currentLocation ~= 0 then
        if DoesBlipExist(currentBlip) then
            RemoveBlip(currentBlip)
        end
        currentBlip = AddBlipForCoord(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)

        SetBlipSprite (currentBlip, 402)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale  (currentBlip, 0.8)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Jobs[currentJob])
        EndTextCommandSetBlipName(currentBlip)

        local Chance = math.random(100)
        local Odd = math.random(100)
        if Chance == Odd then
            TriggerServerEvent('QBCore:Server:AddItem', 'phone', 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["phone"], "add")
            QBCore.Functions.Notify("Du fandt en mobil..", "success")
        end
    end
end
