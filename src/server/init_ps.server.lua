local Progression = require(game:GetService("ServerScriptService").Server.ProgressionSystem_Server)
local Players = game:GetService("Players")
local SendData_RemoteEvent = game:GetService("ReplicatedStorage").Common.ProgressionSystem_Events.SendData
local Unlock_RemoteEvent = game:GetService("ReplicatedStorage").Common.ProgressionSystem_Events.UnlockUnlockable
local RequestPD_RemoteFunction = game:GetService("ReplicatedStorage").Common.ProgressionSystem_Events.RequestPlayerData

local function GetPlayerData(player)
    -- get from datastore

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

    return player_data
end

local function CreateActorObject(player)
    local player_data = GetPlayerData(player)

    local ActorObject = Progression.Actor.new(player,  player_data['faction'], 
                                                        player_data['specialization'], 
                                                        player_data['level_points'], 
                                                        player_data['ability_points'], 
                                                        player_data['ability_pool'])

    return ActorObject
end

Unlock_RemoteEvent.OnServerEvent:Connect(function(player, Ability)
    print(player, Ability)

    local pd = RequestPD_RemoteFunction


    player.ability_pool:unlock(player, Ability)
end)

Players.PlayerAdded:Connect(function(player) 
    local pd = CreateActorObject(player)
    SendData_RemoteEvent:FireClient(player, pd)
end)