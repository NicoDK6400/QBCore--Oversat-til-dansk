local Accounts = {}

CreateThread(function()
    Wait(500)
    local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "./accounts.json"))
    if not result then
        return
    end
    for k, v in pairs(result) do
        local k = tostring(k)
        local v = tonumber(v)
        if k and v then
            Accounts[k] = v
        end
    end
end)

QBCore.Functions.CreateCallback('qb-gangmenu:server:GetAccount', function(source, cb, gangname)
    local result = GetAccount(gangname)
    cb(result)
end)

-- Export
function GetAccount(account)
    return Accounts[account] or 0
end

-- Withdraw Money
RegisterServerEvent("qb-gangmenu:server:withdrawMoney")
AddEventHandler("qb-gangmenu:server:withdrawMoney", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local gang = Player.PlayerData.gang.name

    if not Accounts[gang] then
        Accounts[gang] = 0
    end

    if Accounts[gang] >= amount and amount > 0 then
        Accounts[gang] = Accounts[gang] - amount
        Player.Functions.AddMoney("cash", amount)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not Enough Money', 'error')
        return
    end
    SaveResourceFile(GetCurrentResourceName(), "./accounts.json", json.encode(Accounts), -1)
    TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Withdraw Money',
        "Successfully withdrawn $" .. amount .. ' (' .. gang .. ')', src)
end)

-- Deposit Money
RegisterServerEvent("qb-gangmenu:server:depositMoney")
AddEventHandler("qb-gangmenu:server:depositMoney", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local gang = Player.PlayerData.gang.name

    if not Accounts[gang] then
        Accounts[gang] = 0
    end

    if Player.Functions.RemoveMoney("cash", amount) then
        Accounts[gang] = Accounts[gang] + amount
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not Enough Money', "error")
        return
    end
    SaveResourceFile(GetCurrentResourceName(), "./accounts.json", json.encode(Accounts), -1)
    TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Deposit Money',
        "Successfully deposited $" .. amount .. ' (' .. gang .. ')', src)
end)

RegisterServerEvent("qb-gangmenu:server:addAccountMoney")
AddEventHandler("qb-gangmenu:server:addAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end

    Accounts[account] = Accounts[account] + amount
    TriggerClientEvent('qb-gangmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./accounts.json", json.encode(Accounts), -1)
end)

RegisterServerEvent("qb-gangmenu:server:removeAccountMoney")
AddEventHandler("qb-gangmenu:server:removeAccountMoney", function(account, amount)
    if not Accounts[account] then
        Accounts[account] = 0
    end

    if Accounts[account] >= amount then
        Accounts[account] = Accounts[account] - amount
    end

    TriggerClientEvent('qb-gangmenu:client:refreshSociety', -1, account, Accounts[account])
    SaveResourceFile(GetCurrentResourceName(), "./accounts.json", json.encode(Accounts), -1)
end)

-- Get Employees
QBCore.Functions.CreateCallback('qb-gangmenu:server:GetEmployees', function(source, cb, gangname)
    local employees = {}
    if not Accounts[gangname] then
        Accounts[gangname] = 0
    end
    local query = '%' .. gangname .. '%'
    local players = exports.oxmysql:fetchSync('SELECT * FROM players WHERE gang LIKE ?', {query})
    if players[1] ~= nil then
        for key, value in pairs(players) do
            local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

            if isOnline then
                table.insert(employees, {
                    source = isOnline.PlayerData.citizenid,
                    grade = isOnline.PlayerData.gang.grade,
                    isboss = isOnline.PlayerData.gang.isboss,
                    name = isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
                })
            else
                table.insert(employees, {
                    source = value.citizenid,
                    grade = json.decode(value.gang).grade,
                    isboss = json.decode(value.gang).isboss,
                    name = json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
                })
            end
        end
    end
    cb(employees)
end)

-- Grade Change
RegisterServerEvent('qb-gangmenu:server:updateGrade')
AddEventHandler('qb-gangmenu:server:updateGrade', function(target, grade)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
    if Employee then
        if Employee.Functions.SetGang(Player.PlayerData.gang.name, grade) then
            TriggerClientEvent('QBCore:Notify', src, "Grade Changed Successfully!", "success")
            TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "Your Gang Grade Is Now [" .. grade .. "].",
                "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Grade Does Not Exist", "error")
        end
    else
        local player = exports.oxmysql:fetchSync('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {target})
        if player[1] ~= nil then
            Employee = player[1]
            local gang = QBCore.Shared.Gangs[Player.PlayerData.gang.name]
            local employeegang = json.decode(Employee.gang)
            employeegang.grade = gang.grades[data.grade]
            exports.oxmysql:execute('UPDATE players SET gang = ? WHERE citizenid = ?',
                {json.encode(employeegang), target})
            TriggerClientEvent('QBCore:Notify', src, "Grade Changed Successfully!", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Player Does Not Exist", "error")
        end
    end
end)

-- Fire Employee
RegisterServerEvent('qb-gangmenu:server:fireEmployee')
AddEventHandler('qb-gangmenu:server:fireEmployee', function(target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
    if Employee then
        if Employee.Functions.SetGang("none", '0') then
            TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Gang Fire', "Successfully fired " ..
                GetPlayerName(Employee.PlayerData.source) .. ' (' .. Player.PlayerData.gang.name .. ')', src)
            TriggerClientEvent('QBCore:Notify', src, "Fired successfully!", "success")
            TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You Were Fired", "error")
        else
            TriggerClientEvent('QBCore:Notify', src, "Contact Server Developer", "error")
        end
    else
        local player = exports.oxmysql:fetchSync('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {target})
        if player[1] ~= nil then
            Employee = player[1]
            local gang = {}
            gang.name = "none"
            gang.label = "No Gang"
            gang.payment = 10
            gang.onduty = true
            gang.isboss = false
            gang.grade = {}
            gang.grade.name = nil
            gang.grade.level = 0
            exports.oxmysql:execute('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), target})
            TriggerClientEvent('QBCore:Notify', src, "Fired successfully!", "success")
            TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Fire',
                "Successfully fired " .. target.source .. ' (' .. Player.PlayerData.gang.name .. ')', src)
        else
            TriggerClientEvent('QBCore:Notify', src, "Player Does Not Exist", "error")
        end
    end
end)

-- Recruit Player
RegisterServerEvent('qb-gangmenu:server:giveJob')
AddEventHandler('qb-gangmenu:server:giveJob', function(recruit)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(recruit)
    if Target and Target.Functions.SetGang(Player.PlayerData.gang.name, 0) then
        TriggerClientEvent('QBCore:Notify', src,
            "You Recruited " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) ..
                " To " .. Player.PlayerData.gang.label .. "", "success")
        TriggerClientEvent('QBCore:Notify', Target.PlayerData.source,
            "You've Been Recruited To " .. Player.PlayerData.gang.label .. "", "success")
        TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Recruit',
            "Successfully recruited " ..
                (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' ..
                Player.PlayerData.gang.name .. ')', src)
    end
end)
