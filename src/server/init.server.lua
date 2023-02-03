local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- 1. Handle the preload (RUNS ON SERVER STARTUP)
local Preload = require(s.sss.Server.ProgressionSystem_Server.Functions.Preload).run_all()

--------------------------------------------------------------------------------
-- DEPENDENCIES
local ServerDataStorage = require(script.ProgressionSystem_Server.Functions.ServerDataStorage)
local ActorStorage = require(script.ProgressionSystem_Server.ActorStorage)

--- EVENTS
local DataSend = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataSend')
local DataRequest = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataRequest')

---- CLASSES
local Actor = require(s.sss.Server.ProgressionSystem_Server.Classes.Actor)

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
        ['level_int'] = 500,
        ['ability_point'] = 4,

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
                ["required_unlockable"] = {"test_ab1"}
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
                ["required_unlockable"] = {}
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
                ["required_unlockable"] = {}
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
    print("Sending data to player")
    return ActorStorage[Player.UserId]
end

-- 4. Handle the transfer of information between the client and the server


-- 5. Handle the players onLeave
function OnPlayerLeave(Player)
    -- a) Save the player's data to the Database
    -- b) Remove the player's data from the server
end


-- 6. The triggers

-- On DataRequest:ServerInvoke
DataRequest.OnServerInvoke = SendDataToPlayer

-- On Player JOIN
s.plrs.PlayerAdded:Connect(function(Player)
    OnPlayerJoin(Player)
end)