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

CreateThread(function()
    while true do
        Wait(0)
        if LocalPlayer.state['isLoggedIn'] then
            Wait((1000 * 60) * QBCore.Config.UpdateInterval)
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(QBCore.Config.StatusInterval)
        if LocalPlayer.state['isLoggedIn'] then
            if QBCore.Functions.GetPlayerData().metadata['hunger'] <= 0 or
                QBCore.Functions.GetPlayerData().metadata['thirst'] <= 0 then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                SetEntityHealth(ped, currentHealth - math.random(5, 10))
            end
        end
    end
end)