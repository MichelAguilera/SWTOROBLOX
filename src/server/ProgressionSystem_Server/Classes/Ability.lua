-- CLASS
local Ability = {}
Ability.__index = Ability

function Ability.new(args)
    local self = setmetatable({}, Ability)

    self.name = args.name
    self.image_id = args.image_id
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