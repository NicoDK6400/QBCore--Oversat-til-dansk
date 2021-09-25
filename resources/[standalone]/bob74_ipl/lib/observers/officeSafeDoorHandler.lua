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

-- Delay between each attempt to open/close the doors corresponding to their state
local _scanDelay = 500

Citizen.CreateThread(function()
    while true do
        local office = 0
        
        -- Search for the current office to open/close the safes doors
        if (Global.FinanceOffices.isInsideOffice1) then office = FinanceOffice1
            elseif (Global.FinanceOffices.isInsideOffice2) then office = FinanceOffice2
            elseif (Global.FinanceOffices.isInsideOffice3) then office = FinanceOffice3
            elseif (Global.FinanceOffices.isInsideOffice4) then office = FinanceOffice4
        end

        if (office ~= 0) then
            -- Office found, let's check the doors
            -- Check left door
            doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashL)
            if (doorHandle ~= 0) then
                if (office.Safe.isLeftDoorOpen) then office.Safe.SetDoorState("left", true)
                else office.Safe.SetDoorState("left", false) end
            end

            -- Check right door
            doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashR)
            if (doorHandle ~= 0) then
                if (office.Safe.isRightDoorOpen) then office.Safe.SetDoorState("right", true)
                else office.Safe.SetDoorState("right", false) end
            end
        end

        Wait(_scanDelay)
    end
end)
