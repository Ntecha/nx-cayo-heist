local QBCore = exports['qb-core']:GetCoreObject()

----- PROP -----
local laptopprop = nil

local Buyer = nil
local isActive = false
local CopCount = 0
local hackBlip = nil
local isHacked1 = false
local isHacked2 = false
local isHacked3 = false
local door1 = false
local door2 = false
local door3 = false
local door4 = false 
local Loot1 = false
local Loot2 = false
local Loot3 = false 
------------------------------------------- FUNCTIONS ------------------------------------------


local function LoadProps()
    laptopprop = CreateObject(`hei_prop_hst_laptop`,5082.89, -5758.54, 15.77, true, false, false)
    SetEntityHeading(laptopprop, 144.12)
    FreezeEntityPosition(laptopprop, true)
end

local function HackBlip(coords)
    hackBlip = AddBlipForCoord(coords)
    SetBlipSprite(hackBlip, 606)
    SetBlipColour(hackBlip, 66)
    SetBlipDisplay(hackBlip, 4)
    SetBlipScale(hackBlip, 0.8)
    SetBlipAsShortRange(hackBlip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Hack')
    EndTextCommandSetBlipName(hackBlip)
end

local function OnHack1Done(success)
    if success then 
        QBCore.Functions.Notify('Check your GPS for the next location!')
        QBCore.Functions.Notify('You successfully hacked the alarm system!','success')
        TriggerServerEvent('nxte-cayo:server:sethack1', true)
        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.HackI1tem, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack1Item], 'remove')
        RemoveBlip(hackBlip)
        HackBlip(vector3(5084.7, -5731.45, 15.77))
    else
        QBCore.Functions.Notify('You failed to hack the alarm system!', 'error')
        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.Hack1Item, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack1Item], 'remove')
    end
end

local function OnHack3Done(success)
    if success then 
        TriggerServerEvent('nxte-cayo:server:sethack3', true)
        QBCore.Functions.Notify('Go to the basement to grab the items!')
        QBCore.Functions.Notify('You successfully hacked the camera system!', 'success')
        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.Hack3Item, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack3Item], 'remove')
        RemoveBlip(hackBlip)
        if Config.SpawnPedOnHack3 then
            TriggerEvent('nxte-cayo:client:SpawnNPC', 2)
        end
    else
        QBCore.Functions.Notify('You failed to hack the camera system!', 'error')
        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.Hack3Item, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack3Item], 'remove')
    end
end

-- anim place the bomb 1
local PlantBomb1 = function()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId() 
    local pos = vector4(4992.27, -5756.36, 15.89, 328.39)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`prop_bomb_01`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        QBCore.Functions.Notify('The bomb will go off in '..Config.BombTimer..' seconds', 'success')
        Wait(Config.BombTimer * 1000)
        DeleteEntity(charge)  
        AddExplosion(4992.14, -5756.64, 15.89, 2, 5.0, true, false, 15.0) 
        TriggerServerEvent('nxte-cayo:server:opendoor', 'loot-door-1')
        QBCore.Functions.Notify('The door opened!', 'success')
    end)
end

local PlantBomb2 = function()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId() 
    local pos = vector4(4998.35, -5742.6, 14.95, 238.5)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`prop_bomb_01`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        QBCore.Functions.Notify('The bomb will go off in '..Config.BombTimer..' seconds', 'success')
        Wait(Config.BombTimer * 1000)
        DeleteEntity(charge)  
        AddExplosion(4998.35, -5742.6, 15.5, 2, 5.0, true, false, 15.0) 
        TriggerServerEvent('nxte-cayo:server:opendoor', 'loot-door-main')
        QBCore.Functions.Notify('The door opened!', 'success')
    end)
end

local PlantBomb3 = function()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId() 
    local pos = vector4(5001.87, -5746.45, 14.95, 146.38)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`prop_bomb_01`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        QBCore.Functions.Notify('The bomb will go off in '..Config.BombTimer..' seconds', 'success')
        Wait(Config.BombTimer * 1000)
        DeleteEntity(charge)  
        AddExplosion(5001.87, -5746.45, 15.83, 2, 5.0, true, false, 15.0) 
        TriggerServerEvent('nxte-cayo:server:opendoor', 'loot-door-cash')
        QBCore.Functions.Notify('The door opened!', 'success')
    end)
end

local PlantBomb4 = function()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId() 
    local pos = vector4(5007.9, -5753.78, 15.55, 146.7)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`prop_bomb_01`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        QBCore.Functions.Notify('The bomb will go off in '..Config.BombTimer..' seconds', 'success')
        Wait(Config.BombTimer * 1000)
        DeleteEntity(charge)  
        AddExplosion(5007.9, -5753.78, 16.71, 2, 5.0, true, false, 15.0) 
        TriggerServerEvent('nxte-cayo:server:opendoor', 'loot-door-glass')
        QBCore.Functions.Notify('The door opened!', 'success')
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
    end)
end

-------------------------------------------- EVENTS --------------------------------------------

-- start heist
RegisterNetEvent('nxte-cayo:client:startheist', function()
    TriggerServerEvent('nxte-cayo:server:getcops')
    TriggerServerEvent('nxte-cayo:server:setactive')
    local Player = QBCore.Functions.GetPlayerData()
    local cash = Player.money.cash
    local ped = PlayerPedId()
    SetEntityCoords(ped , vector3(4818.67, -4309.54, 4.7))
    SetEntityHeading(ped, 162.55)
    TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
    QBCore.Functions.Progressbar("knock", "Knocking on door...", 4000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if not isActive then 
            if CopCount >= Config.MinCop then
                if cash >= Config.JobPrice then
                    Buyer = Player.citizenid
                    LoadProps()
                    TriggerServerEvent('nxte-cayo:server:setactive', true)
                    QBCore.Functions.Notify('You purchased the GPS location for $'..Config.JobPrice..'!', 'success')
                    TriggerServerEvent('nxte-cayo:server:removemoney', Config.JobPrice)
                    HackBlip(vector3(4491.46, -4583.42, 5.57))
                else 
                    QBCore.Functions.Notify('I only talk to people who bring the money i ask for', 'error')
                end
            else 
                QBCore.Functions.Notify('There is not enough police', 'error')
            end   
        else 
            QBCore.Functions.Notify('No one seems to be home', 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled knocking on the door', 'error')
    end)
end)

-- hack 1
RegisterNetEvent('nxte-cayo:client:hack1', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
    QBCore.Functions.Progressbar("knock", "Preparing Equipement...", 4000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if isActive then 
            if QBCore.Functions.HasItem(Config.Hack1Item) then
                if not isHacked1 then
                    TriggerEvent('nxte-anim:hack1')
                else
                    QBCore.Functions.Notify('The alarm system has already been hacked !', 'error')
                end
            else
                QBCore.Functions.Notify('You do not have the right equipement to do this !', 'error')
            end
        else 
            QBCore.Functions.Notify('You can not do this right now', 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled preparing equipement', 'error')
    end)
end)

-- anim hack 1
RegisterNetEvent('nxte-anim:hack1', function()
    local loc = {x,y,z,h}
    loc.x = 4491.81
    loc.y = -4583.28
    loc.z = 6.2
    loc.h = 20.47

    local animDict = 'anim_heist@hs3f@ig1_hack_keypad@arcade@male@'
    RequestAnimDict(animDict)
    RequestModel('prop_phone_ing')
    RequestModel('hei_prop_hst_usb_drive')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('prop_phone_ing')
        or not HasModelLoaded('hei_prop_hst_usb_drive') do
        Wait(100)
    end

    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'action_var_01', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop_var_01', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'success_react_exit_var_01', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)

    -- props
    local phone = CreateObject(GetHashKey('prop_phone_ing'), targetPosition, 1, 1, 0)
    local usb = CreateObject(GetHashKey('hei_prop_hst_usb_drive'), targetPosition, 1, 1, 0)

    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'action_var_01', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(phone, netScene, animDict, 'action_var_01_prop_phone_ing', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(usb, netScene, animDict, 'action_var_01_ch_prop_ch_usb_drive01x', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop_var_01', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(phone, netScene2, animDict, 'hack_loop_var_01_prop_phone_ing', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(usb, netScene2, animDict, 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'success_react_exit_var_01', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(phone, netScene3, animDict, 'success_react_exit_var_01_prop_phone_ing', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(usb, netScene3, animDict, 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(4000)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.Hack1Time, Config.Hack1Squares, Config.Hack1Repeat, function(success)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4000)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(usb)
        DeleteObject(phone)
        FreezeEntityPosition(ped, false)
        OnHack1Done(success)
    end)
end)


-- hack 2
RegisterNetEvent('nxte-cayo:client:hack2', function()
    if isActive then
        if isHacked1 then 
            if not isHacked2 then 
                if QBCore.Functions.HasItem(Config.Hack2Item) then
                    TriggerEvent('nxte-anim:hack2')
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The door lock has already been hacked !', 'error')
            end
        else
            QBCore.Functions.Notify('The alarm system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- anim for hack 2
RegisterNetEvent('nxte-anim:hack2', function()
    local loc = {x,y,z,h} 
    loc.x = 5084.46
    loc.y = -5731.37
    loc.z = 17.0
    loc.h = 141.64

    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetPedComponentVariation(ped, 5, Config.HideBagID, 1, 1)
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports["memorygame"]:thermiteminigame(Config.Hack2Blocks, Config.Hack2FailBlocks, Config.Hack2TimeShow, Config.Hack2TimeHack,
    function() -- success
        if Config.SpawnPedOnHack2 then 
            TriggerEvent('nxte-cayo:client:SpawnNPC', 1)
        end
        RemoveBlip(hackBlip)
        HackBlip(vector3(5083.31, -5757.89, 15.83))
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        TriggerServerEvent('nxte-cayo:server:opendoor', 'cayo-side-door')
        TriggerServerEvent('nxte-cayo:server:sethack2', true)
        QBCore.Functions.Notify('You hacked the door lock!', 'success')
        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.Hack2Item, 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack2Item], 'remove')
    end,
    function() -- failure
        QBCore.Functions.Notify('You failed to hack the door lock!', 'error')
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
    end)
end)


-- hack 3
RegisterNetEvent('nxte-cayo:client:hack3', function()
    if isActive then
        if isHacked2 then 
            if not isHacked3 then
                if QBCore.Functions.HasItem(Config.Hack3Item) then
                    TriggerEvent('nxte-anim:hack3')
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The camera system has already been hacked !', 'error')
            end
        else
            QBCore.Functions.Notify('The lock system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- anim for hack 3
RegisterNetEvent('nxte-anim:hack3', function()
    local loc = {x,y,z,h} 
    loc.x = 5083.39 
    loc.y = -5757.81
    loc.z = 17.2
    loc.h = 145.33

    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetPedComponentVariation(ped, 5, Config.HideBagID, 1, 1)
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.Hack3Time, Config.Hack3Squares, Config.Hack3Repeat, function(success)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4000)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(laptop)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
        OnHack3Done(success)
    end)
end)

-- door 1
RegisterNetEvent('nxte-cayo:client:door1', function()
    if isActive then 
        if isHacked3 then 
            if not door1 then
                if QBCore.Functions.HasItem(Config.BombItem) then
                    exports["memorygame"]:thermiteminigame(Config.BombBlocks, Config.BombFailBlocks, Config.BombTimeShow, Config.BombTimeHack,
                    function() -- success
                        TriggerServerEvent('nxte-cayo:server:setdoor1', true)
                        PlantBomb1()
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end,
                    function() -- failure
                        QBCore.Functions.Notify('You failed to open the door', 'error')
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end)                                                                                                                                                        
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The door lock has already been opened!', 'error')
            end
        else
            QBCore.Functions.Notify('The camera system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- door 2
RegisterNetEvent('nxte-cayo:client:door2', function()
    if isActive then 
        if isHacked3 then 
            if not door2 then
                if QBCore.Functions.HasItem(Config.BombItem) then
                    exports["memorygame"]:thermiteminigame(Config.BombBlocks, Config.BombFailBlocks, Config.BombTimeShow, Config.BombTimeHack,
                    function() -- success
                        TriggerServerEvent('nxte-cayo:server:setdoor2', true)
                        PlantBomb2()
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end,
                    function() -- failure
                        QBCore.Functions.Notify('You failed to open the door', 'error')
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end)                                                                                                                                                        
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The door lock has already been opened!', 'error')
            end
        else
            QBCore.Functions.Notify('The camera system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- door 3
RegisterNetEvent('nxte-cayo:client:door3', function()
    if isActive then 
        if isHacked3 then 
            if not door3 then
                if QBCore.Functions.HasItem(Config.BombItem) then
                    exports["memorygame"]:thermiteminigame(Config.BombBlocks, Config.BombFailBlocks, Config.BombTimeShow, Config.BombTimeHack,
                    function() -- success
                        TriggerServerEvent('nxte-cayo:server:setdoor3', true)
                        PlantBomb3()
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end,
                    function() -- failure
                        QBCore.Functions.Notify('You failed to open the door', 'error')
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end)                                                                                                                                                        
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The door lock has already been opened!', 'error')
            end
        else
            QBCore.Functions.Notify('The camera system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- door 4
RegisterNetEvent('nxte-cayo:client:door4', function()
    if isActive then 
        if isHacked3 then 
            if not door4 then
                if QBCore.Functions.HasItem(Config.BombItem) then
                    exports["memorygame"]:thermiteminigame(Config.BombBlocks, Config.BombFailBlocks, Config.BombTimeShow, Config.BombTimeHack,
                    function() -- success
                        TriggerServerEvent('nxte-cayo:server:setdoor4', true)
                        PlantBomb4()
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        if Config.SpawnPedOnLootDoor then
                            TriggerEvent('nxte-cayo:client:SpawnNPC', 3)
                            Wait(5000)
                            TriggerEvent('nxte-cayo:client:SpawnNPC', 3)
                        end
                    end,
                    function() -- failure
                        QBCore.Functions.Notify('You failed to open the door', 'error')
                        TriggerServerEvent('nx-cayo:server:RemoveItem', Config.BombItem, 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.BombItem], 'remove')
                    end)                                                                                                                                                        
                else 
                    QBCore.Functions.Notify('You do not have the right tools to do this!', 'error')
                end
            else
                QBCore.Functions.Notify('The door lock has already been opened!', 'error')
            end
        else
            QBCore.Functions.Notify('The camera system is still active !', 'error')
        end
    else 
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

RegisterNetEvent('nxte-cayo:client:loot1', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
    QBCore.Functions.Progressbar("loot", "Searching barrel...", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if isActive then 
            if isHacked3 then
                if not Loot1 then 
                    local random = math.random(1,10)
                    if random >= 2 then -- normal loot 
                        local chance = math.random(Config.Loot1AmountMin,Config.Loot1AmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot1Item, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot1Item], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot1', true)
                    else -- rare loot 
                        local chance = math.random(Config.Loot1RareAmountMin,Config.Loot1RareAmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot1RareItem, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.LootRare1Item], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot1', true)
                    end
                else
                    QBCore.Functions.Notify('The barrel is already emptied' , 'error')
                end
            else
                QBCore.Functions.Notify('The camera system is still active' , 'error')
            end
        else 
            QBCore.Functions.Notify('You can\'t do this right now' , 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled searching the barrel', 'error')
    end)
end)

RegisterNetEvent('nxte-cayo:client:loot2', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
    QBCore.Functions.Progressbar("loot", "Searching safe...", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if isActive then 
            if isHacked3 then
                if not Loot2 then 
                    local random = math.random(1,10)
                    if random >= 2 then -- normal loot 
                        local chance = math.random(Config.Loot2AmountMin,Config.Loot2AmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot2Item, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot2Item], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot2', true)
                    else -- rare loot 
                        local chance = math.random(Config.Loot2RareAmountMin,Config.Loot2RareAmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot2RareItem, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.LootRare2Item], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot2', true)
                    end
                else
                    QBCore.Functions.Notify('The safe is already emptied' , 'error')
                end
            else
                QBCore.Functions.Notify('The camera system is still active' , 'error')
            end
        else 
            QBCore.Functions.Notify('You can\'t do this right now' , 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled searching the safe', 'error')
    end)
end)

RegisterNetEvent('nxte-cayo:client:loot3', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
    QBCore.Functions.Progressbar("loot", "Searching crate...", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if isActive then 
            if isHacked3 then
                if not Loot3 then 
                    local random = math.random(1,10)
                    if random >= 2 then -- normal loot 
                        local chance = math.random(Config.Loot3AmountMin,Config.Loot3AmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot3Item, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot3Item], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot3', true)
                    else -- rare loot 
                        local chance = math.random(Config.Loot3RareAmountMin,Config.Loot3RareAmountMax)
                        TriggerServerEvent('nx-cayo:server:AddItem', Config.Loot3RareItem, chance)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot3RareItem], 'add', chance)
                        TriggerServerEvent('nxte-cayo:server:setloot3', true)
                    end
                else
                    QBCore.Functions.Notify('The crate is already emptied' , 'error')
                end
            else
                QBCore.Functions.Notify('The camera system is still active' , 'error')
            end
        else 
            QBCore.Functions.Notify('You can\'t do this right now' , 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled searching the crate', 'error')
    end)
end)
-------------------------------------------- SERVER SYNC --------------------------------------
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('nxte-cayo:server:OnPlayerLoad')
end)

RegisterNetEvent('nxte-cayo:client:ResetHeist', function()
    DeleteEntity(laptopprop)
    TriggerServerEvent('nxte-cayo:server:ResetHeist')
end)
-- get cops
RegisterNetEvent('nxte-cayo:client:getcops', function(amount)
    CopCount = amount
end)

RegisterNetEvent('nxte-cayo:client:setactive', function(status)
    isActive = status
end)

RegisterNetEvent('nxte-cayo:client:sethack1', function(status)
    isHacked1 = status
end)

RegisterNetEvent('nxte-cayo:client:sethack2', function(status)
    isHacked2 = status
end)

RegisterNetEvent('nxte-cayo:client:sethack3', function(status)
    isHacked3 = status
end)

RegisterNetEvent('nxte-cayo:client:setdoor1', function(status)
    door1 = status
end)

RegisterNetEvent('nxte-cayo:client:setdoor2', function(status)
    door2 = status
end)

RegisterNetEvent('nxte-cayo:client:setdoor3', function(status)
    door3 = status
end)

RegisterNetEvent('nxte-cayo:client:setdoor4', function(status)
    door4 = status
end)

RegisterNetEvent('nxte-cayo:client:setloot1', function(status)
    Loot1 = status
end)

RegisterNetEvent('nxte-cayo:client:setloot2', function(status)
    Loot2 = status
end)

RegisterNetEvent('nxte-cayo:client:setloot3', function(status)
    Loot3 = status
end)


------------------------------------------ NPC's --------------------------------------------
-- set NPC data
RegisterNetEvent('nxte-cayo:client:SpawnNPC', function(position)
    QBCore.Functions.TriggerCallback('nxte-cayo:server:SpawnNPC', function(netIds, position)
        Wait(1000)
        local ped = PlayerPedId()
        for i=1, #netIds, 1 do
            local npc = NetworkGetEntityFromNetworkId(netIds[i])
            SetPedDropsWeaponsWhenDead(npc, false)
            GiveWeaponToPed(npc, Config.PedGun, 250, false, true)
            SetPedMaxHealth(npc, 300)
            SetPedArmour(npc, 200)
            SetCanAttackFriendly(npc, true, false)
            TaskCombatPed(npc, ped, 0, 16)
            SetPedCombatAttributes(npc, 46, true)
            SetPedCombatAttributes(npc, 0, false)
            SetPedCombatAbility(npc, 100)
            SetPedAsCop(npc, true)
            SetPedRelationshipGroupHash(npc, `HATES_PLAYER`)
            SetPedAccuracy(npc, Config.SetPedAccuracy)
            SetPedFleeAttributes(npc, 0, 0)
            SetPedKeepTask(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
        end
    end, position)
end)

---------------------------------------------- Reset Heist -----------------------------------------
-- reset heist after start
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isActive then
            Citizen.Wait(Config.StartTimer*60000)
            RemoveBlip(hackBlip)
            TriggerEvent('nxte-cayo:client:ResetHeist')
        end
    end
end)


-- reset heist after success
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if Loot1 and Loot2 and Loot3 then
            RemoveBlip(hackBlip)
            Citizen.Wait(Config.FinishTimer*60000)
            TriggerEvent('nxte-cayo:client:ResetHeist')
        end
    end
end)

-- reset heist on player death
Citizen.CreateThread(function()
    while true do
        if isActive then
            local Player = QBCore.Functions.GetPlayerData()
            local Playerid = Player.citizenid
            if Playerid == Buyer then
                if Player.metadata["inlaststand"] or Player.metadata["isdead"] then
                    QBCore.Functions.Notify('Mission Failed', 'error')
                    TriggerEvent('nxte-cayo:client:ResetHeist')
                    Citizen.Wait(2000)
                    Buyer = nil
                end
            end
        end
        Citizen.Wait(5000)
    end
end)
































































































-- animation for the hack
RegisterNetEvent('nxte-zancudo:anim:hack1', function()
    -- positioning of ped
    local loc = {x,y,z,h}
    loc.x = -2389.72
    loc.y = 2965.3
    loc.z = 34.06
    loc.h = 14.95

    -- Loading Anim Dictionary
    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetPedComponentVariation(ped, 5, Config.HideBagID, 1, 1)
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.HackTime, Config.HackSquares, Config.HackRepeat, function(success)
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        SetPedComponentVariation(ped, 5, Config.BagUseID, 0, 1)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        OnHackDone(success)
    end)
end)