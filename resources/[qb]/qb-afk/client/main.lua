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

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1800

local group = "user"
local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-afkkick:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate')
AddEventHandler('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

-- Code
Citizen.CreateThread(function()
	while true do
		Wait(1000)
        playerPed = PlayerPedId()
        if isLoggedIn then
            if group == "user" then
                currentPos = GetEntityCoords(playerPed, true)
                if prevPos ~= nil then
                    if currentPos == prevPos then
                        if time ~= nil then
                            if time > 0 then
                                if time == (900) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (600) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (300) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (150) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)   
                                elseif time == (60) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minut!', 'error', 10000) 
                                elseif time == (30) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)  
                                elseif time == (20) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)    
                                elseif time == (10) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)                                                                                                            
                                end
                                time = time - 1
                            else
                                TriggerServerEvent("KickForAFK")
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)