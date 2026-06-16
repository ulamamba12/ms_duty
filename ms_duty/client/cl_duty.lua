local QBCore, ESX = nil, nil

CreateThread(function()
    if GetResourceState('qbx_core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

-- Create Target Zones
CreateThread(function()
    for job, enabled in pairs(Config.Jobs) do
        if enabled then
            for index, loc in ipairs(Config.DutyLocations[job] or {}) do
                local options = {
                    {
                        name = 'duty_'..job..'_'..index,
                        icon = 'fas fa-clock',
                        label = 'Toggle Duty',
                        job = job,
                        groups = job,
                        onSelect = function()
                            TriggerServerEvent('QBCore:ToggleDuty')
                        end,
                        distance = 2.5
                    }
                }

                if exports.ox_target then
                    exports.ox_target:addBoxZone({
                        coords = loc.coords,
                        size = vec3(1.5, 1.5, 2.0),
                        rotation = loc.heading or 0,
                        debug = false,
                        options = options
                    })
                elseif exports['qb-target'] then
                    exports['qb-target']:AddBoxZone('duty_'..job..'_'..index, loc.coords, 1.5, 1.5, {
                        name = 'duty_'..job..'_'..index,
                        heading = loc.heading or 0,
                        debugPoly = false,
                        minZ = loc.coords.z - 1.0,
                        maxZ = loc.coords.z + 1.0,
                    }, { options = options, distance = 2.5 })
                end
            end
        end
    end
end)

-- Command Suggestion
CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/'..Config.CommandName, Config.CommandHelp)
end)