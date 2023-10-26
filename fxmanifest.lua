fx_version 'adamant'
game 'gta5'

author '!Sheytan ♡ & AmineX TV'
description 'Jason_MoneyWash'
version '1.0.0'

client_scripts {
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
}

shared_script '@es_extended/imports.lua'