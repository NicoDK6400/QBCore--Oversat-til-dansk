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

local notInteressted = false

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if not notInteressted then
            for k, v in pairs(QBDiving.SellLocations) do
                local dist = #(pos - vector3(v["coords"]["x"], v["coords"]["y"], v["coords"]["z"]))

                if dist < 20 then
                    inRange = true
                    if dist < 1 then
                        DrawText3D(v["coords"]["x"], v["coords"]["y"], v["coords"]["z"] - 0.1, '~g~G~w~ - Sælg koraller')
                        if IsControlJustPressed(0, 47) then
                            LocalPlayer.state:set("inv_busy", true, true)
                            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_coral_items", "Samler koraller fra lommen", math.random(2000, 4000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('qb-diving:server:SellCoral')
                                notInteressted = true
                                SetTimeout(0, ClearTimeOut)
                                LocalPlayer.state:set("inv_busy", false, true)
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                                QBCore.Functions.Notify("Afbrudt..", "error")
                                LocalPlayer.state:set("inv_busy", false, true)
                            end)
                        end
                    end
                end
            end
        else
            Citizen.Wait(5000)
        end

        if not inRange then
            Citizen.Wait(1500)
        end

        Citizen.Wait(3)
    end
end)

function ClearTimeOut()
    notInteressted = not notInteressted
end
