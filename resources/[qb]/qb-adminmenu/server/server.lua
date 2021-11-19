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
local QBCore = exports['qb-core']:GetCoreObject()
local frozen = false
local permissions = {
    ['kill'] = 'god',
    ['ban'] = 'admin',
    ['noclip'] = 'admin',
    ['kickall'] = 'admin',
    ['kick'] = 'admin'
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
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        }
    end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(players, function(a, b)
            return a.id < b.id
        end)
        ------
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    local src = source
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions

local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Events

RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
        }
    end
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s fik et kick af %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        DropPlayer(player.id, 'Du har modtaget et kick:\n' .. reason .. '\n\n🔸 Se Discord for mere information: ' .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
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
            template = "<div class=chat-message server'><strong>ANNONCERING | {0} er blev banned:</strong> {1}</div>",
            args = {GetPlayerName(player.id), reason}
        })
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s blev banned af %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        if banTime >= 2147483647 then
            DropPlayer(player.id, 'Du er blevet banned:\n' .. reason .. '\n\nDit ban er permanent.\n🔸 Se Discord for mere information: ' .. QBCore.Config.Server.discord)
        else
            DropPlayer(player.id, 'Du er blevet banned:\n' .. reason .. '\n\nBan udløber om: ' .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
        end
    end
end)

RegisterNetEvent('qb-admin:server:spectate')
AddEventHandler('qb-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent('qb-admin:server:freeze')
AddEventHandler('qb-admin:server:freeze', function(player)
    local target = GetPlayerPed(player.id)
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
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
            TriggerClientEvent('QBCore:Notify', src, 'Steg i bilen', 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Køretøjet har ingen ledige sæder!', 'danger', 5000)
        end
    end
end)


RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    SetEntityCoords(target, coords)
end)

RegisterNetEvent('qb-admin:server:inventory', function(player)
    local src = source
    TriggerClientEvent('qb-admin:client:inventory', src, player.id)
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    TriggerClientEvent('qb-clothing:client:openMenu', player.id)
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, 'Dit permission level er nu '..group[1].label)
    end
end)

RegisterNetEvent('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                multiline = true,
                args = {'Admin Report - '..name..' ('..targetSrc..')', msg}
            })
        end
    end
end)

RegisterNetEvent('qb-admin:server:Staffchat:addMessage', function(name, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, 'STAFFCHAT - '..name, 'error', msg)
        end
    end
end)

RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
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
        TriggerClientEvent('QBCore:Notify', src, 'Dette køretøj er allerede dit..', 'error', 3000)
    end
end)

-- Commands

QBCore.Commands.Add('blips', 'Vis blips på spillere (Kun admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('names', 'Vis spiller navne over hoveder (Kun admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('coords', 'Slå coords til/fra (Kun admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'admin')

QBCore.Commands.Add('noclip', 'Noclip til/fra (Kun admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end, 'admin')

QBCore.Commands.Add('admincar', 'Gem køretøj i din garage (Kun admin)', {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, 'admin')

QBCore.Commands.Add('announce', 'Lav en annoncering (Kun admin)', {}, false, function(source, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end, 'admin')

QBCore.Commands.Add('admin', 'Åbn admin menu (Kun admin)', {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, 'admin')

QBCore.Commands.Add('report', 'Admin Report', {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

QBCore.Commands.Add('staffchat', 'Send en besked til alle staff (Kun admin)', {{name='message', help='Besked'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, 'admin')

QBCore.Commands.Add('givenuifocus', 'Giv en spiller NUI focus (Kun admin)', {{name='id', help='Spiller ID'}, {name='focus', help='Sæt focus på/fra'}, {name='mouse', help='Sæt mus til/fra'}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

QBCore.Commands.Add('warn', 'Giv en advarsel (Kun admin)', {{name='ID', help='Spiller'}, {name='Reason', help='Skriv et grundlag'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local myName = senderPlayer.PlayerData.name
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
        --TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, 'SYSTEM', 'error', 'You have been warned by: '..GetPlayerName(source)..', Reason: '..msg)
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", "^8ADVARSEL ^7 Du har fået en advarsel af"..GetPlayerName(source)..", Grund: "..msg }, color = 255, 0, 0 })
        --TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'error', 'You have warned '..GetPlayerName(targetPlayer.PlayerData.source)..' for: '..msg)
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", "^8ADVARSEL ^7 Du har givet en advarsel til "..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        exports.oxmysql:insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, 'Denne spiller er ikke online', 'error')
    end
end, 'admin')

QBCore.Commands.Add('checkwarns', 'Tjek spillers advarsler (Kun admin)', {{name='id', help='Spiller'}, {name='Warning', help='Antal advarsler, (1, 2 or 3 eks..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' har '..tablelength(result)..' advarsler!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' har fået en advarsel af '..sender.PlayerData.name..', Grundlag: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')

QBCore.Commands.Add('delwarn', 'Slet spiller advarsler (Kun admin)', {{name='id', help='Spiller'}, {name='Warning', help='Antal advarsler, (1, 2 or 3 eks..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'Du har slettet en advarsel ('..selectedWarning..') , Grundlag: '..warnings[selectedWarning].reason)
        exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')

QBCore.Commands.Add('reportr', 'Svar på report (Kun admin)', {{name='id', help='Spiller'}, {name = 'message', help = 'Besked at svare med'}}, false, function(source, args, rawCommand)
    local src = source
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Spiller ikke online', 'error') end
    if not QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin svar', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report svar ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Svar sendt')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')

QBCore.Commands.Add('setmodel', 'Ændre Ped model (Kun admin)', {{name='model', help='Navn på model'}, {name='id', help='Id på spiller (tom for dig selv)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, 'Denne spiller er ikke online..', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Du har ingen model valgt..', 'error')
    end
end, 'admin')

QBCore.Commands.Add('setspeed', 'Sæt spiller til gang hastighed (Kun admin)', {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, 'Du har ingen fart angivet.. (`fast` for super-run, `normal` for normal)', 'error')
    end
end, 'admin')

QBCore.Commands.Add('reporttoggle', 'Slå reports fra/til (Kun admin)', {}, false, function(source, args)
    local src = source
    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, 'Du modtager reports', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Du modtager ingen reports', 'error')
    end
end, 'admin')

QBCore.Commands.Add('kickall', 'Kick alle', {}, false, function(source, args)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if not reason then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Ingen grund givet', 'error')
            end
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, 'Server restart, se Discord for mere information: ' .. QBCore.Config.Server.discord)
            end
        end
    end
end, 'god')

QBCore.Commands.Add('setammo', 'Spawn ammo (Kun admin)', {{name='amount', help='Mængde af skud, f.eks.: 20'}, {name='weapon', help='Navn på våben, f.eks.: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end, 'admin')