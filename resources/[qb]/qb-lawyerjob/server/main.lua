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

QBCore.Commands.Add("setlawyer", "Register nogen som advokat", {{name="id", help="Id af spilleren"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then 
            local lawyerInfo = {
                id = math.random(100000, 999999),
                firstname = OtherPlayer.PlayerData.charinfo.firstname,
                lastname = OtherPlayer.PlayerData.charinfo.lastname,
                citizenid = OtherPlayer.PlayerData.citizenid,
            }
            OtherPlayer.Functions.SetJob("lawyer", 0)
            OtherPlayer.Functions.AddItem("lawyerpass", 1, false, lawyerInfo)
            TriggerClientEvent("QBCore:Notify", source, "Du har " .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. " ansat som advokat")
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "Du er nu advokat")
            TriggerClientEvent('inventory:client:ItemBox', OtherPlayer.PlayerData.source, QBCore.Shared.Items["lawyerpass"], "add")
        else
            TriggerClientEvent("QBCore:Notify", source, "Personen er tilgængelig", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Du er ikke advokat.", "error")
    end
end)

QBCore.Commands.Add("removelawyer", "Fjern nogen som advokat", {{name="id", help="ID af spilleren"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then
	    OtherPlayer.Functions.SetJob("unemployed", 0)
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "Du er nu arbejdsløs")
            TriggerClientEvent("QBCore:Notify", source, "Du har " .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. "fyret som advokat")
        else
            TriggerClientEvent("QBCore:Notify", source, "Personen er ikke tilgængelig", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Du er ikke advokat..", "error")
    end
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-justice:client:showLawyerLicense", -1, source, item.info)
    end
end)
