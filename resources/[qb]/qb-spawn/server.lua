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

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-spawn:server:getOwnedHouses', function(source, cb, cid)
    if cid ~= nil then
        local houses = exports.oxmysql:executeSync('SELECT * FROM player_houses WHERE citizenid = ?', {cid})
        if houses[1] ~= nil then
            cb(houses)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)