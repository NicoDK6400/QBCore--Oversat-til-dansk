local cachedLicenses = {}
local version = LoadResourceFile(GetCurrentResourceName(), "version.txt")

function log(identifier, message)
    local dato = os.date("%d-%m-%Y kl. %X")
    local embedZ = {{
        ["title"] = "🛡️ FiveM Defender",
        ["color"] = tonumber("052b31", 16),
        ["fields"] = {
            {
                ["name"] = "identifier",
                ["value"] = "> "..identifier
            },
            {
                ["name"] = "Message",
                ["value"] = "> "..message
            }
        },
        ["footer"] = {
            ["text"] = dato
        }
    }}
    if Config.webhook ~= "" and Config.webhook ~= nil then
        PerformHttpRequest(Config.webhook, function(e, t, h) end, 'POST', json.encode({username = "FiveM Defender", embeds = embedZ}), { ['Content-Type'] = 'application/json' })
    else
        print("[FiveM Defender] "..identifier.." "..message)
    end
end

function checkBypass(identifier)
    for k,v in pairs(Config.Bypass) do
        if v == identifier then
            return true
        end
    end
    return false
end


Citizen.CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/Ezague/FiveM-Defender-Script/main/version.txt", function(err, text, headers)
        if text == version then
            print("[FiveM Defender] The script is up to date")
        else
            print("^1[FiveM Defender] OUTDATED - Download newest version from: https://github.com/Ezague/FiveM-Defender-Script^0")
        end
    end, 'GET', '')

    PerformHttpRequest("http://fivem.dk/defender/all", function(statusCode, text, headers)
        if statusCode == 200 or statusCode == 304 then
            if text ~= nil and text ~= "" then
                for i,k in pairs(json.decode(text)) do
                    for x,b in pairs(k) do
                        if b ~= "null" and b ~= nil then
                            cachedLicenses[b] = true
                        end
                    end
                end
                print("^2[FiveM Defender] Cache has been loaded.^0")
            else
                print("^1[FiveM Defender] Failed to load cache, FiveM Defender will be disabled.^0")
            end
        else
            print("[FiveM Defender] Failed to load cache, FiveM Defender will be disabled.^0")
        end
    end, 'GET', '')
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local player = source
    local identifiers = GetPlayerIdentifiers(player)
    local found = false
    deferrals.defer()

    Wait(10)

    deferrals.update("[FiveM Defender] Checking identifiers...")

    for k,v in pairs(identifiers) do
        if cachedLicenses[v] == true then
            if not checkBypass(v) then
                found = true
                log(v, "User was excluded due to confirmed modding.")
                deferrals.done("\n[FiveM Defender] You are excluded from this server due to modding. \nExcluded Identifier: " .. v .. " \n\n[Discord] discord.gg/MJvp3w7d4t")
            else
                log(v, "User was a modder, but was allowed access to the server because you set them up in your bypass.")
            end
            break;
        end
    end
    Wait(1000)
    if not found then deferrals.done() end
end)