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

PaycheckLoop = function()
    local Players = QBCore.Functions.GetPlayers()

    for i=1, #Players, 1 do
        local Player = QBCore.Functions.GetPlayer(Players[i])

        if Player.PlayerData.job ~= nil and Player.PlayerData.job.payment > 0 then
            Player.Functions.AddMoney('bank', Player.PlayerData.job.payment)
            TriggerClientEvent('QBCore:Notify', Players[i], "Du modtog din lønseddel "..Player.PlayerData.job.payment.." DKK")
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckLoop)
end
