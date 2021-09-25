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

RegisterServerEvent('qb-radialmenu:server:RemoveStretcher')
AddEventHandler('qb-radialmenu:server:RemoveStretcher', function(PlayerPos, StretcherObject)
    TriggerClientEvent('qb-radialmenu:client:RemoveStretcherFromArea', -1, PlayerPos, StretcherObject)
end)

RegisterServerEvent('qb-radialmenu:Stretcher:BusyCheck')
AddEventHandler('qb-radialmenu:Stretcher:BusyCheck', function(id, type)
    local MyId = source
    TriggerClientEvent('qb-radialmenu:Stretcher:client:BusyCheck', id, MyId, type)
end)

RegisterServerEvent('qb-radialmenu:server:BusyResult')
AddEventHandler('qb-radialmenu:server:BusyResult', function(IsBusy, OtherId, type)
    TriggerClientEvent('qb-radialmenu:client:Result', OtherId, IsBusy, type)
end)
