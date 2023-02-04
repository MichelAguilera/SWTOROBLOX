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
    local tempabilities = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)
    local tempargs = {
        -- METADATA
        ['player'] = Player,
        ['faction'] = 'sith',
        ['specialty'] = 'temp_spec',
        ['rank'] = 255, --TEMP

        -- STATS
        ['level_points'] = 300,
        ['ability_points'] = 500,

        -- ABILITIES
        ['abilities'] = {
            tempabilities.Pull,
            tempabilities.Push,
            tempabilities.Spark,
            tempabilities.Lightning
        }
    }

    -- a) Create Actor class for the player (Data from DataStore or new)
    local PlayerData = ServerDataStorage.mountPlayer(Player)
    local Actor_object = Actor.new(Player, PlayerData)
    local Actor = ActorStorage.mountActor(Actor_object)

    -- ActorStorage.viewAllActors()

    -- c) Get the player's data from the server to the client
    -- b) Store the Actor class in the Server

    Player.Chatted:Connect(function(String)
        print("Firig")
        require(s.sss.Server.DebugTools).onChat(String)
    end)
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
    local success, _error = _Actor:unlock_ability(_Ability.name, ability_requirement, _Ability)
    if success then
        print(_Actor)

        return true
    end

    print(_Actor)

    return false, _error
end

-- 5. Handle the players onLeave
function OnPlayerLeave(Player)
    -- a) Save the player's data to the Database
    -- b) Remove the player's data from the server

    ServerDataStorage.updateFromServer(Player, ActorStorage[Player.UserId])
    ServerDataStorage.unmountPlayer(Player)
end

-- X. The triggers

-- On DataRequest:ServerInvoke
DataRequest.OnServerInvoke = SendDataToPlayer

-- On Player JOIN
s.plrs.PlayerAdded:Connect(function(Player)
    OnPlayerJoin(Player)
end)

-- On Player LEAVE
s.plrs.PlayerRemoving:Connect(function(Player)
    OnPlayerLeave(Player)
end)