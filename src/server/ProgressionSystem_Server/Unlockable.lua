-- CLASS
local Unlockable = {}
Unlockable.__index = Unlockable

function Unlockable.new(isLocked, isCommon, faction, specialization, byRank, byGrind, cost)
    local self = setmetatable({}, Unlockable)
    self.isLocked = isLocked
    self.isCommon = isCommon
    self.faction = faction
    self.specialization = specialization
    self.byRank = byRank
    self.byGrind = byGrind
    self.cost = cost
    return self
end

function Unlockable:unlock()
    self.isLocked = false
end

return Unlockable