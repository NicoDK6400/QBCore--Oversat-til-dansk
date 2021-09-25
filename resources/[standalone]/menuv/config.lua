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

----------------------- [ MenuV ] -----------------------
-- GitHub: https://github.com/ThymonA/menuv/
-- License: GNU General Public License v3.0
--          https://choosealicense.com/licenses/gpl-3.0/
-- Author: Thymon Arens <contact@arens.io>
-- Name: MenuV
-- Version: 1.4.1
-- Description: FiveM menu library for creating menu's
----------------------- [ MenuV ] -----------------------
Config = {
    Language = 'en',
    HideInterval = 250,
    Sounds = {
        UP = {
            type = 'native',
            name = 'NAV_UP_DOWN',
            library = 'HUD_FREEMODE_SOUNDSET'
        },
        DOWN = {
            type = 'native',
            name = 'NAV_UP_DOWN',
            library = 'HUD_FREEMODE_SOUNDSET'
        },
        LEFT = {
            type = 'native',
            name = 'NAV_LEFT_RIGHT',
            library = 'HUD_FRONTEND_DEFAULT_SOUNDSET'
        },
        RIGHT = {
            type = 'native',
            name = 'NAV_LEFT_RIGHT',
            library = 'HUD_FRONTEND_DEFAULT_SOUNDSET'
        },
        ENTER = {
            type = 'native',
            name = 'SELECT',
            library = 'HUD_FRONTEND_DEFAULT_SOUNDSET'
        },
        CLOSE = {
            type = 'native',
            name = 'BACK',
            library = 'HUD_FRONTEND_DEFAULT_SOUNDSET'
        }
    }
}

_G.Config = Config
_ENV.Config = Config