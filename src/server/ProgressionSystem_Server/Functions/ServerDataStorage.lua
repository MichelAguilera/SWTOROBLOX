local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local DS_KEY = require(s.sss.Server.ProgressionSystem_Dependencies.dskey)
local DS_service = s.dss
local DS = DS_service:GetDataStore(DS_KEY)

-- DataStore LEGACY functions
legacy = {}

function legacy.default(key)
    local tempabilities = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)
    local default = {
        -- METADATA
        ['player'] = s.plrs:GetPlayerByUserId(key),
        ['faction'] = 'none',
        ['specialty'] = 'none',
        ['rank'] = 0, --TEMP
    
        -- STATS
        ['level_points'] = 300, -- TEMP
        ['ability_points'] = 500, -- TEMP
    
        -- ABILITIES
        ['abilities'] = { -- TEMP
            tempabilities.Pull,
            tempabilities.Push,
            tempabilities.Spark,
            tempabilities.Lightning
        }
    }

    return default
end

function legacy.save(datastore, key, data)
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
        data = legacy.default(key)
        legacy.save(datastore, key, data)
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

        local success, errorMessage = legacy.save(DS, Player.UserId, SDS[Player.UserId])

        if attempts > 5 then return end

        if not success then
            warn(errorMessage)
            attemptSave(attempts + 1)
        end
    end

    SDS[Player.UserId] = nil
end

function SDS.updateFromServer(Player, Data)
    SDS[Player.UserId] = Data
end

function SDS.getPlayer(Player)
    return SDS[Player.UserId]
end

return SDS