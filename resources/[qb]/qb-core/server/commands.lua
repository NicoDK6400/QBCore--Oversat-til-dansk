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

QBCore.Commands = {}
QBCore.Commands.List = {}

function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission)
    if type(permission) == 'string' then
        permission = permission:lower()
    else
        permission = 'user'
    end
    QBCore.Commands.List[name:lower()] = {
        name = name:lower(),
        permission = permission,
        help = help,
        arguments = arguments,
        argsrequired = argsrequired,
        callback = callback
    }
end

function QBCore.Commands.Refresh(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local suggestions = {}
    if Player then
        for command, info in pairs(QBCore.Commands.List) do
            local isGod = QBCore.Functions.HasPermission(src, 'god')
            local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
            local isPrincipal = IsPlayerAceAllowed(src, 'command')
            if isGod or hasPerm or isPrincipal then
                suggestions[#suggestions+1] = {
                    name = '/' .. command,
                    help = info.help,
                    params = info.arguments
                }
            end
        end
        TriggerClientEvent('chat:addSuggestions', tonumber(source), suggestions)
    end
end

QBCore.Commands.Add("tp", "TP til spiller eller koords (Kun Admin)", {{name="id/x", help="ID af spiller eller X position"}, {name="y", help="Y position"}, {name="z", help="Z position"}}, false, function(source, args)
	if (args[1] ~= nil and (args[2] == nil and args[3] == nil)) then
		local player = GetPlayerPed(source)
		local target = GetPlayerPed(tonumber(args[1]))
		if target ~= 0 then
			local coords = GetEntityCoords(target)
			TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
		else
			TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
		end
	else
		if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
			local player = GetPlayerPed(source)
			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			if (x ~= 0) and (y ~= 0) and (z ~= 0) then
				TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
			else
				TriggerClientEvent('QBCore:Notify', source, "Forkert format", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', source, "Ikke alle argumenter er indtastet (x, y, z)", "error")
		end
	end
end, "admin")

QBCore.Commands.Add("addpermission", "Giv spiller permissions (Kun God)", {{name="id", help="ID af spiller"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
	else
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")	
	end		
end, "god")

QBCore.Commands.Add("removepermission", "Fjern spillers permissions (Kun God)", {{name="id", help="ID af spiller"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		QBCore.Functions.RemovePermission(Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")	
	end
end, "god")

QBCore.Commands.Add("car", "Spawn køretøj (Kun Admin)", {{name="model", help="Model navnet af køretøjet"}}, true, function(source, args)
	TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])	
end, "admin")

QBCore.Commands.Add("dv", "Fjern køretøj (Kun Admin)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, "admin")

QBCore.Commands.Add("tpm", "TP til markør (Kun Admin)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, "admin")

QBCore.Commands.Add("givemoney", "Giv spiller penge (Kun Admin)", {{name="id", help="Spiller ID"},{name="moneytype", help="Type af penge (cash, bank, crypto)"}, {name="amount", help="Mængde af penge"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
	end
end, "admin")

QBCore.Commands.Add("setmoney", "Angiv spillerens pengebeløb (Kun Admin)", {{name="id", help="Spiller ID"},{name="moneytype", help="Type af penge (cash, bank, crypto)"}, {name="amount", help="Mængde af penge"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
	end
end, "admin")

QBCore.Commands.Add("setjob", "Sæt en spillers job (Kun Admin)", {{name="id", help="Spiller ID"}, {name="job", help="Job navn"}, {name="grade", help="Grad"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player == nil then
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
	else
		Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
	end
end, "admin")

QBCore.Commands.Add("job", "Tjeck dit arbejde", {}, false, function(source, args)
	local PlayerJob = QBCore.Functions.GetPlayer(source).PlayerData.job
	TriggerClientEvent('QBCore:Notify', source, string.format("[Job]: %s [Grad]: %s [På job]: %s", PlayerJob.label, PlayerJob.grade.name, PlayerJob.onduty))
end)

QBCore.Commands.Add("setgang", "Sæt en spillers bande (Kun Admin)", {{name="id", help="Spiller ID"}, {name="gang", help="Navn på bande"}, {name="grade", help="Grad"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player == nil then
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
	else
		Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
	end
end, "admin")

QBCore.Commands.Add("gang", "Tjeck din bande", {}, false, function(source, args)
	local PlayerGang = QBCore.Functions.GetPlayer(source).PlayerData.gang
	TriggerClientEvent('QBCore:Notify', source, string.format("[Gang]: %s [Grad]: %s", PlayerGang.label, PlayerGang.grade.name))
end)

QBCore.Commands.Add("clearinv", "Ryd spillerens inventory (Kun Admin)", {{name="id", help="Spiller ID"}}, false, function(source, args)
	local playerId = args[1] ~= nil and args[1] or source
	local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
	if Player ~= nil then
		Player.Functions.ClearInventory()
	else
		TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
	end
end, "admin")

QBCore.Commands.Add('ooc', 'OOC Chat besked', {}, false, function(source, args)
    local src = source
    local message = table.concat(args, ' ')
    local Players = QBCore.Functions.GetPlayers()
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(Players) do
        if v == src then
			TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(src), message}
            })
        elseif #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(src), message}
            })
		elseif QBCore.Functions.HasPermission(v, 'admin') then
            if QBCore.Functions.IsOptin(v) then
				TriggerClientEvent('chat:addMessage', v, {
                    color = { 0, 0, 255},
                    multiline = true,
                    args = {'OOC | '.. GetPlayerName(src), message}
                })
                TriggerEvent('qb-log:server:CreateLog', 'ooc', 'OOC', 'white', '**' .. GetPlayerName(src) .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. src .. ') **Besked:** ' .. message, false)
            end
        end
    end
end, 'user')

-- Me command

QBCore.Commands.Add('me', 'Skriv dine me handlinger', {}, false, function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local pCoords = GetEntityCoords(ped)
    local msg = table.concat(args, " ")
    if msg == "" then return end
    for k,v in pairs(QBCore.Functions.GetPlayers()) do
        local target = GetPlayerPed(v)
        local tCoords = GetEntityCoords(target)
        if #(pCoords - tCoords) < 20 then
            TriggerClientEvent("QBCore:Command:ShowMe3D", v, src, msg)
        end
    end
end, "user")
