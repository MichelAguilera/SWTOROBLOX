local Progression = require(script.Parent.ProgressionSystem_Server)
local Players = game:GetService("Players")

local function GetPlayerData(player)
    -- get from datastore
end

Players.PlayerAdded:Connect(function(player)
    -- local player_data = GetPlayerData(player)
    -- player, faction, specialization, level_points, ability_points, ability_pool
    local player_data = {
        ['faction'] = 'sith',
        ['specialization'] = 'test_spec',
        ['level_points'] = 400,
        ['ability_points'] = 3,
        ['ability_pool'] = {
            ['test_ab1'] = true,
            ['test_ab2'] = true
        }
    }

    Progression.Actor.new(player,   player_data['faction'], 
                                    player_data['specialization'], 
                                    player_data['level_points'], 
                                    player_data['ability_points'], 
                                    player_data['ability_pool'])
end)

