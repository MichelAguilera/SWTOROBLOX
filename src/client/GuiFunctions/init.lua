-- DEPENDENCIES
local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local Unlock_RemoteEvent = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('UnlockAbility')

-- FUNCTIONS
local GuiFunctions = {}

function GuiFunctions.update(Gui, Data)
    local ProgressionGui = Gui.ProgressionGui

    local Label_Ability_Points = ProgressionGui.Main.Ability_Points
    local Label_Level_Points = ProgressionGui.Main.Level_Points

    Label_Ability_Points.Text = Data["ability_point"]
    Label_Level_Points.Text = Data["level_int"]
end

function GuiFunctions.show_tooltip(Gui, AbilityData)
    local UtilityGui = Gui.UtilityGui
    local Tooltip = Gui.Ability_ToolTip:Clone()

    Tooltip.Name = "Tooltip"
    Tooltip.NAME.Text = AbilityData.NAME.Value
    Tooltip.COST.Text = AbilityData.COST.Value
    Tooltip.Parent = UtilityGui
end

function GuiFunctions.destroy_tooltip(Tooltip)
    Tooltip:Destroy()
end

function GuiFunctions.CreateAbilityFrames(Gui, Data)
    local AbilitiesFrame = Gui:WaitForChild("ProgressionGui").Main.Abilities_Frame
    local AbilityFrames = {}

    for _, _ability in pairs(Data) do
        local Ability_Frame = Gui.Ability_Template:Clone()

        Ability_Frame.Name = "Ability_".._ability['name']
        Ability_Frame.ImageButton.Image = "rbxassetid://"..tostring(v['image_id'])

        Ability_Frame.NAME.Value = _ability['name']
        Ability_Frame.COST.Value = _ability['cost']
        Ability_Frame.MIN_RANK.Value = _ability['min_rank']
        Ability_Frame.MIN_GRIND.Value = _ability['min_grind']

        Ability_Frame.Visible = true
        Ability_Frame.Parent = AbilitiesFrame

        table.insert(AbilityFrames, Ability_Frame)
    end

    return AbilityFrames
end

function GuiFunctions.AbilityFrameButtonHit(Ability)
    print("Pressed", Ability, type(Ability))

    Unlock_RemoteEvent:FireServer(Ability)
    -- :unlock()
end

return GuiFunctions