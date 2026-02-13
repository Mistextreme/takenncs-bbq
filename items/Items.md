-- takenncs-bqq-script ITEMS


['bbq'] = {
    label = 'Toores barbecue',
    weight = 250,
    stack = false,
},

['raw_meat'] = {
    label = 'Toores liha',
    weight = 250,
    stack = true
},
['steak'] = {
    label = 'Toores steik',
    weight = 200,
    stack = true
},

['bbq_cooked'] = {
    label = 'Barbecue',
    weight = 250,
    stack = false,
    degrade = 1440,
    close = true,
    description = "Üks mahlane BBQ",
    client = {
        anim = 'eating',
        prop = {
            bone = 18905,
            model = `prop_food_bs_burger2`,
            pos = vec3(0.1, 0.05, 0.02),
            rot = vec3(-50.0, 16.0, 60.0)
        },
        status = { hunger = 25 },
        usetime = 3500,
        notification = 'BBQ oli väga maitsev.',
        label = 'Sööd BBQ',
    },
},

['cooked_meat'] = {
    label = 'Liha',
    weight = 250,
    stack = true,
    degrade = 1440,
    close = true,
    description = "Mahlane liha, valmis söömiseks",
    client = {
        anim = 'eating',
        prop = {
            bone = 18905,
            model = `prop_cs_steak`,
            pos = vec3(0.1, 0.05, 0.02),
            rot = vec3(-50.0, 16.0, 60.0)
        },
        status = { hunger = 20 },
        usetime = 3500,
        notification = 'Liha oli väga maitsev.',
        label = 'Sööd liha',
    },
},

['cooked_steak'] = {
    label = 'Steik',
    weight = 200,
    stack = true,
    degrade = 1440,
    close = true,
    description = "Üks hästi küpsetatud pihv",
    client = {
        anim = 'eating',
        prop = {
            bone = 18905,
            model = `prop_cs_steak`,
            pos = vec3(0.1, 0.05, 0.02),
            rot = vec3(-50.0, 16.0, 60.0)
        },
        status = { hunger = 25 },
        usetime = 3500,
        notification = 'Pihv oli väga maitsev.',
        label = 'Sööd pihv',
    },
},
