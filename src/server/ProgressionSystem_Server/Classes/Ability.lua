-- CLASS
local Ability = {}
Ability.__index = Ability

function Ability.new(args)
    local self = setmetatable({}, Ability)

    self.name = args.name
    self.image_id = args.img_id
    self.isLocked = args.isLocked
    self.isCommon = args.isCommon
    self.faction = args.faction
    self.specialization = args.specialization
    self.byRank = args.byRank
    self.byGrind = args.byGrind
    self.minRank = args.minRank
    self.minGrind = args.minGrind
    self.cost = args.cost
    self.required_ability = args.required_unlockable
    
    return self
end

function Ability:ping()
    return self.name    
end

function Ability.performChecks(_ability_requirement, abilities_available, actor, ability)

    -- print(_ability_requirement, abilities_available, actor, ability)
    -- 2. Check if the ability meets requirements, if false: exit

    -- Check ability_point balance
    local ability_point_balance = actor.ability_int
    -- print("Cost:", ability.cost, "Balance:", ability_point_balance)
    if ability.cost > ability_point_balance then
        print("Not enough ability points")
        return false
    end

    -- Converts abilities_available:Array[Dict] into Array[String] (Array[Item.name])
    local unlocked_abilities = {}
    for i, ability in pairs(abilities_available) do
        if ability.isLocked == false then
            table.insert(unlocked_abilities, ability.name)
        end
    end
    
    local bool_board = {}

    -- Compare strings from ability_requirement:Array[String] and abilities_available:Array[String]
    for _, req_to_unlock in pairs(_ability_requirement) do   -- Loop through the ability_requirement
        for _, unlock in pairs(unlocked_abilities) do       -- Loop through the unlocked_abilities
            -- print(req_to_unlock, unlock)
            if req_to_unlock == unlock then                 -- IF:
                table.insert(bool_board, true)              -- String == String
            else
                table.insert(bool_board, false)             -- String ~= String
                break
            end
        end
    end

    if table.getn(_ability_requirement) == 0 then -- Means no checks are necessary
        -- print("Boolboard == {}")
        return true
    end

    for i, result in pairs(bool_board) do -- Check for at least one true value
        if result == true then
            return true
        else
            continue
        end
    end
    print("Not possible to upgrade, missing required unlockable.")
    return false
end

function Ability:unlock(ability_requirement, abilities_available, actor) -- Array[index = String], Array[index = Dict[Ability]]
    
    -- print("Attempting to unlock ability")
    -- 1. Check if the ability isLocked, if false: exit
    -- 2. Check if the ability meets requirements, if false: exit
    -- 3. Unlock the ability
    
    -- 1. Check if the ability isLocked, if false: exit
    if self.isLocked == false then -- isLocked needs to be true in order to continue
        -- print(self.name, self.isLocked)
        print(self.name, "is already unlocked")
        return false
    else
        -- print("Check #1 passed: self.isLocked == true")
    end

    -- 3. Unlock the ability
    if Ability.performChecks(ability_requirement, abilities_available, actor, self) then
        print("Unlocking "..self.name)
        self.isLocked = false
        return true
    else
        return false
    end
end

return Ability