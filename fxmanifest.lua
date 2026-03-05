fx_version 'cerulean'
game 'gta5'

author 'takenncs'
name 'takenncs-bbq'
description 'Grillisüsteem - ESX Version'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
    'server.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/script.js'
}

dependencies {
    'es_extended',
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

lua54 'yes'
