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
-- Description: FiveM menu libarary for creating menu's
----------------------- [ MenuV ] -----------------------

fx_version 'cerulean'
game 'gta5'

name 'MenuV'
version '1.4.1'
description 'FiveM menu libarary for creating menu\'s'
author 'ThymonA'
contact 'contact@arens.io'
url 'https://github.com/ThymonA/menuv/'

client_scripts {
    '@menuv/menuv.lua',
    'example.lua'
}

dependencies {
    'menuv'
}