-- CLASS
local Ability = {}
Ability.__index = Ability

function Ability.new(name, image_id, isLocked, isCommon, faction, specialization, byRank, byGrind, minRank, minGrind, cost, required_unlockable)
    local self = setmetatable({}, Ability)
    self.name = name
    self.image_id = image_id
    self.isLocked = isLocked
    self.isCommon = isCommon
    self.faction = faction
    self.specialization = specialization
    self.byRank = byRank
    self.byGrind = byGrind
    self.minRank = minRank
    self.minGrind = minGrind
    self.cost = cost
    self.required_ability = required_unlockable
    return self
end

function Ability:unlock(player_unlocks)
    local bool_board = {}
    for _, req_unlock in pairs(self.required_ability) do
        for _, unlock in pairs(player_unlocks) do
            if req_unlock ~= unlock then
                continue
            else
                table.insert(bool_board, true)
            end
            table.insert(bool_board, false)
        end
    end

    for i, v in pairs(bool_board) do
        if v == false then
            print("Not possible to upgrade, missing required unlockable.")
        else
            print("Unlocking")
            self.isLocked = false
        end
    end
end

return Ability