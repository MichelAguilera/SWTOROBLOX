-- DEPENDENCIES
local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local Roact = require(s.rs.Common.RojoModules.Roact)

-- ELEMENTS
local function AbilityButton(props)
    return Roact.createElement("ImageButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ImageId = props.ImageId
    }, {
        Roact.createElement("UICorner", {})
    })
end

local function AbilityButton(props) -- props = Ability
    return Roact.createElement("Frame", {
        Name = props.Name,
        Size = UDim2.fromOffset(50, 50)
    }, {
        Roact.createElement("UICorner", {}),
        AbilityButton(props.ImageId)
    })
end

local AbilitiesFrame = Roact.createElement("Frame", {
    Name = "AbilitiesFrame",
    Size = UDim2.fromScale(0.8, 0.8),
    AnchorPoint = UDim2.fromScale(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
})

local MainFrame = Roact.createElement("Frame", {
    Name = "MainFrame",
    Size = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = UDim2.fromScale(0.5, 0.5),
    BackgroundTransparency = 0.5
}, {
    Roact.createElement("UICorner", {}),
    AbilitiesFrame
})

local MountedGUI = Roact.mount(MainFrame, Player)