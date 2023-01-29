-- DEPENDENCIES
local Unlockable = require(script.Parent.Unlockable)
local unlockables_table = require(script.Parent.unlockables_table)

-- CLASS
local Actor = {}
Actor.__index = Actor

function Actor.new(player, faction, specialization, level_points, ability_points, ability_pool)
    local self = setmetatable({}, Actor)
    self.player = player
    self.faction = faction
    self.specialty = specialization
    self.level_int = level_points
    self.ability_point = ability_points
    self.ability_pool = Actor.set_ability_pool(unlockables_table, ability_pool, self)
    return self
end

function Actor.set_ability_pool(_unlockables_table, _actor_abilities, _actor)

    local abilities_list = {}

    for i, ability in pairs(_unlockables_table) do
        if ability['is_common'] == true or ability['specialization'] == _actor['specialty'] then
            local _abilityObject = Unlockable.new(  _actor_abilities[ability["name"]], 
                                                    ability["is_common"], 
                                                    ability["faction"], 
                                                    ability["specialization"], 
                                                    ability["by_rank"], 
                                                    ability["by_grind"], 
                                                    ability["cost"])
            abilities_list[i] = _abilityObject
        end
    end

    return abilities_list
end

function Actor:add_level_point(amount)
    self.level_int += amount
end

function Actor:remove_level_point(amount)
    self.level_int -= amount
end

function Actor:give_ability_point(amount)
    self.ability_point += amount
end

function Actor:remove_ability_point(amount)
    self.ability_point -= amount
end

function Actor:unlock_ability(ability)
    local ability_id = ability[1]
    self:remove_ability_point(ability['cost'])
    self.ability_pool[ability_id]:unlock()
end

return Actor