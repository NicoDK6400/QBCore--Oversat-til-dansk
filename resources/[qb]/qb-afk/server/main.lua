
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('KickForAFK', function()
  local src = source
	  DropPlayer(src, 'Du fik et Kick, for at være AFK...')
end)

QBCore.Functions.CreateCallback('qb-afkkick:server:GetPermissions', function(source, cb)
  local src = source
  local group = QBCore.Functions.GetPermission(src)
    cb(group)
end)