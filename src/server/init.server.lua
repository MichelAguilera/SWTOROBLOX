local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- 1. Handle the preload (RUNS ON SERVER STARTUP)
local Preload = require(s.sss.Server.ProgressionSystem_Server.Functions.Preload).run_all()

--------------------------------------------------------------------------------
-- DEPENDENCIES
local ServerDataStorage = require(script.ProgressionSystem_Server.Functions.ServerDataStorage)
local ActorStorage = require(script.ProgressionSystem_Server.ActorStorage)

--- REMOTE EVENTS
local DataSend = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataSend')
local DataRequest = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataRequest')

-- REMOTE FUNCTIONS
local UnlockAbility = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('UnlockAbility')

---- CLASSES
local Actor = require(s.sss.Server.ProgressionSystem_Server.Classes.Actor)
local Ability = require(s.sss.Server.ProgressionSystem_Server.Classes.Ability)

-- INIT SERVER

--[[
    1. Handle the preload
    2. Handle the player onJoin
    3. Load the data from the server to the client
    4. Handle the transfer of information between the client and the server
    5. Handle the player onLeave
    6. The triggers
]]

-- 2. Handle the player onJoin
function OnPlayerJoin(Player)

    --[[
        The data will actually be from the DataStore,
        or if no Data exists, the starting default will be applied here.
        For now it is just test Data for the system.
        This step exists in 2a:
    ]]
    local tempargs = {
        -- METADATA
        ['player'] = Player,
        ['faction'] = 'sith',
        ['specialty'] = 'temp_spec',
        ['rank'] = 255, --TEMP

        -- STATS
        ['level_points'] = 500,
        ['ability_points'] = 2,

        -- ABILITIES
        ['abilities'] = {
            [1] = {
                ["img_id"]          = 3845386987,
                ["name"]            = "test", 
                ["is_common"]       = false, 
                ["faction"]         = "sith", 
                ["specialization"]  = "test_spec", 
                ["by_rank"]         = true, 
                ["by_grind"]        = true, 
                ["min_rank"]        = 1,
                ["min_grind"]       = 0,
                ["cost"]            = 1,
                ["required_unlockable"] = {"test_ab1"},
                ["isLocked"]        = true
            },
        
            [2] = {
                ["img_id"]          = 3845386987,
                ["name"]            = "test_ab1", 
                ["is_common"]       = false, 
                ["faction"]         = "sith", 
                ["specialization"]  = "test_spec", 
                ["by_rank"]         = true, 
                ["by_grind"]        = true, 
                ["min_rank"]        = 1,
                ["min_grind"]       = 0,
                ["cost"]            = 1,
                ["required_unlockable"] = {},
                ["isLocked"]        = true
            },
        
            [3] = {
                ["img_id"]          = 3845386987,
                ["name"]            = "test_ab2", 
                ["is_common"]       = false, 
                ["faction"]         = "sith", 
                ["specialization"]  = "test_spec", 
                ["by_rank"]         = true, 
                ["by_grind"]        = true, 
                ["min_rank"]        = 1,
                ["min_grind"]       = 0,
                ["cost"]            = 1,
                ["required_unlockable"] = {},
                ["isLocked"]        = true
            }
        }
    }

    -- a) Create Actor class for the player (Data from DataStore or new)
    local PlayerData = ServerDataStorage.mountPlayer(Player)
    local Actor_object = Actor.new(Player, tempargs)
    local Actor = ActorStorage.mountActor(Actor_object)

    -- ActorStorage.viewAllActors()

    -- c) Get the player's data from the server to the client
    -- b) Store the Actor class in the Server
end

-- 3. Load the data from the server to the client
local function SendDataToPlayer(Player)
    return ActorStorage[Player.UserId]
end

-- 4. Handle the transfer of information between the client and the server
-- UnlockAbility
UnlockAbility.OnServerInvoke = function(player, ability_name, ability_requirement) -- Instance, String, Array[index = String]
    -- print(player, ability_name, ability_requirement)
    local GetActorFromPlayer = function(_player)
        return ActorStorage[_player.UserId]
    end

    local function GetIndexOfValue(tabl, value)
        -- print(tabl, value)
        for index, Ability in ipairs(tabl) do
            if Ability.name == value then
                return index
            end
        end
    end

    local _Actor = GetActorFromPlayer(player)
    local abilities_available = _Actor.abilities
    local _Ability = abilities_available[GetIndexOfValue(abilities_available, ability_name)]

    -- NOTE: The unlock will have to run through Actor class instead of here; to check the ability points available.
    if _Actor:unlock_ability(_Ability.name, ability_requirement, _Ability) then
        return true
    end
    return false
end

-- 5. Handle the players onLeave
function OnPlayerLeave(Player)
    -- a) Save the player's data to the Database
    -- b) Remove the player's data from the server
end

-- X. The triggers

-- On DataRequest:ServerInvoke
DataRequest.OnServerInvoke = SendDataToPlayer

-- On Player JOIN
s.plrs.PlayerAdded:Connect(function(Player)
    OnPlayerJoin(Player)
end)