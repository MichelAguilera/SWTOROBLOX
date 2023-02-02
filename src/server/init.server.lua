local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local ServerDataStorage = require(script.ProgressionSystem_Server.Functions.ServerDataStorage)
local ActorStorage = require(script.ProgressionSystem_Server.ActorStorage)

--- FUNCTIONS
local DataTransfer = require(s.sss.Server.ProgressionSystem_Server.Functions.DataTransfer)

---- CLASSES
local Actor = require(s.sss.Server.ProgressionSystem_Server.Classes.Actor)

-- INIT SERVER

--[[
    1. Create the preload
    2. Handle the player onJoin
    3. Load the data from the server to the client
    4. Handle the transfer of information between the client and the server
    5. Handle the player onLeave
    6. The triggers
]]

-- 1. Create the RemoteEvents
function CreateEvents()
    
end

-- 2. Handle the player onJoin
function OnPlayerJoin(Player)
    local tempargs = {
        -- METADATA
        ['player'] = Player,
        ['faction'] = 'sith',
        ['specialty'] = 'temp_spec',
        ['rank'] = 255, --TEMP

        -- STATS
        ['level_int'] = 500,
        ['ability_point'] = 4
    }

    -- a) Create Actor class for the player (Data from DataStore or new)
    local PlayerData = ServerDataStorage.mountPlayer(Player)
    local Actor_object = Actor.new(Player, tempargs)
    local Actor = ActorStorage.mountActor(Actor)

    -- c) Get the player's data from the server to the client
    -- b) Store the Actor class in the Server
end

-- 3. Load the data from the server to the client
local function LoadDataToPlayer(Player, Data)
    -- Gets the data from the server to the client
end

-- 4. Handle the transfer of information between the client and the server
local function toClient(Player)
    -- Transfers data to the client
end

local function fromClient(Data)
    -- Recieves the data from the client
end

-- 5. Handle the players onLeave
function OnPlayerLeave(Player)
    -- a) Save the player's data to the Database
    -- b) Remove the player's data from the server
end


-- 6. The triggers
s.plrs.PlayerAdded:Connect(function()
    --
end)