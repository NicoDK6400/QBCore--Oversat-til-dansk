-- StarBlazt Chat

QBCore = nil

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end

	while QBCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = QBCore.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = QBCore.GetPlayerData()
	end
end)


RegisterCommand('112', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent('chat:server:911source', source, caller, msg)
    TriggerServerEvent('911', source, caller, msg)
end, false)

RegisterCommand('114', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent(('chat:server:311source'), source, caller, msg)
    TriggerServerEvent('311', source, caller, msg)
end, false)


RegisterNetEvent('chat:EmergencySend911r')
AddEventHandler('chat:EmergencySend911r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">112s {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend311r')
AddEventHandler('chat:EmergencySend311r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">114s {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend911')
AddEventHandler('chat:EmergencySend911', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">112 {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend311')
AddEventHandler('chat:EmergencySend311', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">114 {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterCommand('112s', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:911r'), target, source, msg)
        TriggerServerEvent('911r', target, source, msg)
    end
end, false)

RegisterCommand('114s', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then 
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:311r'), target, source, msg)
        TriggerServerEvent('311r', target, source, msg)
    end
end, false)

