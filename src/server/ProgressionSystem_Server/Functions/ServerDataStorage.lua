local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local DS_KEY = require(s.sss.Server.ProgressionSystem_Dependencies.dskey)
local DS_service = s.dss
local DS = DS_service:GetDataStore(DS_KEY)

-- Class dependencies
local Ability = require(s.sss.Server.ProgressionSystem_Server.Classes.Ability)
local AbilityList = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)

-- DataStore LEGACY functions
legacy = {}

function legacy.dataUnpack(data)

    -- Player
    data.player = s.plrs:GetPlayerByUserId(data.player)

    -- Abilities
    for i, ability in pairs(data.abilities) do
        local ability_object = Ability.new(AbilityList[ability])
        data.abilities[i] = ability_object
    end

    return data
end

function legacy.dataPack(old_data)
    local new_data = old_data

    -- Player
    new_data.player = old_data.player.UserId

    -- Abilities
    for i, ability in pairs(old_data.abilities) do
        table.insert(new_data.abilities, ability.name)
    end

    return new_data
end

function legacy.default(key)
    local tempabilities = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)
    local default = {
        -- METADATA
        ['player'] = s.plrs:GetPlayerByUserId(key), -- UserId
        ['faction'] = 'none',
        ['specialty'] = 'none',
        ['rank'] = 0, --TEMP
    
        -- STATS
        ['level_points'] = 300, -- TEMP
        ['ability_points'] = 500, -- TEMP
    
        -- ABILITIES
        ['abilities'] = { -- TEMP / CANNOT BE CLASSES, MUST BE NAME STRINGS
            'Pull', 'Push', 'Spark', 'Lightning'
        }
    }

    return default
end

function legacy.save(datastore, key, data)
    print('Saving', time())

    data = legacy.dataPack(data)

    local success, errorMessage = pcall(function()
        datastore:SetAsync(key, data)
    end)
    if not success then
        return false, errorMessage
    end
end

function legacy.get(datastore, key)
    local data = datastore:GetAsync(key)
    if data == nil or table.getn(data) == 0 then
        print("Making default")

        data = legacy.default(key)

        -- Must be saved before creating the classes
        legacy.save(datastore, key, data)

        data = legacy.dataUnpack(data)
    end

    return data
end

-- Server Data Storage
SDS = {}

-- Server Data Storage Functions
function SDS.mountPlayer(Player)
    local PlayerData = legacy.get(DS, Player.UserId)
    table.insert(SDS, Player.UserId, PlayerData)

    return SDS.getPlayer(Player)
end

function SDS.unmountPlayer(Player) -- I don't know if this is safe or not
    local function attemptSave(attempts)  -- Recursive
        local attempts = attempts or 0
        
        print(attempts)

        SDS[Player.UserId].abilities = legacy.simplifyAbilities(SDS[Player.UserId].abilities)
        print(SDS[Player.UserId])
        
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