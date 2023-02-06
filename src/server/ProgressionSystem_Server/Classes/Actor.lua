local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local AbilityClass = require(script.Parent.Ability)
local abilities = require(s.rs.Common.ProgressionSystem_Shared.Templates.abilities)

-- CLASS
local Actor = {}
Actor.__index = Actor

function Actor.new(player, args)
    local self = setmetatable({}, Actor)

    print("Actor created by:", player, args)
    -- METADATA
    self.player = player
    self.faction = args.faction or 'neutral'
    self.specialty = args.specialty or 'none'
    self.rank = 255 --TEMP

    -- STATS
    self.level_int = args.level_int or 0
    self.ability_int = args.ability_int or 0

    -- ABILITIES
    self.abilities = Actor.createAbilityClasses(args.abilities)

    return self
end

-- THE THING IS HERE!!! DAMN THIS THING
function Actor.createAbilityClasses(array)
    -- print("creating AbilityClasses")
    local new_array = {}
    for i, ability_data in ipairs(array) do
        local abilityClass = AbilityClass.new(ability_data)
        table.insert(new_array, abilityClass)
    end
    return new_array
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

function Actor:unlock_ability(ability_name, ability_requirement, ability)
    local function GetIndexOfValue(tabl, value)
        -- print(tabl, value)
        for index, Ability in ipairs(tabl) do
            if Ability.name == value then
                return index
            end
        end
    end

    local abilities_available = self.abilities
    local _Ability = abilities_available[GetIndexOfValue(abilities_available, ability_name)]

    -- NOTE: The unlock will have to run through Actor class instead of here; to check the ability points available.
    local success, message = ability:unlock(ability_requirement, abilities_available, self)
    if success then
        print(message)
        self:remove_ability_point(ability.cost)
        return true
    end
    return false, message
end

function Actor:repr()
    print(self.player.Name, self.faction, self.specialty, self.rank)
end

return Actor