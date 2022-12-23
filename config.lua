Config = {}

------------------------------------------------ HEIST ----------------------------------------------------------
Config.MinCop = 1 -- min amount of cops needed for the heist to be able to stawrt
Config.JobPrice = 10000 -- price to start the heist 
Config.StartTimer = 120 -- amount of time before script resets afther the heist was started - in minuits
Config.FinishTimer = 60 -- amount of time before script resets afther the heist was successfully done - in minuits

------------------------------------------------ REWARDS ----------------------------------------------------------


------------------------------------------------ HACK ----------------------------------------------------------

-- hack 1 
Config.Hack1Item = 'trojan_usb' -- item needed to do hack 1 
Config.Hack1Time = 12 -- amount of time player has to do the hack 
Config.Hack1Squares = 2 -- amount of squares player has to hack 
Config.Hack1Repeat = 1 -- amount of time player has to complete the hack

-- hack 2
Config.Hack2Item = 'electronickit' -- item needed to do hack 1 
Config.Hack2Blocks = 2 --Number of correct blocks the player needs to click
Config.Hack2FailBlocks = 2 --number of incorrect blocks after which the game will fail
Config.Hack2TimeShow = 10 --time in secs for which the right blocks will be shown
Config.Hack2TimeHack = 10 --maximum time after timetoshow expires for player to select the right blocks

-- hack 3
Config.Hack3Item = 'trojan_usb' -- item needed to do hack 1 
Config.Hack3Time = 12 -- amount of time player has to do the hack 
Config.Hack3Squares = 2 -- amount of squares player has to hack 
Config.Hack3Repeat = 1 -- amount of time player has to complete the hack


-- door hack 
Config.BombTimer = 10 -- how long the bomb needs to explode
Config.BombItem = 'thermite'
Config.BombBlocks = 2 --Number of correct blocks the player needs to click
Config.BombFailBlocks = 2 --number of incorrect blocks after which the game will fail
Config.BombTimeShow = 10 --time in secs for which the right blocks will be shown
Config.BombTimeHack = 10 --maximum time after timetoshow expires for player to select the right blocks

-- loot 1
Config.Loot1Item = 'weapon_combatpistol'-- item that can be received from loot 1 
Config.Loot1AmountMin = 1 -- Min amount that item can be received
Config.Loot1AmountMax = 3 -- Max amount that item can be received
Config.Loot1RareItem = 'weapon_microsmg' -- rare item that can be received from loot 1 
Config.Loot1RareAmountMin = 1 -- Min amount that rare item can be received
Config.Loot1RareAmountMax = 3 -- Max amount that rare item can be received

-- loot 2
Config.Loot2Item = 'goldbar'-- item that can be received from loot 1 
Config.Loot2AmountMin = 1 -- Min amount that item can be received
Config.Loot2AmountMax = 4 -- Max amount that item can be received
Config.Loot2RareItem = 'weapon_assaultrifle' -- rare item that can be received from loot 1 
Config.Loot2RareAmountMin = 1 -- Min amount that rare item can be received
Config.Loot2RareAmountMax = 2 -- Max amount that rare item can be received

-- loot 3
Config.Loot3Item = 'goldbar'-- item that can be received from loot 1 
Config.Loot3AmountMin = 1 -- Min amount that item can be received
Config.Loot3AmountMax = 4 -- Max amount that item can be received
Config.Loot3RareItem = 'weapon_assaultrifle' -- rare item that can be received from loot 1 
Config.Loot3RareAmountMin = 1 -- Min amount that rare item can be received
Config.Loot3RareAmountMax = 2 -- Max amount that rare item can be received

------------------------------------------------ NPC's ----------------------------------------------------------

Config.SpawnPedOnHack2 = true -- spawn npc's on the 2nd hack
Config.SpawnPedOnHack3 = true -- spawn npc's on the 3th hack
Config.SpawnPedOnLootDoor = true -- spawn npc's on the loot door being opened 

--NPC
Config.PedGun = 'weapon_microsmg' -- weapon NPC's use
Config.SetPedAccuracy = 100 -- (between 10-100)
-- NPC coords
Config.Shooters = {
    ['soldiers'] = {
        locations = {
            [1] = { -- on hack 2
                peds = {vector3(5004.05, -5696.49, 19.88),vector3(5019.25, -5681.98, 19.88),vector3(4999.19, -5703.44, 20.08),vector3(4994.99, -5714.0, 19.88),vector3(4980.56, -5731.76, 19.88),vector3(4973.58, -5745.91, 19.88),vector3(4996.33, -5803.44, 20.88),vector3(5005.3, -5795.98, 17.49),vector3(5021.74, -5806.51, 17.48),vector3(5031.18, -5800.11, 17.48),vector3(5040.13, -5795.01, 17.48),vector3(5043.32, -5783.35, 15.68),vector3(5033.58, -5763.38, 15.71)}
            },
            [2] = { -- on hack 3
                peds = {vector3(5004.05, -5696.49, 19.88),vector3(5019.25, -5681.98, 19.88),vector3(4999.19, -5703.44, 20.08),vector3(4994.99, -5714.0, 19.88),vector3(4980.56, -5731.76, 19.88),vector3(4973.58, -5745.91, 19.88),vector3(4996.33, -5803.44, 20.88),vector3(5005.3, -5795.98, 17.49),vector3(5021.74, -5806.51, 17.48),vector3(5031.18, -5800.11, 17.48),vector3(5040.13, -5795.01, 17.48),vector3(5043.32, -5783.35, 15.68),vector3(5033.58, -5763.38, 15.71)}
            },
            [3] = { -- on hack 3
                peds = {vector3(5004.05, -5696.49, 19.88),vector3(5019.25, -5681.98, 19.88),vector3(4999.19, -5703.44, 20.08),vector3(4994.99, -5714.0, 19.88),vector3(4980.56, -5731.76, 19.88),vector3(4973.58, -5745.91, 19.88),vector3(4996.33, -5803.44, 20.88),vector3(5005.3, -5795.98, 17.49),vector3(5021.74, -5806.51, 17.48),vector3(5031.18, -5800.11, 17.48),vector3(5040.13, -5795.01, 17.48),vector3(5043.32, -5783.35, 15.68),vector3(5033.58, -5763.38, 15.71)}
            },
        },
    }
}