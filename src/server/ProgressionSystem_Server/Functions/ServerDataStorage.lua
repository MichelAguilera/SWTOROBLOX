local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local DS_KEY = require(s.sss.Server.ProgressionSystem_Dependencies.dskey)
local DS_service = s.dss
local DS = DS_service:GetDataStore(DS_KEY)

-- Class dependencies
local Ability = require(s.sss.Server.ProgressionSystem_Server.Classes.Ability)
local AbilityList = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)
local Actor = require(s.sss.Server.ProgressionSystem_Server.Classes.Actor)
local ActorStorage = require(s.sss.Server.ProgressionSystem_Server.ActorStorage)

-- DataStore LEGACY functions
legacy = {}

function legacy.dataUnpack(data)

    -- Player
    data.player = s.plrs:GetPlayerByUserId(data.player)

    -- Abilities
    for i, ability in pairs(data.abilities) do
        local ability_data = AbilityList[ability[1]]
        data.abilities[i] = ability_data
        data.abilities[i].isLocked = ability[2]
    end

    local unpacked = Actor.new(data.player, data)
    return unpacked
end

function legacy.dataPack(data) -- its a ######## pointer...

    print('dataPack', data)
    -- Player
    data.player = data.player.UserId

    -- Abilities
    for i, ability in pairs(data.abilities) do
        data.abilities[i] = {ability.name, ability.isLocked}
    end

    return data
end

function legacy.default(key)
    local tempabilities = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)
    local default = {
        -- METADATA
        ['player'] = key, -- UserId
        ['faction'] = 'none',
        ['specialty'] = 'none',
        ['rank'] = 0, --TEMP
    
        -- STATS
        ['level_int'] = 300, -- TEMP
        ['ability_int'] = 500, -- TEMP
    
        -- ABILITIES
        ['abilities'] = { -- TEMP / CANNOT BE CLASSES, MUST BE NAME STRINGS
            {'Pull', true},
            {'Push', true},
            {'Spark', true},
            {'Lightning', true}
        }
    }

    return default
end

function legacy.save(datastore, key, data)
    print('Saving', time())

    data = legacy.dataPack(data)

    local success, errorMessage = pcall(function()
        print(key, data)
        datastore:SetAsync(key, data)
    end)
    if not success then
        return false, errorMessage
    end
end

function legacy.get(datastore, key)
    local data = datastore:GetAsync(key)
    local actor

    if data == nil then
        print("Making default", data)
        data = legacy.default(key)
    end

    print(data)
    actor = legacy.dataUnpack(data)
    return actor
end

-- Server Data Storage
SDS = {}

-- Server Data Storage Functions
function SDS.mountPlayer(Player)
    local PlayerData = legacy.get(DS, Player.UserId) -- Actor object
    table.insert(SDS, Player.UserId, PlayerData)

    return SDS.getPlayer(Player)
end

function SDS.unmountPlayer(Player) -- I don't know if this is safe or not
    local function attemptSave(attempts)  -- Recursive
        local attempts = attempts or 0
        
        SDS[Player.UserId] = ActorStorage.getActor(SDS[Player.UserId])
        ActorStorage.unmountActor(SDS[Player.UserId])
        
        local success, errorMessage = legacy.save(DS, Player.UserId, SDS[Player.UserId])

        if attempts > 5 then return end

        if not success then
            warn(errorMessage)
            attemptSave(attempts + 1)
        else
            print(DS:GetAsync(Player.UserId))
        end
    end

    attemptSave(0)
    SDS[Player.UserId] = nil
end

function SDS.updateFromServer(Player, Data)
    SDS[Player.UserId] = Data
end

function SDS.getPlayer(Player)
    return SDS[Player.UserId]
end

return SDS