local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local AbilityClass = require(script.Parent.Ability)
local abilities = require(s.rs.Common.ProgressionSystem_Shared.abilities)

-- CLASS
local Actor = {}
Actor.__index = Actor

function Actor.new(player, args)
    local self = setmetatable({}, Actor)

    -- METADATA
    self.player = player
    self.faction = args.faction
    self.specialty = args.specialization
    self.rank = 255 --TEMP

    -- STATS
    self.level_int = args.level_points
    self.ability_int = args.ability_points

    return self
end

function Actor:add_level_point(amount)
    self.level_int += amount
end

function Actor:remove_level_point(amount)
    self.level_int -= amount
end

function Actor:give_ability_point(amount)
    self.ability_int += amount
end

function Actor:remove_ability_point(amount)
    self.ability_int -= amount
end

function Actor:unlock_ability(ability)
    local ability_name = ability['name']
    self:remove_ability_point(ability['cost'])
    self.ability_pool[ability_name]:unlock()
end

return Actor