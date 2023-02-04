-- DEPENDENCIES
local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local Roact = require(s.rs.Common.RojoModules.Roact)
local AbilityButtonEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild('AbilityButtonEvent')

-- ELEMENTS
local Elements = {}

function Elements.NumberDisplay(props)
    return Roact.createElement('Frame', {
        Size = UDim2.fromOffset(120, 20),
        AnchorPoint = Vector2.new(props.x_anchor, 0),
        Position = UDim2.new(props.x_position, 0, 0, 0)
    }, {
        Roact.createElement('TextLabel', {
            Size = UDim2.fromScale(0.8, 1),
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.fromScale(0, 0),
            Text = props.text
        }),
        Roact.createElement('TextLabel', {
            Size = UDim2.fromScale(0.2, 1),
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            Text = props.number
        })
    })
end

function Elements.Abilities(props)
    local ab = {}

    for i, _Ability in ipairs(props) do
        local Element = Roact.createElement(Elements.Ability, _Ability, {
            Roact.createElement(Elements.AbilityButton, _Ability)
        })
        table.insert(ab, Element)
    end

    table.insert(ab, Roact.createElement('UIGridLayout', {}))

    return ab
end

function Elements.AbilityButton(props) -- props = Ability
    return Roact.createElement("ImageButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Image = 'rbxassetid://'..tostring(props.image_id),
        [Roact.Event.MouseButton1Up] = function(rbx)
            AbilityButtonEvent:Fire(props.name, props.required_ability)
        end
    }, {
        Roact.createElement("UICorner", {})
    })
end

function Elements.Ability(props) -- props = Ability
    return Roact.createElement("Frame", {
        Size = UDim2.fromOffset(50, 50)
    }, {
        Roact.createElement("UICorner"),
        Roact.createElement(Elements.AbilityButton, props),
        Roact.createElement('StringValue', {Value = props.name})
    })
end

function Elements.AbilitiesFrame(props) -- props = Ability Array
    return Roact.createElement("Frame", {
        Size = UDim2.fromScale(0.8, 0.8),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    }, Roact.createFragment(Elements.Abilities(props)))
end

function Elements.MainFrame(props) -- props = Ability Array
    return Roact.createElement("Frame", {
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.5
    }, {
        Roact.createElement("UICorner"),
        Roact.createElement(Elements.AbilitiesFrame, props.abilities),
        Roact.createElement(Elements.NumberDisplay, {
            ['number'] = props.numbers.level_int,
            ['text'] = "Experience:",
            ['x_anchor'] = 0,
            ['x_position'] = 0
        }),
        Roact.createElement(Elements.NumberDisplay, {
            ['number'] = props.numbers.ability_int,
            ['text'] = "Ability Points:",
            ['x_anchor'] = 1,
            ['x_position'] = 1
        })
    })
end

function Elements.ScreenGui(props) -- props = Ability Array
    return Roact.createElement("ScreenGui", {}, {
        Roact.createElement(Elements.MainFrame, props)
    })
end

function Elements.Main(args)
    return Roact.createElement(Elements.ScreenGui, args)
end

return Elements