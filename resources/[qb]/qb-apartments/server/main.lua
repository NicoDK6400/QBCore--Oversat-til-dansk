local ApartmentObjects = {}

RegisterServerEvent('apartments:server:CreateApartment')
AddEventHandler('apartments:server:CreateApartment', function(type, label)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local num = CreateApartmentId(type)
    local apartmentId = tostring(type .. num)
    local label = tostring(label .. " " .. num)
    exports.oxmysql:insert('INSERT INTO apartments (name, type, label, citizenid) VALUES (?, ?, ?, ?)', {
        apartmentId,
        type,
        label,
        Player.PlayerData.citizenid
    })
    TriggerClientEvent('QBCore:Notify', src, "Du har lejlighed ("..label..")")
    TriggerClientEvent("apartments:client:SpawnInApartment", src, apartmentId, type)
    TriggerClientEvent("apartments:client:SetHomeBlip", src, type)
end)

RegisterServerEvent('apartments:server:UpdateApartment')
AddEventHandler('apartments:server:UpdateApartment', function(type, label)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('UPDATE apartments SET type = ?, label = ? WHERE citizenid = ?', { type, label, Player.PlayerData.citizenid })
    TriggerClientEvent('QBCore:Notify', src, "Du har skiftet lejlighed")
    TriggerClientEvent("apartments:client:SetHomeBlip", src, type)
end)

RegisterServerEvent('apartments:server:RingDoor')
AddEventHandler('apartments:server:RingDoor', function(apartmentId, apartment)
    local src = source
    if ApartmentObjects[apartment].apartments[apartmentId] ~= nil and next(ApartmentObjects[apartment].apartments[apartmentId].players) ~= nil then
        for k, v in pairs(ApartmentObjects[apartment].apartments[apartmentId].players) do
            TriggerClientEvent('apartments:client:RingDoor', k, src)
        end
    end
end)

RegisterServerEvent('apartments:server:OpenDoor')
AddEventHandler('apartments:server:OpenDoor', function(target, apartmentId, apartment)
    local src = source
    local OtherPlayer = QBCore.Functions.GetPlayer(target)
    if OtherPlayer ~= nil then
        TriggerClientEvent('apartments:client:SpawnInApartment', OtherPlayer.PlayerData.source, apartmentId, apartment)
    end
end)

RegisterServerEvent('apartments:server:AddObject')
AddEventHandler('apartments:server:AddObject', function(apartmentId, apartment, offset)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if ApartmentObjects[apartment] ~= nil and ApartmentObjects[apartment].apartments ~= nil and ApartmentObjects[apartment].apartments[apartmentId] ~= nil then
        ApartmentObjects[apartment].apartments[apartmentId].players[src] = Player.PlayerData.citizenid
    else
        if ApartmentObjects[apartment] ~= nil and ApartmentObjects[apartment].apartments ~= nil then
            ApartmentObjects[apartment].apartments[apartmentId] = {}
            ApartmentObjects[apartment].apartments[apartmentId].offset = offset
            ApartmentObjects[apartment].apartments[apartmentId].players = {}
            ApartmentObjects[apartment].apartments[apartmentId].players[src] = Player.PlayerData.citizenid
        else
            ApartmentObjects[apartment] = {}
            ApartmentObjects[apartment].apartments = {}
            ApartmentObjects[apartment].apartments[apartmentId] = {}
            ApartmentObjects[apartment].apartments[apartmentId].offset = offset
            ApartmentObjects[apartment].apartments[apartmentId].players = {}
            ApartmentObjects[apartment].apartments[apartmentId].players[src] = Player.PlayerData.citizenid
        end
    end
end)

RegisterServerEvent('apartments:server:RemoveObject')
AddEventHandler('apartments:server:RemoveObject', function(apartmentId, apartment)
    local src = source
    if ApartmentObjects[apartment].apartments[apartmentId].players ~= nil then
        ApartmentObjects[apartment].apartments[apartmentId].players[src] = nil
        if next(ApartmentObjects[apartment].apartments[apartmentId].players) == nil then
            ApartmentObjects[apartment].apartments[apartmentId] = nil
        end
    end
end)

function CreateApartmentId(type)
    local UniqueFound = false
	local AparmentId = nil

	while not UniqueFound do
		AparmentId = tostring(math.random(1, 9999))
        local result = exports.oxmysql:fetchSync('SELECT COUNT(*) as count FROM apartments WHERE name = ?', { tostring(type .. AparmentId) })
        if result[1].count == 0 then
            UniqueFound = true
        end
	end
	return AparmentId
end

function GetApartmentInfo(apartmentId)
    local retval = nil
    local result = exports.oxmysql:fetchSync('SELECT * FROM apartments WHERE name = ?', { apartmentId })
    if result[1] ~= nil then
        retval = result[1]
    end
    return retval
end

function GetOwnedApartment(citizenid)
    local result = exports.oxmysql:fetchSync('SELECT * FROM apartments WHERE citizenid = ?', { citizenid })
    if result[1] ~= nil then
        return result[1]
    end
    return nil
end

QBCore.Functions.CreateCallback('apartments:GetAvailableApartments', function(source, cb, apartment)
    local apartments = {}
    if ApartmentObjects ~= nil and ApartmentObjects[apartment] ~= nil and ApartmentObjects[apartment].apartments ~= nil then
        for k, v in pairs(ApartmentObjects[apartment].apartments) do
            if (ApartmentObjects[apartment].apartments[k] ~= nil and next(ApartmentObjects[apartment].apartments[k].players) ~= nil) then
                local apartmentInfo = GetApartmentInfo(k)
                apartments[k] = apartmentInfo.label
            end
        end
    end
    cb(apartments)
end)

QBCore.Functions.CreateCallback('apartments:GetApartmentOffset', function(source, cb, apartmentId)
    local retval = 0
    if ApartmentObjects ~= nil then
        for k, v in pairs(ApartmentObjects) do
            if (ApartmentObjects[k].apartments[apartmentId] ~= nil and tonumber(ApartmentObjects[k].apartments[apartmentId].offset) ~= 0) then
                retval = tonumber(ApartmentObjects[k].apartments[apartmentId].offset)
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('apartments:GetApartmentOffsetNewOffset', function(source, cb, apartment)
    local retval = Apartments.SpawnOffset
    if ApartmentObjects ~= nil and ApartmentObjects[apartment] ~= nil and ApartmentObjects[apartment].apartments ~= nil then
        for k, v in pairs(ApartmentObjects[apartment].apartments) do
            if (ApartmentObjects[apartment].apartments[k] ~= nil) then
                retval = ApartmentObjects[apartment].apartments[k].offset + Apartments.SpawnOffset
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('apartments:GetOwnedApartment', function(source, cb, cid)
    if cid ~= nil then
        local result = exports.oxmysql:fetchSync('SELECT * FROM apartments WHERE citizenid = ?', { cid })
        if result[1] ~= nil then 
            return cb(result[1])
        end
        return cb(nil)
    else
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = exports.oxmysql:fetchSync('SELECT * FROM apartments WHERE citizenid = ?', { Player.PlayerData.citizenid })
        if result[1] ~= nil then 
            return cb(result[1])
        end
        return cb(nil)
    end
end)

QBCore.Functions.CreateCallback('apartments:IsOwner', function(source, cb, apartment)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local result = exports.oxmysql:fetchSync('SELECT * FROM apartments WHERE citizenid = ?', { Player.PlayerData.citizenid })
        if result[1] ~= nil then 
            if result[1].type == apartment then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end
end)


QBCore.Functions.CreateCallback('apartments:GetOutfits', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player then
        local result = exports.oxmysql:fetchSync('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
	end
end)

RegisterServerEvent('qb-apartments:server:SetInsideMeta')
AddEventHandler('qb-apartments:server:SetInsideMeta', function(house, insideId, bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local insideMeta = Player.PlayerData.metadata["inside"]

    if bool then
        insideMeta.apartment.apartmentType = house
        insideMeta.apartment.apartmentId = insideId
        insideMeta.house = nil

        Player.Functions.SetMetaData("inside", insideMeta)
    else
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = nil


        Player.Functions.SetMetaData("inside", insideMeta)
    end
end)

RegisterNetEvent('qb-apartments:returnBucket')
AddEventHandler('qb-apartments:returnBucket', function()
    local src = source
    SetPlayerRoutingBucket(src, 0)
end)