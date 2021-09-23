RegisterNetEvent("qb-justice:client:showLawyerLicense")
AddEventHandler("qb-justice:client:showLawyerLicense", function(sourceId, data)
    local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sourceId)), false)
    local pos = GetEntityCoords(PlayerPedId(), false)
    if #(pos - sourcePos) < 2.0 then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>ID:</strong> {1} <br><strong>Fornavn:</strong> {2} <br><strong>Efternavn:</strong> {3} <br><strong>BSN:</strong> {4} </div></div>',
            args = {'Jura Licens', data.id, data.firstname, data.lastname, data.citizenid}
        })
    end
end)