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

RegisterServerEvent('qb-log:server:CreateLog')
AddEventHandler('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone ~= nil and tagEveryone or false
    local webHook = Config.Webhooks[name] ~= nil and Config.Webhooks[name] or Config.Webhooks["default"]
    local embedData = {
        {
            ["title"] = title,
            ["color"] = Config.Colors[color] ~= nil and Config.Colors[color] or Config.Colors["default"],
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
            ["author"] = {
            ["name"] = 'Server Logs',
            ["icon_url"] = "https://cdn.discordapp.com/attachments/870094209783308299/870104723338973224/Logotype_-_Display_Picture_-_Stylized_-_Red.png",
                },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Server Logs",embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Server Logs", content = "@everyone"}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add("testwebhook", "Test dine Discord webhook for logs (Kun God)", {}, false, function(source, args)
    TriggerEvent("qb-log:server:CreateLog", "default", "TestWebhook", "default", "Triggered **a** test webhook :)")
end, "god")
