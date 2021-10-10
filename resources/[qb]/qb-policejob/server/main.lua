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

local Plates = {}
local cuffedPlayers = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

RegisterServerEvent('police:server:TakeOutImpound')
AddEventHandler('police:server:TakeOutImpound', function(plate)
    local src = source
    exports.oxmysql:execute('UPDATE player_vehicles SET state = ? WHERE plate  = ?', {0, plate})
    TriggerClientEvent('QBCore:Notify', src, "Køretøjet er blevet taget ud af impound!")
end)

RegisterServerEvent('police:server:CuffPlayer')
AddEventHandler('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer ~= nil then
        if Player.Functions.GetItemByName("handcuffs") ~= nil or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source,
                isSoftcuff)
        end
    end
end)

RegisterServerEvent('police:server:EscortPlayer')
AddEventHandler('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or
            Player.PlayerData.job.name == "doctor") or
            (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or
                EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Personen er ikke død eller i håndjern!")
        end
    end
end)

RegisterServerEvent('police:server:KidnapPlayer')
AddEventHandler('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or
            EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source,
                Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source,
                EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Personen er ikke død eller i håndjern!")
        end
    end
end)

RegisterServerEvent('police:server:SetPlayerOutVehicle')
AddEventHandler('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Personen er ikke død eller i håndjern!")
        end
    end
end)

RegisterServerEvent('police:server:PutPlayerInVehicle')
AddEventHandler('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Personen er ikke død eller i håndjern!")
        end
    end
end)

RegisterServerEvent('police:server:BillPlayer')
AddEventHandler('police:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "police" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerEvent('qb-bossmenu:server:addAccountMoney', "police", price)
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "Du modtager en bøde på " .. price..' DKK')
        end
    end
end)

RegisterServerEvent('police:server:JailPlayer')
AddEventHandler('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    if Player.PlayerData.job.name == "police" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('QBCore:Notify', src, "Du har sendt personen i fængsel for " .. time .. " måneder")
        end
    end
end)

RegisterServerEvent('police:server:SetHandcuffStatus')
AddEventHandler('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
    end
end)

RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
    local serverID = source
    TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterServerEvent('police:server:FlaggedPlateTriggered')
AddEventHandler('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
    local src = source
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                if street2 ~= nil then
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1 .. " " .. street2
                    }, blipSettings)
                else
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1
                    }, blipSettings)
                end
            end
        end
    end
end)

RegisterServerEvent('police:server:PoliceAlertMessage')
AddEventHandler('police:server:PoliceAlertMessage', function(title, streetLabel, coords)
    local src = source

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            end
        end
    end
end)

RegisterServerEvent('police:server:GunshotAlert')
AddEventHandler('police:server:GunshotAlert', function(streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
    local src = source

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("police:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic,
                    fromVehicle, coords, vehicleInfo)
            elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
                TriggerClientEvent("police:client:GunShotAlert", Player.PlayerData.source, streetLabel, isAutomatic,
                    fromVehicle, coords, vehicleInfo)
            end
        end
    end
end)

RegisterServerEvent('police:server:VehicleCall')
AddEventHandler('police:server:VehicleCall', function(pos, msg, alertTitle, streetLabel, modelPlate, modelName)
    local src = source
    local alertData = {
        title = "Biltyveri",
        coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z
        },
        description = msg
    }
    TriggerClientEvent("police:client:VehicleCall", -1, pos, alertTitle, streetLabel, modelPlate, modelName)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:HouseRobberyCall')
AddEventHandler('police:server:HouseRobberyCall', function(coords, message, gender, streetLabel)
    local src = source
    local alertData = {
        title = "Indbrud",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = message
    }
    TriggerClientEvent("police:client:HouseRobberyCall", -1, coords, message, gender, streetLabel)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:SendEmergencyMessage')
AddEventHandler('police:server:SendEmergencyMessage', function(coords, message)
    local src = source
    local MainPlayer = QBCore.Functions.GetPlayer(src)
    local alertData = {
        title = "112 opkald - " .. MainPlayer.PlayerData.charinfo.firstname .. " " ..
            MainPlayer.PlayerData.charinfo.lastname .. " (" .. src .. ")",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = message
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:server:SendEmergencyMessageCheck', -1, MainPlayer, message, coords)
end)

RegisterServerEvent('police:server:SearchPlayer')
AddEventHandler('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning",
            "Personen har " .. SearchedPlayer.PlayerData.money["cash"] .. ",- DKK af penge på sig..")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Du bliver kropsvisiteret..")
    end
end)

RegisterServerEvent('police:server:SeizeCash')
AddEventHandler('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = {
            cash = moneyAmount
        }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Dine penge er blevet konfiskeret..")
    end
end)

RegisterServerEvent('police:server:SeizeDriverLicense')
AddEventHandler('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
        if driverLicense then
            local licenses = {
                ["driver"] = false,
                ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
            }
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source,
                "Dit kørerkort og førerret er blevet frataget dig..")
        else
            TriggerClientEvent('QBCore:Notify', src, "Kan ikke indrage førerret..", "error")
        end
    end
end)

RegisterServerEvent('police:server:RobPlayer')
AddEventHandler('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Du er blevet røvet for " .. money.." DKK")
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, "Du stajl " .. money.." DKK")
    end
end)

RegisterServerEvent('police:server:UpdateBlips')
AddEventHandler('police:server:UpdateBlips', function()
    -- KEEP FOR REF BUT NOT NEEDED ANYMORE.
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        UpdateBlips()
    end
end)

function UpdateBlips()

    local dutyPlayers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or
                Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then

                local coords = GetEntityCoords(GetPlayerPed(Player.PlayerData.source))
                local heading = GetEntityHeading(GetPlayerPed(Player.PlayerData.source))

                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name,
                    location = {
                        x = coords.x,
                        y = coords.y,
                        z = coords.z,
                        w = heading
                    }
                })
            end
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)

end

RegisterServerEvent('police:server:spawnObject')
AddEventHandler('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, src)
end)

RegisterServerEvent('police:server:deleteObject')
AddEventHandler('police:server:deleteObject', function(objectId)
    local src = source
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterServerEvent('police:server:Impound')
AddEventHandler('police:server:Impound', function(plate, fullImpound, price, body, engine, fuel)
    local src = source
    local price = price ~= nil and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            exports.oxmysql:execute(
                'UPDATE player_vehicles SET state = ?, depotprice = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {0, price, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Køretøj sat i depot for " .. price .. " DKK!")
        else
            exports.oxmysql:execute(
                'UPDATE player_vehicles SET state = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {2, body, engine, fuel, plate})
            TriggerClientEvent('QBCore:Notify', src, "Køretøj blev konfiskeret!")
        end
    end
end)

RegisterServerEvent('evidence:server:UpdateStatus')
AddEventHandler('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterServerEvent('evidence:server:CreateBloodDrop')
AddEventHandler('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local src = source
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterServerEvent('evidence:server:CreateFingerDrop')
AddEventHandler('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterServerEvent('evidence:server:ClearBlooddrops')
AddEventHandler('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList ~= nil and next(blooddropList) ~= nil then
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddBlooddropToInventory')
AddEventHandler('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du skal have en tom bevispose med dig", "error")
    end
end)

RegisterServerEvent('evidence:server:AddFingerprintToInventory')
AddEventHandler('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du skal have en tom bevispose med dig", "error")
    end
end)

RegisterServerEvent('evidence:server:CreateCasing')
AddEventHandler('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo ~= nil then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem ~= nil then
            if weaponItem.info ~= nil and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterServerEvent('police:server:UpdateCurrentCops')
AddEventHandler('police:server:UpdateCurrentCops', function()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterServerEvent('evidence:server:ClearCasings')
AddEventHandler('evidence:server:ClearCasings', function(casingList)
    if casingList ~= nil and next(casingList) ~= nil then
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddCasingToInventory')
AddEventHandler('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du skal have en tom bevispose med dig", "error")
    end
end)

RegisterServerEvent('police:server:showFingerprint')
AddEventHandler('police:server:showFingerprint', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(playerId)

    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterServerEvent('police:server:showFingerprintId')
AddEventHandler('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]

    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

RegisterServerEvent('police:server:SetTracker')
AddEventHandler('police:server:SetTracker', function(targetId)
    local Target = QBCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('QBCore:Notify', targetId, 'fodlænke blev fjernet.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', source,
            'Du tog en fodlænke af ' .. Target.PlayerData.charinfo.firstname .. " " ..
                Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('QBCore:Notify', targetId, 'Du fik en fodlænke på.', 'error', 5000)
        TriggerClientEvent('QBCore:Notify', source, 'Du tog en fodlænke på ' ..
            Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterServerEvent('police:server:SendTrackerLocation')
AddEventHandler('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = QBCore.Functions.GetPlayer(source)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    local msg =
        "Lokationen af " .. Target.PlayerData.charinfo.firstname .. " " .. Target.PlayerData.charinfo.lastname ..
            " er nu på dit kort."

    local alertData = {
        title = "Fodlænke lokation",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }

    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

RegisterServerEvent('police:server:SendPoliceEmergencyAlert')
AddEventHandler('police:server:SendPoliceEmergencyAlert', function(streetLabel, coords, callsign)
    local data = {
        displayCode = 10-99,
        description = "Nødknappen er blevet trykket: ".. callsign .. " ved "..streetLabel,
        isImportant = 1,
        recipientList = {'police'},
        length = '10000',
        infoM = 'fa-info-circle',
        info = 'Kalder alle enheder!',
    }
    local dispatchData = {
        title = 'Kalder alle enheder!',
        description = "Nødknappen er blevet trykket: ".. callsign .. " ved "..streetLabel,
        dispatchData = data,
        caller = callsign,
        coords = coords
    }
    TriggerEvent('wf-alerts:svNotify', dispatchData)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, dispatchData)
end)

QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player ~= nil then
        if PlayerStatus[Player.PlayerData.source] ~= nil and next(PlayerStatus[Player.PlayerData.source]) ~= nil then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                table.insert(statList, PlayerStatus[Player.PlayerData.source][k].text)
            end
        end
    end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo ~= nil then
        if itemInfo.info ~= nil and itemInfo.info.attachments ~= nil then
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") and
                Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name
                })
            end
        end
    end
    cb(dutyPlayers)
end)

function CreateBloodId()
    if BloodDrops ~= nil then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[caseId] ~= nil do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

function CreateFingerId()
    if FingerDrops ~= nil then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[caseId] ~= nil do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

function CreateCasingId()
    if Casings ~= nil then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] ~= nil do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

function CreateObjectId()
    if Objects ~= nil then
        local objectId = math.random(10000, 99999)
        while Objects[caseId] ~= nil do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

function IsVehicleOwned(plate)
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

QBCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    exports.oxmysql:fetch('SELECT * FROM player_vehicles WHERE state = ?', {2}, function(result)
        if result[1] ~= nil then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

QBCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    if Plates ~= nil and Plates[plate] ~= nil then
        if Plates[plate].isflagged then
            retval = true
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

--[[ QBCore.Commands.Add("setpolice", "Hire An Officer (Kun Politi)", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("police")
        end
    end
end) ]]

QBCore.Commands.Add("spikestrip", "Smid sømmåtte (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
            TriggerClientEvent('police:client:SpawnSpikeStrip', source)
        end
    end
end)

QBCore.Commands.Add("grantlicense", "Giv en licens til en person", {{
    name = "id",
    help = "ID af spilleren"
}, {
    name = "license",
    help = "Licens type"
}}, true, function(source, args)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer ~= nil then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = true
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Du har fået en licens",
                    "success", 5000)
                TriggerClientEvent('QBCore:Notify', source, "Du har fået en licens", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Ugyldig licens type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Du skal være en sergent for at give licenser!", "error")
    end
end)

QBCore.Commands.Add("revokelicense", "Fratag en licens fra en spiller", {{
    name = "id",
    help = "ID af personen"
}, {
    name = "license",
    help = "Licens type"
}}, true, function(source, args)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if SearchedPlayer ~= nil then
                local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
                licenseTable[args[2]] = false
                SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "Du er blevet frataget en licens",
                    "error", 5000)
                TriggerClientEvent('QBCore:Notify', source, "Du fratog en licens", "success", 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Ugyldig licens type", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Du skal være en sergent for at give licenser!", "error")
    end
end)

--[[ QBCore.Commands.Add("firepolice", "Fire An Officer (Kun Politi)", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.job.name == "police" and Myself.PlayerData.job.onduty) and IsHighCommand(Myself.PlayerData.citizenid) then
            Player.Functions.SetJob("unemployed")
        end
    end
end) ]]

function IsHighCommand(citizenid)
    local retval = false
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Player.PlayerData.job.grade.level >= 3 then
        retval = true
    end
    return retval
end

QBCore.Commands.Add("pobject", "Tilføj/fjen et objekt (Kun Politi)", {{
    name = "type",
    help = "Type objekt du vil 'fjerne' for at fjerne"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" then
        if type == "pion" then
            TriggerClientEvent("police:client:spawnCone", source)
        elseif type == "barier" then
            TriggerClientEvent("police:client:spawnBarier", source)
        elseif type == "schotten" then
            TriggerClientEvent("police:client:spawnSchotten", source)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", source)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", source)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", source)
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("cuff", "Sæt i håndjern (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CuffPlayer", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("palert", "Lav en politi anmeldelse", {{
    name = "alert",
    help = "Politi anmeldelse"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
        if args[1] ~= nil then
            local msg = table.concat(args, " ")
            TriggerClientEvent("chatMessage", -1, "POLICE ANMELDELSE", "error", msg)
            TriggerEvent("qb-log:server:CreateLog", "palert", "Police alert", "blue",
                "**" .. GetPlayerName(source) .. "** (CitizenID: " .. Player.PlayerData.citizenid .. " | ID: " .. source ..
                    ") **Alert:** " .. msg, false)
            TriggerClientEvent('police:PlaySound', -1)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Du skal skrive en besked!")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("escort", "Eskorter spiller", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:EscortPlayer", source)
end)

-- QBCore.Commands.Add("mdt", "Open MDT (Kun Politi)", {}, false, function(source, args)
--	local Player = QBCore.Functions.GetPlayer(source)
--    if Player.PlayerData.job.name == "police" then
--        TriggerClientEvent("police:client:toggleDatabank", source)
--    else
--        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
--    end
-- end)

QBCore.Commands.Add("callsign", "Div dig selv et callsign", {{
    name = "name",
    help = "Navngiv dit callsign"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

QBCore.Commands.Add("clearcasings", "Ryd området for patronhylstre (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("jail", "Sæt spiller i fængsel (Kun Politi)", {{
    name = "id",
    help = "Spiller ID"
}, {
    name = "time",
    help = "Tid de skal være i fængsel"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", source, playerId, time)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Tiden skal være større end 0")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("unjail", "Løslad spiller (Kun Politi)", {{
    name = "id",
    help = "Spiller ID"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("clearblood", "Ryd området for blod (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("seizecash", "Konfisker penge (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("sc", "Sæt i håndjern (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CuffPlayerSoft", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("cam", "Se overvågning (Kun Politi)", {{
    name = "camid",
    help = "Kamera ID"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:ActiveCamera", source, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("flagplate", "Efterlys et reg.nr. (Kun Politi)", {{
    name = "plate",
    help = "Registreringsnummer"
}, {
    name = "reason",
    help = "Grunden til efterlysning"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "police" then
        local reason = {}
        for i = 2, #args, 1 do
            table.insert(reason, args[i])
        end
        Plates[args[1]:upper()] = {
            isflagged = true,
            reason = table.concat(reason, " ")
        }
        TriggerClientEvent('QBCore:Notify', source,
            "Køretøjet (" .. args[1]:upper() .. ") er blevet efterlyst på baggrund af: " .. table.concat(reason, " "))
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("unflagplate", "Fjern efterlysning på reg.nr. (Kun Politi)", {{
    name = "plate",
    help = "Registreringsnummer"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
            if Plates[args[1]:upper()].isflagged then
                Plates[args[1]:upper()].isflagged = false
                TriggerClientEvent('QBCore:Notify', source, "Køretøjet (" .. args[1]:upper() .. ") er blevet fjernet fra efterlysningen")
            else
                TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "error", "Køretøj er ikke efterlyst!")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Køretøj er ikke efterlyst!")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("plateinfo", "Slå registreringsnummer op (Kun Politi)", {{
    name = "plate",
    help = "Registreringsnummer"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        if Plates ~= nil and Plates[args[1]:upper()] ~= nil then
            if Plates[args[1]:upper()].isflagged then
                TriggerClientEvent('chatMessage', source, "REPORTING ROOM", "normal", "Køretøjet (" .. args[1]:upper() ..
                    ") er blevet efterlyst for: " .. Plates[args[1]:upper()].reason)
            else
                TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Køretøj er ikke efterlyst!")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Køretøj er ikke efterlyst!")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("depot", "Impound med omkostninger (Kun Politi)", {{
    name = "price",
    help = "Prisen personen skal betale (kan svares blankt)"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, false, tonumber(args[1]))
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("impound", "Impound A Vehicle (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, true)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("paytow", "Betal vognmand (Kun Politi, EMS)", {{
    name = "id",
    help = "ID af spilleren"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer ~= nil then
            if OtherPlayer.PlayerData.job.name == "tow" then
                OtherPlayer.Functions.AddMoney("bank", 500, "police-tow-paid")
                TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning",
                    "Du modtog 500 DKK for din service!")
                TriggerClientEvent('QBCore:Notify', source, 'Du betalte en vognmand')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Personen er ikke en vognmand', "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("paylawyer", "Betal advokat (Kun Politi, Advokat)", {{
    name = "id",
    help = "ID of the player"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer ~= nil then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                OtherPlayer.Functions.AddMoney("bank", 500, "police-lawyer-paid")
                TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "SYSTEM", "warning",
                    "Du modtog 500 DKK for din sag!")
                TriggerClientEvent('QBCore:Notify', source, 'Du betalte en advokat')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Personen er ikke advokat', "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("radar", "Slå fartmåler til/fra (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("wk:toggleRadar", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("police:client:CuffPlayerSoft", source)
    end
end)

QBCore.Commands.Add("112", "Send en besked til beredskabstjenester", {{
    name = "message",
    help = "Beskeden du ønsker at sende"
}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent("police:client:SendEmergencyMessage", source, message)
        TriggerEvent("qb-log:server:CreateLog", "911", "911 alert", "blue",
            "**" .. GetPlayerName(source) .. "** (CitizenID: " .. Player.PlayerData.citizenid .. " | ID: " .. source ..
                ") **Alert:** " .. message, false)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Du har ingen mobil', 'error')
    end
end)

QBCore.Commands.Add("112a", "Send en anonym besked til beredskabstjenester (giver ingen lokation)", {{
    name = "message",
    help = "Beskeden du ønsker at sende"
}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("phone") ~= nil then
        TriggerClientEvent("police:client:CallAnim", source)
        TriggerClientEvent('police:client:Send112AMessage', -1, message)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Du har ingen mobil', 'error')
    end
end)

QBCore.Commands.Add("112r", "Send en besked tilbage til afsender", {{
    name = "id",
    help = "ID af opkaldet"
}, {
    name = "message",
    help = "Beskeden du ønsker at sende"
}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local message = table.concat(args, " ")
    local Prefix = "POLICE"
    if (Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") then
        Prefix = "AMBULANCE"
    end
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "(" .. Prefix .. ") " ..
            Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "error", message)
        TriggerClientEvent("police:client:EmergencySound", OtherPlayer.PlayerData.source)
        TriggerClientEvent("police:client:CallAnim", source)
    end
end)

QBCore.Commands.Add("anklet", "Fastgør fodlænke (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CheckDistance", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
    end
end)

QBCore.Commands.Add("ankletlocation", "Få lokation af fodlænke", {{"csn", "CSN af personen"}}, true,
    function(source, args)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player.PlayerData.job.name == "police" then
            if args[1] ~= nil then
                local citizenid = args[1]
                local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)

                if Target ~= nil then
                    if Target.PlayerData.metadata["tracker"] then
                        TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, source)
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Denne person har ingen fodlænke.', 'error')
                    end
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
        end
    end)

QBCore.Commands.Add("removeanklet", "Fjern fodlænke (Kun Politi)", {{"bsn", "BSN af personen"}}, true,
    function(source, args)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player.PlayerData.job.name == "police" then
            if args[1] ~= nil then
                local citizenid = args[1]
                local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)

                if Target ~= nil then
                    if Target.PlayerData.metadata["tracker"] then
                        TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, source)
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Denne person har ingen fodlænke', 'error')
                    end
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Kun til beredskabstjenester', 'error')
        end
    end)

QBCore.Commands.Add("ebutton", "Besvar et opkald (Kun Politi, EMS, Mekanikere)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or
        Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SendPoliceEmergencyAlert", source)
    end
end)

QBCore.Commands.Add("takedrivinglicense", "Fratag førerret (Kun Politi)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    end
end)

QBCore.Commands.Add("takedna", "Tag et DNA fra en person (tom bevispose er krævet) (Kun Politi)",
    {{"id", "ID of the person"}}, true, function(source, args)
        local Player = QBCore.Functions.GetPlayer(source)
        local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer ~= nil then
            if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
                local info = {
                    label = "DNA Prøve",
                    type = "dna",
                    dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
                }
                if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["filled_evidence_bag"],
                        "add")
                end
            else
                TriggerClientEvent('QBCore:Notify', source, "Du skal have en tom bevispose på dig", "error")
            end
        end
    end)

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        if item.info ~= nil and item.info ~= "" then
            if Player.PlayerData.job.name ~= "police" then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

function GetCurrentCops()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= 2 then
                retval = true
                break
            end
        end
    end
    cb(retval)
end)

function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

RegisterServerEvent('police:server:SyncSpikes')
AddEventHandler('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
end)
