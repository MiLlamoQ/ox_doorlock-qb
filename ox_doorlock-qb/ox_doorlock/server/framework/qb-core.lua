-- local QBCore = exports['qb-core']:GetCoreObject()

-- SetTimeout(0, function()
--     -- Set up GetPlayer function
--     GetPlayer = QBCore.Functions.GetPlayer

--     -- Ensure that the inventory system is available before defining the item-related functions
--     if not QBCore.Functions.GetConfig().OxInventory then
--         -- Function to remove an item from the player's inventory
--         function RemoveItem(playerId, item)
--             local player = GetPlayer(playerId)

--             if player then 
--                 player.Functions.RemoveItem(item, 1) 
--             end
--         end

--         ---@param player table
--         ---@param items string[] | { name: string, remove?: boolean, metadata?: string }[] 
--         ---@param removeItem? boolean
--         ---@return string?
--         function DoesPlayerHaveItem(player, items, removeItem)
--             for i = 1, #items do
--                 local item = items[i]
--                 local itemName = item.name or item
--                 local data = player.Functions.GetItemByName(itemName)

--                 if data and data.amount > 0 then
--                     if removeItem or item.remove then
--                         player.Functions.RemoveItem(itemName, 1)
--                     end

--                     return itemName
--                 end
--             end
--         end
--     end
-- end)

-- -- GetCharacterId now uses player.source and the QBCore structure
-- function GetCharacterId(player)
--     return player.PlayerData.citizenid
-- end

-- -- IsPlayerInGroup now works with the QBCore player object and job system
-- function IsPlayerInGroup(player, filter)
--     local filterType = type(filter)  -- Changed from 'type' to 'filterType' to avoid conflict

--     if filterType == 'string' then
--         if player.PlayerData.job.name == filter then
--             return player.PlayerData.job.name, player.PlayerData.job.grade.level
--         end
--     else
--         local tableType = type(filter)  -- Changed from 'type' to 'tableType' to avoid conflict

--         if tableType == 'table' then
--             local grade = filter[player.PlayerData.job.name]

--             if grade and grade <= player.PlayerData.job.grade.level then
--                 return player.PlayerData.job.name, player.PlayerData.job.grade.level
--             end
--         elseif tableType == 'array' then
--             for i = 1, #filter do
--                 if player.PlayerData.job.name == filter[i] then
--                     return player.PlayerData.job.name, player.PlayerData.job.grade.level
--                 end
--             end
--         end
--     end
-- end













local QBCore = exports['qb-core']:GetCoreObject()

SetTimeout(0, function()
    -- Set up GetPlayer function
    GetPlayer = QBCore.Functions.GetPlayer

    -- If you have OxInventory in your config, check it here
    -- Assuming OxInventory is a setting in the config
    if not Config.OxInventory then  -- Change to how you store OxInventory in your config
        -- Function to remove an item from the player's inventory
        function RemoveItem(playerId, item)
            local player = GetPlayer(playerId)

            if player then 
                player.Functions.RemoveItem(item, 1) 
            end
        end

        ---@param player table
        ---@param items string[] | { name: string, remove?: boolean, metadata?: string }[] 
        ---@param removeItem? boolean
        ---@return string?
        function DoesPlayerHaveItem(player, items, removeItem)
            for i = 1, #items do
                local item = items[i]
                local itemName = item.name or item
                local data = player.Functions.GetItemByName(itemName)

                if data and data.amount > 0 then
                    if removeItem or item.remove then
                        player.Functions.RemoveItem(itemName, 1)
                    end

                    return itemName
                end
            end
        end
    end
end)

-- GetCharacterId now uses player.source and the QBCore structure
function GetCharacterId(player)
    return player.PlayerData.citizenid
end

-- IsPlayerInGroup now works with the QBCore player object and job system
function IsPlayerInGroup(player, filter)
    local filterType = type(filter)  -- Changed from 'type' to 'filterType' to avoid conflict

    if filterType == 'string' then
        if player.PlayerData.job.name == filter then
            return player.PlayerData.job.name, player.PlayerData.job.grade.level
        end
    else
        local tableType = type(filter)  -- Changed from 'type' to 'tableType' to avoid conflict

        if tableType == 'table' then
            local grade = filter[player.PlayerData.job.name]

            if grade and grade <= player.PlayerData.job.grade.level then
                return player.PlayerData.job.name, player.PlayerData.job.grade.level
            end
        elseif tableType == 'array' then
            for i = 1, #filter do
                if player.PlayerData.job.name == filter[i] then
                    return player.PlayerData.job.name, player.PlayerData.job.grade.level
                end
            end
        end
    end
end
