local QBCore = exports['qb-core']:GetCoreObject()

local isActive = false
local CopCount = 0
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

-- remove money
RegisterNetEvent('nxte-cayo:server:removemoney', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney('cash', tonumber(amount))
end)

-- open a door
RegisterNetEvent('nxte-cayo:server:opendoor', function(doorid)
    local src = source
    TriggerClientEvent('qb-doorlock:client:setState', -1, src, doorid, false, false, false, false)
end)

-- open a door
RegisterNetEvent('nxte-cayo:server:closedoor', function(doorid)
    local src = source
    TriggerClientEvent('qb-doorlock:client:setState', -1, src, doorid, true, false, false, false)
end)




------------------------------------ SERVER SYNC -----------------------------------
RegisterNetEvent('nxte-cayo:server:OnPlayerLoad', function()
    TriggerEvent('nxte-cayo:server:setactive', isActive)
    TriggerEvent('nxte-cayo:server:sethack1', isHacked1)
    TriggerEvent('nxte-cayo:server:sethack2', isHacked2)
    TriggerEvent('nxte-cayo:server:sethack3', isHacked3)
    TriggerEvent('nxte-cayo:server:setdoor1', door1)
    TriggerEvent('nxte-cayo:server:setdoor2', door2)
    TriggerEvent('nxte-cayo:server:setdoor3', door3)
    TriggerEvent('nxte-cayo:server:setdoor4', door4)
    TriggerEvent('nxte-cayo:server:setloot1', Loot1)
    TriggerEvent('nxte-cayo:server:setloot2', Loot2)
    TriggerEvent('nxte-cayo:server:setloot3', Loot3)
end)

RegisterNetEvent('nxte-cayo:server:ResetHeist', function()
    TriggerEvent('nxte-cayo:server:setactive', false)
    TriggerEvent('nxte-cayo:server:sethack1', false)
    TriggerEvent('nxte-cayo:server:sethack2', false)
    TriggerEvent('nxte-cayo:server:sethack3', false)
    TriggerEvent('nxte-cayo:server:setdoor1', false)
    TriggerEvent('nxte-cayo:server:setdoor2', false)
    TriggerEvent('nxte-cayo:server:setdoor3', false)
    TriggerEvent('nxte-cayo:server:setdoor4', false)
    TriggerEvent('nxte-cayo:server:setloot1', false)
    TriggerEvent('nxte-cayo:server:setloot2', false)
    TriggerEvent('nxte-cayo:server:setloot3', false)
    TriggerEvent('nxte-cayo:server:closedoor', 'loot-door-1')
    TriggerEvent('nxte-cayo:server:closedoor', 'loot-door-main')
    TriggerEvent('nxte-cayo:server:closedoor', 'loot-door-cash')
    TriggerEvent('nxte-cayo:server:closedoor', 'loot-door-glass')
end)


RegisterNetEvent('nxte-cayo:server:getcops', function()
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    CopCount = amount
    TriggerClientEvent('nxte-cayo:client:getcops', -1, amount)
end)

RegisterNetEvent('nxte-cayo:server:setactive', function(status)
    if status ~= nil then
        isActive = status
        TriggerClientEvent('nxte-cayo:client:setactive', -1, isActive)
    else 
        TriggerClientEvent('nxte-cayo:client:setactive', -1, isActive)
    end
end)

RegisterNetEvent('nxte-cayo:server:sethack1', function(status)
    if status ~= nil then
        isHacked1 = status
        TriggerClientEvent('nxte-cayo:client:sethack1', -1, isHacked1)
    else 
        TriggerClientEvent('nxte-cayo:client:sethack1', -1, isHacked1)
    end
end)

RegisterNetEvent('nxte-cayo:server:sethack2', function(status)
    if status ~= nil then
        isHacked2 = status
        TriggerClientEvent('nxte-cayo:client:sethack2', -1, isHacked2)
    else 
        TriggerClientEvent('nxte-cayo:client:sethack2', -1, isHacked2)
    end
end)

RegisterNetEvent('nxte-cayo:server:sethack3', function(status)
    if status ~= nil then
        isHacked3 = status
        TriggerClientEvent('nxte-cayo:client:sethack3', -1, isHacked3)
    else 
        TriggerClientEvent('nxte-cayo:client:sethack3', -1, isHacked3)
    end
end)

RegisterNetEvent('nxte-cayo:server:setdoor1', function(status)
    if status ~= nil then
        door1 = status
        TriggerClientEvent('nxte-cayo:client:setdoor1', -1, door1)
    else 
        TriggerClientEvent('nxte-cayo:client:setdoor1', -1, door1)
    end
end)

RegisterNetEvent('nxte-cayo:server:setdoor2', function(status)
    if status ~= nil then
        door2 = status
        TriggerClientEvent('nxte-cayo:client:setdoor2', -1, door2)
    else 
        TriggerClientEvent('nxte-cayo:client:setdoor2', -1, door2)
    end
end)

RegisterNetEvent('nxte-cayo:server:setdoor3', function(status)
    if status ~= nil then
        door3 = status
        TriggerClientEvent('nxte-cayo:client:setdoor3', -1, door3)
    else 
        TriggerClientEvent('nxte-cayo:client:setdoor3', -1, door3)
    end
end)

RegisterNetEvent('nxte-cayo:server:setdoor4', function(status)
    if status ~= nil then
        door4 = status
        TriggerClientEvent('nxte-cayo:client:setdoor4', -1, door4)
    else 
        TriggerClientEvent('nxte-cayo:client:setdoor4', -1, door4)
    end
end)

RegisterNetEvent('nxte-cayo:server:setloot1', function(status)
    if status ~= nil then
        Loot1 = status
        TriggerClientEvent('nxte-cayo:client:setloot1', -1, Loot1)
    else 
        TriggerClientEvent('nxte-cayo:client:setloot1', -1, Loot1)
    end
end)

RegisterNetEvent('nxte-cayo:server:setloot2', function(status)
    if status ~= nil then
        Loot2 = status
        TriggerClientEvent('nxte-cayo:client:setloot2', -1, Loot2)
    else 
        TriggerClientEvent('nxte-cayo:client:setloot2', -1, Loot2)
    end
end)

RegisterNetEvent('nxte-cayo:server:setloot3', function(status)
    if status ~= nil then
        Loot3 = status
        TriggerClientEvent('nxte-cayo:client:setloot3', -1, Loot3)
    else 
        TriggerClientEvent('nxte-cayo:client:setloot3', -1, Loot3)
    end
end)



------------------------------------------- NPC ---------------------------------------------
-- NPC 
local peds = { 
    `mp_m_securoguard_01`,
    `s_m_m_security_01`,
    `s_m_m_highsec_01`,
    `s_m_m_highsec_02`,
    `s_m_m_marine_01`,
    `s_m_m_prisguard_01`,
    `s_m_m_strpreach_01`,
    `s_m_y_armymech_01`,
}

local getRandomNPC = function()
    return peds[math.random(#peds)]
end

QBCore.Functions.CreateCallback('nxte-cayo:server:SpawnNPC', function(source, cb, loc)
    local netIds = {}
    local netId
    local npc
    for i=1, #Config.Shooters['soldiers'].locations[loc].peds, 1 do
        npc = CreatePed(30, getRandomNPC(), Config.Shooters['soldiers'].locations[loc].peds[i], true, false)
        while not DoesEntityExist(npc) do Wait(10) end
        netId = NetworkGetNetworkIdFromEntity(npc)
        netIds[#netIds+1] = netId
    end
    cb(netIds)
end)


RegisterNetEvent('nx-cayo:server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item,amount)
end)
RegisterNetEvent('nx-cayo:server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item,amount)
end)