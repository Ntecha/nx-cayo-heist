local QBCore = exports['qb-core']:GetCoreObject()

-- start heist
exports['qb-target']:AddBoxZone("nxte-cayo:startheist", vector3(4818.48, -4310.13, 5.67), 1, 1.2, {
	name = "nxte-cayo:startheist",
	heading = 338.35,
	debugPoly = false,
	minZ = 4.8,
	maxZ = 7,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:startheist",
			icon = "fas fa-circle",
			label = "Knock on door",
		},
	},
	distance = 2.5
})

-- hack 1
exports['qb-target']:AddBoxZone("nxte-cayo:hack1", vector3(4491.68, -4582.49, 6.74), 0.4, 0.9, {
	name = "nxte-cayo:hack1",
	heading = 200.46,
	debugPoly = false,
	minZ = 5.8,
	maxZ = 6.9,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:hack1",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})

-- hack 2
exports['qb-target']:AddBoxZone("nxte-cayo:hack2", vector3(5084.25, -5731.81, 17.14), 0.14, 0.2, {
	name = "nxte-cayo:hack2",
	heading = 325,
	debugPoly = false,
	minZ = 16.05,
	maxZ = 16.3,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:hack2",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})

-- hack 3
exports['qb-target']:AddBoxZone("nxte-cayo:hack3", vector3(5082.89, -5758.54, 15.77), 0.4, 0.4, {
	name = "nxte-cayo:hack3",
	heading = 144.12,
	debugPoly = false,
	minZ = 15.77,
	maxZ = 16.0,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:hack3",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})
-- door1
exports['qb-target']:AddBoxZone("nxte-cayo:door1", vector3(4992.19, -5756.6, 15.89), 1, 1, {
	name = "nxte-cayo:door1",
	heading = 328.0,
	debugPoly = false,
	minZ = 15,
	maxZ = 17.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:door1",
			icon = "fas fa-circle",
			label = "Open Door",
		},
	},
	distance = 2.5
})
-- door 2
exports['qb-target']:AddBoxZone("nxte-cayo:door2", vector3(4998.39, -5742.69, 15.98), 1, 1, {
	name = "nxte-cayo:door2",
	heading = 237.99,
	debugPoly = false,
	minZ = 14.0,
	maxZ = 16.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:door2",
			icon = "fas fa-circle",
			label = "Open Door",
		},
	},
	distance = 2.5
})
-- door 3
exports['qb-target']:AddBoxZone("nxte-cayo:door3", vector3(5001.99, -5746.21, 14.84), 1, 1, {
	name = "nxte-cayo:door3",
	heading = 237.99,
	debugPoly = false,
	minZ = 14.0,
	maxZ = 16.0,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:door3",
			icon = "fas fa-circle",
			label = "Open Door",
		},
	},
	distance = 2.5
})

-- door 4
exports['qb-target']:AddBoxZone("nxte-cayo:door4", vector3(5008.12, -5753.83, 16.68), 1, 1, {
	name = "nxte-cayo:door4",
	heading = 327.76,
	debugPoly = false,
	minZ = 14.4,
	maxZ = 16.6,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:door4",
			icon = "fas fa-circle",
			label = "Open Door",
		},
	},
	distance = 2.5
})





-- loot 1
exports['qb-target']:AddBoxZone("nxte-cayo:loot1", vector3(5001.67, -5753.8, 16.4), 0.8, 0.7, {
	name = "nxte-cayo:loot1",
	heading = 20.12,
	debugPoly = false,
	minZ = 14.0,
	maxZ = 15.3,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:loot1",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})

-- loot 2
exports['qb-target']:AddBoxZone("nxte-cayo:loot2", vector3(5011.34, -5757.71, 17.23), 1, 1, {
	name = "nxte-cayo:loot2",
	heading =  57.49,
	debugPoly = false,
	minZ = 14.4,
	maxZ = 16.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:loot2",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})



-- loot 3
exports['qb-target']:AddBoxZone("nxte-cayo:loot3", vector3(5017.29, -5746.63, 16.11), 1, 1, {
	name = "nxte-cayo:loot3",
	heading =  63.75,
	debugPoly = false,
	minZ = 14.4,
	maxZ = 15.3,
}, {
	options = {
		{
            type = "client",
            event = "nxte-cayo:client:loot3",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})