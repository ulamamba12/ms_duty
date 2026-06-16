local QBCore, ESX = nil, nil

CreateThread(function()
    if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

-- =========================| COMMAND DUTY SYSTEM |=========================
CreateThread(function()
    local framework = nil

    if QBCore then
        framework = 'qb'
    elseif exports.qbx_core then
        framework = 'qbx'
    else
        print('^1[ERROR] Framework not detected!^0')
        return
    end

    if framework == 'qb' then
        RegisterCommand(Config.CommandName, function(source, args, rawCommand)
            local Player = QBCore.Functions.GetPlayer(source)
            if not Player then return end

            HandleDutyCommand(source, Player, 'qb')
        end, false)
    elseif framework == 'qbx' then

        if GetResourceState('ox_lib') == 'started' then
            lib.registerCommand(Config.CommandName, {
                help = 'Toggle duty status for your job',
                restricted = false
            }, function(source, args, rawCommand)
                local Player = exports.qbx_core:GetPlayer(source)
                if not Player then return end

                HandleDutyCommand(source, Player, 'qbx')
            end)
        else

            exports.qbx_core:RegisterCommand(Config.CommandName, function(source, args, rawCommand)
                local Player = exports.qbx_core:GetPlayer(source)
                if not Player then return end

                HandleDutyCommand(source, Player, 'qbx')
            end, { 
                help = 'Toggle duty status for your job',
                restricted = false 
            })
        end
    end
end)

function HandleDutyCommand(source, Player, framework)
    local jobName = Player.PlayerData.job.name

    if not Config.Jobs[jobName] then
        if framework == 'qb' then
            TriggerClientEvent('QBCore:Notify', source, 'Your job does not have access to duty!', 'error')
        else
            exports.qbx_core:Notify(source, 'Your job does not have access to duty!', 'error')
        end
        return
    end

    local onDuty = not Player.PlayerData.job.onduty
    Player.Functions.SetJobDuty(onDuty)

    local message = onDuty and ('You are now ON DUTY as ' .. jobName) or ('You are now OFF DUTY')
    local type = onDuty and 'success' or 'error'

    if framework == 'qb' then
        TriggerClientEvent('QBCore:Notify', source, message, type)
    else
        exports.qbx_core:Notify(source, message, type)
    end
end

if ESX then
    if GetResourceState('ox_lib') == 'started' then
        lib.registerCommand(Config.CommandName, {
            help = Config.CommandHelp or 'Toggle duty status for your job',
            restricted = 'user'
        }, function(source, args, rawCommand)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            
            local jobName = xPlayer.job.name
            
            if not Config.Jobs[jobName] then
                lib.notify(source, {
                    title = 'Duty',
                    description = 'Your job does not have access to duty!',
                    type = 'error'
                })
                return
            end
            
            local isOnDuty = not xPlayer.job.onduty
            
            if GetResourceState('esx_service') == 'started' then
                TriggerClientEvent('esx_service:toggleService', source, jobName)
            else
                xPlayer.setJob(jobName, xPlayer.job.grade)
            end
            
            lib.notify(source, {
                title = 'Duty Status',
                description = isOnDuty and ('You are now ON DUTY as ' .. jobName) or ('You are now OFF DUTY'),
                type = isOnDuty and 'success' or 'error'
            })
        end)
    else
        ESX.RegisterCommand(Config.CommandName, 'user', function(xPlayer, args, showError)
            local jobName = xPlayer.job.name
            
            if not Config.Jobs[jobName] then
                xPlayer.showNotification('Your job does not have access to duty!', 'error')
                return
            end
            
            local isOnDuty = not xPlayer.job.onduty
            
            if GetResourceState('esx_service') == 'started' then
                TriggerClientEvent('esx_service:toggleService', xPlayer.source, jobName)
            else
                xPlayer.setJob(jobName, xPlayer.job.grade)
            end
            
            local message = isOnDuty and ('You are now ON DUTY as ' .. jobName) or ('You are now OFF DUTY')
            xPlayer.showNotification(message, isOnDuty and 'success' or 'error')
            
        end, { help = Config.CommandHelp })
    end
end

-- ====================| TARGET EVENT |====================
RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end

        local job = Player.PlayerData.job.name
        if not Config.Jobs[job] then
            lib.notify(src, { title = 'Duty', description = 'This job does not support duty!', type = 'error' })
            return
        end

        local onDuty = not Player.PlayerData.job.onduty
        Player.Functions.SetJobDuty(onDuty)

        lib.notify(src, {
            title = 'Duty',
            description = onDuty and 'You are now ON DUTY ✅' or 'You are now OFF DUTY ❌',
            type = onDuty and 'success' or 'error'
        })
    end
end)

if ESX then
    print('^2[Multi-Duty] ESX Detected - Use esx_service for duty^7')
end