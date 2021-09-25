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

if Config.CheckForUpdates then
    Citizen.CreateThread( function()
        updatePath = "/andristum/dpemotes"
        resourceName = "dp Emotes ("..GetCurrentResourceName()..")"
        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
    end)
end

RegisterServerEvent("dp:CheckVersion") 
AddEventHandler("dp:CheckVersion", function()
    if updateavail then
        TriggerClientEvent("dp:Update", source, true)
    else
        TriggerClientEvent("dp:Update", source, false)
    end
end)

function checkVersion(err,responseText, headers)
    curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

    if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
        updateavail = true
        print("\n^1----------------------------------------------------------------------------------^7")
        print(resourceName.." is outdated, latest version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!\nupdate from https://github.com"..updatePath.."")
        print("^1----------------------------------------------------------------------------------^7")
    elseif tonumber(curVersion) > tonumber(responseText) then
        print("\n^3----------------------------------------------------------------------------------^7")
        print(resourceName.." git version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!")
        print("^3----------------------------------------------------------------------------------^7")
    else
        print("\n"..resourceName.." is up to date. (^2"..curVersion.."^7)")
    end
end