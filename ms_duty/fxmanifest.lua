fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Maula-Store'
description 'Simple Duty Sytem'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared.lua'
}

client_scripts {
    'client/cl_duty.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_duty.lua'
}

dependencies {
    'ox_lib'
}