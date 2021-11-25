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

local isLoggedIn = false 

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('qb-casino:client:RedSell')
AddEventHandler('qb-casino:client:RedSell', function()
    TriggerServerEvent('qb-casino:server:RedSell')
end)

RegisterNetEvent('qb-casino:client:WhiteSell')
AddEventHandler('qb-casino:client:WhiteSell', function()
    TriggerServerEvent('qb-casino:server:WhiteSell')
end)

RegisterNetEvent('qb-casino:client:BlueSell')
AddEventHandler('qb-casino:client:BlueSell', function()
    TriggerServerEvent('qb-casino:server:BlueSell')
end)

RegisterNetEvent('qb-casino:client:BlackSell')
AddEventHandler('qb-casino:client:BlackSell', function()
    TriggerServerEvent('qb-casino:server:BlackSell')
end)

RegisterNetEvent('qb-casino:client:GoldSell')
AddEventHandler('qb-casino:client:GoldSell', function()
    TriggerServerEvent('qb-casino:server:GoldSell')
end)

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(948.237, 34.287, 71.839))
        if dist <= 3.0 then
            wait = 5
            inZone  = true
            text = '<b>Diamond Casino</b></p>Shop'

        else
            wait = 2000
        end

        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('drawtextui:ShowUI', 'show', text)
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('drawtextui:HideUI')
        end
        Citizen.Wait(wait)
    end
end)