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

fx_version 'cerulean'
game 'gta5'

description 'QB-Interior'
version '1.0.0'

this_is_a_map 'yes'

client_scripts {
	'client/main.lua',
	'client/optional.lua'
}

exports {
	'DespawnInterior',
	'CreateHotel',
	'CreateTier1House',
	'CreateTier2House',
	'CreateTier3House',
	'CreateMichaelShell',
	'CreateTrevorsShell',
	'CreateLesterShell',
	'CreateGunshopShell',
	'CreateTrapHouseShell',
	'CreateMethlabShell',
	'CreateApartmentShell',
	'CreateCaravanShell',
	'CreateFranklinShell',
	'CreateFranklinAuntShell',
	'CreateTier1HouseFurnished',
	'CreateHotelFurnished',
	'CreateApartmentFurnished'
}

files {
	'stream/defaultshells/shellprops.ytyp',
	'stream/startingapt/shellpropsv11.ytyp',
	'playerhouse_hotel/playerhouse_hotel.ytyp',
	'stream/playerhouse_hotel/playerhouse_hotel.ytyp',
	'stream/playerhouse_hotel/playerhouse_hote2.ytyp',
	'stream/playerhouse_tier3/playerhouse_tier3.ytyp',
	'stream/playerhouse_appartment_motel/playerhouse_appartment_motel.ytyp',
	'stream/micheal_shell/micheal_shell.ytyp',
	'stream/trevors_shell/trevors_shell.ytyp',
	'stream/gunshop_shell/gunshop_shell.ytyp',
	'stream/traphouse_shell/traphouse_shell.ytyp',
	'stream/appartment/appartment.ytyp',
	'stream/caravan_shell/caravan.ytyp',
	'stream/frankelientje/frankelientje.ytyp',
	'stream/tante_shell/tante.ytyp',
	'stream/methlab_shell/methlab_shell.ytyp',
	'stream/pinkcage/gabz_pinkcage.ytyp'
	-- 'stream/ClassicHouseShells/shellpropsv19.ytyp',
	-- 'stream/DeluxeHousingShells/shellpropsv2.ytyp',
	-- 'stream/FurnishedHousingShells/shellpropsv11.ytyp',
	-- 'stream/FurnishedMotelsShells/shellpropsv18.ytyp',
	-- 'stream/FurnishedStashhousesShells/shellpropsv15.ytyp',
	-- 'stream/GarageShells/shellpropsv8.ytyp',
	-- 'stream/HighendHousingShells/shellpropsv9.ytyp',
	-- 'stream/HighendLabShells/kshellsdrug.ytyp',
	-- 'stream/LabShells/shellpropsv7.ytyp',
	-- 'stream/MediumHousingShells/shellpropsv10.ytyp',
	-- 'stream/ModernHotelsShells/shellpropsv14.ytyp',
	-- 'stream/ModernHousingShells/shellpropsv12.ytyp',
	-- 'stream/OfficeShells/shellpropsv3.ytyp',
	-- 'stream/StashhousesShells/shellpropsv16.ytyp',
	-- 'stream/StoreShells/shellpropsv4.ytyp',
	-- 'stream/WarehouseShells/shellpropsv5.ytyp'
	-- 'stream/AllShellsBundle/allshellsbundle.ytyp'
	-- 'stream/AllFurnishedShellsBundle/allfurnishedshellsbundle.ytyp'
	-- 'stream/AllEmptyShellsBundle/allemptyshellsbundle.ytyp'
}

-- Default (included)
data_file 'DLC_ITYP_REQUEST' 'stream/defaultshells/shellprops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/startingapt/shellpropsv11.ytyp'
-- idk --
data_file 'DLC_ITYP_REQUEST' 'stream/v_int_20.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_hotel/playerhouse_hotel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier1/playerhouse_tier1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier1/playerhouse_tier2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier3/playerhouse_tier3.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_appartment_motel/playerhouse_appartment_motel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/micheal_shell/micheal_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/trevors_shell/trevors_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/gunshop_shell/gunshop_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/traphouse_shell/traphouse_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/appartment/appartment.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/caravan_shell/caravan.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/frankelientje/frankelientje.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tante_shell/tante.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/methlab_shell/methlab_shell.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pinkcage/gabz_pinkcage.ytyp'
-- idk -- 

-- Classic
-- data_file 'DLC_ITYP_REQUEST' 'stream/ClassicHouseShells/shellpropsv19.ytyp'
-- -- Deluxe
-- data_file 'DLC_ITYP_REQUEST' 'stream/DeluxeHousingShells/shellpropsv2.ytyp'
-- -- Furnished Housing
-- data_file 'DLC_ITYP_REQUEST' 'stream/FurnishedHousingShells/shellpropsv11.ytyp'
-- -- Furnished Motels
-- data_file 'DLC_ITYP_REQUEST' 'stream/FurnishedMotelsShells/shellpropsv18.ytyp'
-- -- Furnished Stash
-- data_file 'DLC_ITYP_REQUEST' 'stream/FurnishedStashhousesShells/shellpropsv15.ytyp'
-- -- Garage
-- data_file 'DLC_ITYP_REQUEST' 'stream/GarageShells/shellpropsv8.ytyp'
-- -- High End
-- data_file 'DLC_ITYP_REQUEST' 'stream/HighendHousingShells/shellpropsv9.ytyp'
-- -- High End Labs
-- data_file 'DLC_ITYP_REQUEST' 'stream/HighendLabShells/kshellsdrug.ytyp'
-- -- Labs
-- data_file 'DLC_ITYP_REQUEST' 'stream/LabShells/shellpropsv7.ytyp'
-- -- Medium Housing
-- data_file 'DLC_ITYP_REQUEST' 'stream/MediumHousingShells/shellpropsv10.ytyp'
-- -- Modern Hotels
-- data_file 'DLC_ITYP_REQUEST' 'stream/ModernHotelsShells/shellpropsv14.ytyp'
-- -- Modern Housing
-- data_file 'DLC_ITYP_REQUEST' 'stream/ModernHousingShells/shellpropsv12.ytyp'
-- -- Office
-- data_file 'DLC_ITYP_REQUEST' 'stream/OfficeShells/shellpropsv3.ytyp'
-- -- Stash
-- data_file 'DLC_ITYP_REQUEST' 'stream/StashhousesShells/shellpropsv16.ytyp'
-- -- Store
-- data_file 'DLC_ITYP_REQUEST' 'stream/StoreShells/shellpropsv4.ytyp'
-- -- Warehouse
-- data_file 'DLC_ITYP_REQUEST' 'stream/WarehouseShells/shellpropsv5.ytyp'
-- -- All Shells Bundle
-- data_file 'DLC_ITYP_REQUEST' 'stream/AllShellsBundle/allshellsbundle.ytyp'
-- -- All Furnished Bundle
-- data_file 'DLC_ITYP_REQUEST' 'stream/AllFurnishedShellsBundle/allfurnishedshellsbundle.ytyp'
-- -- All Empty Bundle
-- data_file 'DLC_ITYP_REQUEST' 'stream/AllEmptyShellsBundle/allemptyshellsbundle.ytyp'


lua54 'yes'