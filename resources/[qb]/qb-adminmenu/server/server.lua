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

-- Variables
local frozen = false
local permissions = {
    ["kill"] = "god",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
    ["kick"] = "admin"
}

-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(source, cb)
    cb(exports['qb-drugs']:GetDealers())
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        table.insert(players, {
            name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname .. " | (" .. GetPlayerName(v) .. ")",
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        })
    end
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    if QBCore.Functions.HasPermission(source, "god") then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions

function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Events

RegisterServerEvent('qb-admin:server:GetPlayersForBlips')       
AddEventHandler('qb-admin:server:GetPlayersForBlips', function()
    local src = source					                        
    local players = {}                                          
    for k, v in pairs(QBCore.Functions.GetPlayers()) do         
        local targetped = GetPlayerPed(v)                       
        local ped = QBCore.Functions.GetPlayer(v)             
        table.insert(players, {                             
            name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname .. " | (" .. GetPlayerName(v) .. ")",
            id = v,                                      
            coords = GetEntityCoords(targetped),             
            cid = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,            
            sources = GetPlayerPed(ped.PlayerData.source),    
            sourceplayer= ped.PlayerData.source              
        })                                                  
    end                                                  
    TriggerClientEvent('qb-admin:client:Show', src, players)  
end)

RegisterNetEvent("qb-admin:server:kill")
AddEventHandler("qb-admin:server:kill", function(player)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent("qb-admin:server:revive")
AddEventHandler("qb-admin:server:revive", function(player)
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent("qb-admin:server:kick")
AddEventHandler("qb-admin:server:kick", function(player, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kick"]) then
        TriggerEvent("qb-log:server:CreateLog", "bans", "Spiller kicked", "red", string.format('%s blev kicked af %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        DropPlayer(player.id, "Du har modtaget et server kick:\n" .. reason .. "\n\nFor mere information se Discord: " .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent("qb-admin:server:ban")
AddEventHandler("qb-admin:server:ban", function(player, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["ban"]) then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        exports.oxmysql:insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            QBCore.Functions.GetIdentifier(player.id, 'license'),
            QBCore.Functions.GetIdentifier(player.id, 'discord'),
            QBCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message server"><strong>ANNOUNCEMENT | {0} er blevet banned:</strong> {1}</div>',
            args = {GetPlayerName(player.id), reason}
        })
        TriggerEvent("qb-log:server:CreateLog", "bans", "Spiller banned", "red", string.format('%s var banned af %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        if banTime >= 2147483647 then
            DropPlayer(player.id, "Du er blevet banned:\n" .. reason .. "\n\nDit ban er permanent.\nFor mere information se Discord: " .. QBCore.Config.Server.discord)
        else
            DropPlayer(player.id, "Du er blevet banned:\n" .. reason .. "\n\nBan udløber: " .. timeTable["day"] .. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"] .. ":" .. timeTable["min"] .. "\nFor mere information se Discord : " .. QBCore.Config.Server.discord)
        end
    end
end)

RegisterNetEvent("qb-admin:server:spectate")
AddEventHandler("qb-admin:server:spectate", function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent("qb-admin:server:freeze")
AddEventHandler("qb-admin:server:freeze", function(player)
    local target = GetPlayerPed(player.id)
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('qb-admin:server:goto')
AddEventHandler('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:intovehicle')
AddEventHandler('qb-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    -- local coords = GetEntityCoords(GetPlayerPed(player.id))
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed,false)
    local seat = -1
    if vehicle ~= 0 then
        for i=0,8,1 do
            if GetPedInVehicleSeat(vehicle,i) == 0 then
                seat = i
                break
            end
        end
        if seat ~= -1 then
            SetPedIntoVehicle(admin,vehicle,seat)
            TriggerClientEvent('QBCore:Notify', src, 'Steg ind', 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Dette køretøj har ikke flere ledige pladser!', 'danger', 5000)
        end
    end
end)


RegisterNetEvent('qb-admin:server:bring')
AddEventHandler('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    SetEntityCoords(target, coords)
end)

RegisterNetEvent("qb-admin:server:inventory")
AddEventHandler("qb-admin:server:inventory", function(player)
    local src = source
    TriggerClientEvent('qb-admin:client:inventory', src, player.id)
end)

RegisterNetEvent("qb-admin:server:cloth")
AddEventHandler("qb-admin:server:cloth", function(player)
    TriggerClientEvent("qb-clothing:client:openMenu", player.id)
end)

RegisterServerEvent('qb-admin:server:setPermissions')
AddEventHandler('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    if QBCore.Functions.HasPermission(src, "god") then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, 'Dit permission level er nu '..group[1].label)
    end
end)

RegisterServerEvent('qb-admin:server:SendReport')
AddEventHandler('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "REPORT - "..name.." ("..targetSrc..")", "report", msg)
        end
    end
end)

RegisterServerEvent('qb-admin:server:StaffChatMessage')
AddEventHandler('qb-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "STAFFCHAT - "..name, "error", msg)
        end
    end
end)

RegisterServerEvent('qb-admin:server:SaveCar')
AddEventHandler('qb-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:fetchSync('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result[1] == nil then
        exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, 'Køretøjet er nu dit!', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Køretøjet ejer du allerede..', 'error', 3000)
    end
end)

-- Commands

QBCore.Commands.Add("blips", "Vis blips på spillere (Kun Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:toggleBlips', source)
end, "admin")

QBCore.Commands.Add("names", "Vis spillernes navn over hovedet (Kun Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:toggleNames', source)
end, "admin")

QBCore.Commands.Add("coords", "Vis koords til udvikling (Kun Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:ToggleCoords', source)
end, "admin")

QBCore.Commands.Add("admincar", "Sæt køretøj i garage (Kun Admin)", {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, "admin")

QBCore.Commands.Add("announce", "Lav en reklame (Kun Admin)", {}, false, function(source, args)
    local msg = table.concat(args, " ")
    for i = 1, 3, 1 do
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", msg)
    end
end, "admin")

QBCore.Commands.Add("admin", "Åben Admin Menu (Kun Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, "admin")

QBCore.Commands.Add("report", "Admin Report", {{name="message", help="Besked"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerClientEvent('chatMessage', source, "REPORT Send", "normal", msg)
    TriggerEvent("qb-log:server:CreateLog", "report", "Report", "green", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Report:** " ..msg, false)
end)

QBCore.Commands.Add("staffchat", "Send en besked til staff (Kun Admin)", {{name="message", help="Besked"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("givenuifocus", "Giv en spiller NUI focus (Kun Admin)", {{name="id", help="Spiller id"}, {name="focus", help="Sæt focus til/fra"}, {name="mouse", help="Sæt mus til/fra"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

QBCore.Commands.Add("warn", "Giv en advarsel (Kun Admin)", {{name="ID", help="Spiller"}, {name="Reason", help="Nævn en spiller"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local myName = senderPlayer.PlayerData.name
    local warnId = "WARN-"..math.random(1111, 9999)
    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "Du har modtaget et warn af: "..GetPlayerName(source)..", Begundelse: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Du gav et warn til "..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg)
        exports.oxmysql:insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, 'Spiller ikke online', 'error')
    end
end, "admin")

QBCore.Commands.Add("checkwarns", "Tjek spiller for warns (Kun Admin)", {{name="ID", help="Spiller"}, {name="Warning", help="Antal warns, (1, 2 or 3 eks..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = exports.oxmysql:fetchSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." har "..tablelength(result).." warns!")
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = exports.oxmysql:fetchSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." har fået et warn "..sender.PlayerData.name..", Begrundelse: "..warnings[selectedWarning].reason)
        end
    end
end, "admin")

QBCore.Commands.Add("delwarn", "Delete Players Warnings (Kun Admin)", {{name="ID", help="Spiller"}, {name="Warning", help="Antal warns, (1, 2 or 3 eks..)"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = exports.oxmysql:fetchSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "Du har slettet et warn ("..selectedWarning..") , Begrundelse: "..warnings[selectedWarning].reason)
        exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, "admin")

QBCore.Commands.Add("reportr", "Svar på en report (Kun Admin)", {}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local Player = QBCore.Functions.GetPlayer(source)
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', playerId, "ADMIN - "..GetPlayerName(source), "warning", msg)
        TriggerClientEvent('QBCore:Notify', source, "Svar sendt")
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if QBCore.Functions.HasPermission(v, "admin") then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chatMessage', v, "REPORT REPLY ("..source..") - "..GetPlayerName(source), "warning", msg)
                    TriggerEvent("qb-log:server:CreateLog", "report", "Svar på report", "red", "**"..GetPlayerName(source).."** svarede på: **"..OtherPlayer.PlayerData.name.. " **(ID: "..OtherPlayer.PlayerData.source..") **Besked:** " ..msg, false)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online", "error")
    end
end, "admin")

QBCore.Commands.Add("setmodel", "Ændre Ped model (Kun Admin)", {{name="model", help="Navn på Ped"}, {name="id", help="ID på spilleren (tom for dig selv)"}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, "Spiller ikke online..", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Du angav ikke en model..", "error")
    end
end, "admin")

QBCore.Commands.Add("setspeed", "Sæt gang hastighed (Kun Admin)", {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, "Du angav ikke hastighed.. (`fast` for super-run, `normal` for normal)", "error")
    end
end, "admin")

QBCore.Commands.Add("reporttoggle", "Slå report til/fra (Kun Admin)", {}, false, function(source, args)
    QBCore.Functions.ToggleOptin(source)
    if QBCore.Functions.IsOptin(source) then
        TriggerClientEvent('QBCore:Notify', source, "Du modtager reports", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "Du modtager ikke reports", "error")
    end
end, "admin")

RegisterCommand("kickall", function(source, args, rawCommand)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        local Player = QBCore.Functions.GetPlayer(src)

        if QBCore.Functions.HasPermission(src, "god") then
            if args[1] ~= nil then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player ~= nil then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'Angiv en beggrundelse..')
            end
        else
            TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'Du kan ikke gøre dette..')
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then
                DropPlayer(Player.PlayerData.source, "Server restart, se vores Discord for mere information: " .. QBCore.Config.Server.discord)
            end
        end
    end
end, false)

QBCore.Commands.Add("setammo", "Angiv mændge af skud (Kun Admin)", {{name="amount", help="Antal skud, for eksempel: 20"}, {name="weapon", help="Navnet på våbnet, for eksempel: WEAPON_VINTAGEPISTOL"}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, "current", amount)
    end
end, 'admin')
