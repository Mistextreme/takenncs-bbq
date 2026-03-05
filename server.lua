local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('takenncs-bbq:finishCooking', function(itemName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local cookData = Config.CookableItems[itemName]
    if not cookData then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Grill',
            description = 'Seda ei saa grillida!',
            type = 'error',
            duration = 3000
        })
        return
    end

    local itemCount = exports.ox_inventory:GetItemCount(src, itemName)
    if not itemCount or itemCount < 1 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Grill',
            description = 'Sul pole seda toorainet!',
            type = 'error',
            duration = 3000
        })
        return
    end

    local removed, reason = exports.ox_inventory:RemoveItem(src, itemName, 1)
    if not removed then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Grill',
            description = 'Ei saanud toorainet eemaldada: ' .. (reason or 'viga'),
            type = 'error',
            duration = 3000
        })
        return
    end

    local added, addReason = exports.ox_inventory:AddItem(src, cookData.result, 1)
    if not added then
        exports.ox_inventory:AddItem(src, itemName, 1)
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Grill',
            description = 'Inventar on täis!',
            type = 'error',
            duration = 3000
        })
        return
    end

    local resultItem = exports.ox_inventory:Items()[cookData.result]
    local resultLabel = resultItem and resultItem.label or cookData.result

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Grill',
        description = 'Valmis! Grillisid ' .. resultLabel,
        type = 'success',
        duration = 3000
    })
end)
