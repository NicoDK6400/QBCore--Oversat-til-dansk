Citizen.CreateThread(function()
    Config.CurrentLab = math.random(1, #Config.Locations["laboratories"])
    --print('Lab entry has been set to location: '..Config.CurrentLab)
end)

QBCore.Functions.CreateCallback('qb-methlab:server:GetData', function(source, cb)
    local LabData = {
        CurrentLab = Config.CurrentLab
    }
    cb(LabData)
end)

QBCore.Functions.CreateUseableItem("labkey", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    local LabKey = item.info.lab ~= nil and item.info.lab or 1

    TriggerClientEvent('qb-methlab:client:UseLabKey', source, LabKey)
end)

function GenerateRandomLab()
    local Lab = math.random(1, #Config.Locations["laboratories"])
    return Lab
end

RegisterServerEvent('qb-methlab:server:loadIngredients')
AddEventHandler('qb-methlab:server:loadIngredients', function()
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local hydrochloricacid = Player.Functions.GetItemByName('hydrochloricacid')
    local ephedrine = Player.Functions.GetItemByName('ephedrine')
    local acetone = Player.Functions.GetItemByName('acetone')
	if Player.PlayerData.items ~= nil then 
        if (hydrochloricacid ~= nil and ephedrine ~= nil and acetone ~= nil) then
            if hydrochloricacid.amount >= 0 and ephedrine.amount >= 0 and acetone.amount >= 0 then 
                Player.Functions.RemoveItem("hydrochloricacid", Config.HydrochloricAcid, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['hydrochloricacid'], "remove")
                Player.Functions.RemoveItem("ephedrine", Config.Ephedrine, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ephedrine'], "remove")
                Player.Functions.RemoveItem("acetone", Config.Acetone, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['acetone'], "remove")
            end
        end
	end
end)

RegisterServerEvent('qb-methlab:server:CheckIngredients')
AddEventHandler('qb-methlab:server:CheckIngredients', function()
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local hydrochloricacid = Player.Functions.GetItemByName('hydrochloricacid')
    local ephedrine = Player.Functions.GetItemByName('ephedrine')
    local acetone = Player.Functions.GetItemByName('acetone')
	if Player.PlayerData.items ~= nil then 
        if (hydrochloricacid ~= nil and ephedrine ~= nil and acetone ~= nil) then 
            if hydrochloricacid.amount >= Config.HydrochloricAcid and ephedrine.amount >= Config.Ephedrine and acetone.amount >= Config.Acetone then 
                TriggerClientEvent("qb-methlab:client:loadIngredients", source)
            else
                TriggerClientEvent('QBCore:Notify', source, "You do not have the correct items", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "You do not have the correct items", 'error')
        end
	else
		TriggerClientEvent('QBCore:Notify', source, "You have nothing...", "error")
	end
end)

RegisterServerEvent('qb-methlab:server:breakMeth')
AddEventHandler('qb-methlab:server:breakMeth', function()
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local meth = Player.Functions.GetItemByName('methtray')
    local puremethtray = Player.Functions.GetItemByName('puremethtray')

	if Player.PlayerData.items ~= nil then 
        if (meth ~= nil or puremethtray ~= nil) then 
                TriggerClientEvent("qb-methlab:client:breakMeth", source)
        else
            TriggerClientEvent('QBCore:Notify', source, "You do not have the correct items", 'error')   
        end
	else
		TriggerClientEvent('QBCore:Notify', source, "You Have nothing...", "error")
	end
end)

RegisterServerEvent('qb-methlab:server:getmethtray')
AddEventHandler('qb-methlab:server:getmethtray', function(amount)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    
    local methtray = Player.Functions.GetItemByName('methtray')
    local puremethtray = Player.Functions.GetItemByName('puremethtray')

    if puremethtray ~= nil then 
        if puremethtray.amount >= 1 then 
            Player.Functions.AddItem("puremeth", amount, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['puremeth'], "add")

            Player.Functions.RemoveItem("puremethtray", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['puremethtray'], "remove")
        end
    elseif methtray ~= nil then 
        if methtray.amount >= 1 then 
            Player.Functions.AddItem("meth", amount, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['meth'], "add")

            Player.Functions.RemoveItem("methtray", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['methtray'], "remove")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You do not have the correct items", 'error')   
    end
end)

RegisterServerEvent('qb-methlab:server:receivemethtray')
AddEventHandler('qb-methlab:server:receivemethtray', function()
    local chance = math.random(1, 100)
    print(chance)
    if chance >= 90 then
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        Player.Functions.AddItem("puremethtray", 3, false)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['puremethtray'], "add")
    else
        local Player = QBCore.Functions.GetPlayer(tonumber(source))
        Player.Functions.AddItem("methtray", 3, false)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['methtray'], "add")
    end
end)