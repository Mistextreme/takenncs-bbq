local QBCore = exports['qb-core']:GetCoreObject()
local isGrilling = false

local function startGrilling(itemName)
    if isGrilling then
        QBCore.Functions.Notify('Oled juba grillimas!', 'error')
        return false
    end

    local cookData = Config.CookableItems[itemName]
    if not cookData then
        QBCore.Functions.Notify('Seda ei saa grillida!', 'error')
        return false
    end

    local hasItem = exports.ox_inventory:GetItemCount(itemName)
    if not hasItem or hasItem < 1 then
        QBCore.Functions.Notify('Sul pole seda toorainet!', 'error')
        return false
    end

    isGrilling = true

    local progress = lib.progressBar({
        duration = cookData.time,
        label = 'Grillid ' .. cookData.label .. '...',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = Config.Animation.dict, clip = Config.Animation.clip, flag = Config.Animation.flag },
        prop = { model = Config.Animation.prop, bone = 60309, pos = vec3(0,0,0), rot = vec3(0,0,0) }
    })

    if not progress then
        QBCore.Functions.Notify('Grillimine katkestatud!', 'error')
        isGrilling = false
        return false
    end

    local stillHasItem = exports.ox_inventory:GetItemCount(itemName)
    if not stillHasItem or stillHasItem < 1 then
        QBCore.Functions.Notify('Tooraine kadus ootamatult!', 'error')
        isGrilling = false
        return false
    end

    TriggerServerEvent('takenncs-bbq:finishCooking', itemName)
    isGrilling = false
    return true
end

local function openBbqMenu()
    local items = {}
    local totalItems = 0

    for itemName, data in pairs(Config.CookableItems) do
        local count = exports.ox_inventory:GetItemCount(itemName) or 0
        if count > 0 then
            table.insert(items, {
                name = itemName,
                label = data.label,
                count = count,
                time = data.time
            })
            totalItems = totalItems + count
        end
    end

    if #items == 0 then
        QBCore.Functions.Notify('Sul pole midagi grillida!', 'error')
        return
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openBbqMenu",
        items = items
    })
end

Citizen.CreateThread(function()
    exports.ox_target:addModel(Config.BbqModels, {
        {
            name = 'bbq_grill',
            label = 'Grilli',
            icon = 'fa-solid fa-fire',
            distance = 2.0,
            onSelect = function()
                openBbqMenu()
            end
        }
    })
end)

RegisterNUICallback('selectItem', function(data, cb)
    startGrilling(data.itemName)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('grill', function()
    openBbqMenu()
end, false)
