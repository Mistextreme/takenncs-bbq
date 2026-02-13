local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('takenncs-bbq:finishCooking', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local cookData = Config.CookableItems[itemName]
    if not cookData then
        QBCore.Functions.Notify(src, 'Seda ei saa grillida!', 'error')
        return
    end
    
    local itemCount = exports.ox_inventory:GetItemCount(src, itemName)
    if not itemCount or itemCount < 1 then
        QBCore.Functions.Notify(src, 'Sul pole seda toorainet!', 'error')
        return
    end
    
    local removed, reason = exports.ox_inventory:RemoveItem(src, itemName, 1)
    if not removed then
        QBCore.Functions.Notify(src, 'Ei saanud toorainet eemaldada: ' .. (reason or 'viga'), 'error')
        return
    end
    
    local added, addReason = exports.ox_inventory:AddItem(src, cookData.result, 1)
    if not added then
        exports.ox_inventory:AddItem(src, itemName, 1)
        QBCore.Functions.Notify(src, 'Inventar on täis!', 'error')
        return
    end
    
    local resultLabel = QBCore.Shared.Items[cookData.result]?.label or cookData.result
    QBCore.Functions.Notify(src, 'Valmis! Grillisid ' .. resultLabel, 'success')
end)
