Config = Config or {}

Config.BbqModels = {
    `prop_bbq_1`,
    `prop_bbq_2`,
    `prop_bbq_3`,
    `prop_bbq_4`,
    `prop_bbq_5`,
}

Config.CookableItems = {
    ["raw_meat"] = {
        result = "cooked_meat",
        time = 8000,
        label = "Toores liha"
    },
    ["steak"] = {
        result = "cooked_steak",
        time = 10000,
        label = "Toores pihv"
    },
    ["bbq"] = {
        result = "bbq_cooked",
        time = 12000,
        label = "Toores barbecue"
    }
}

Config.Animation = {
    dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
    clip = "weed_crouch_checking_countnub",
    flag = 1,
    prop = `prop_fish_slice_01`,
}

Config.Notify = function(message, type)
    lib.notify({
        title = 'Grill',
        description = message,
        type = type or 'info',
        duration = 3000
    })
end