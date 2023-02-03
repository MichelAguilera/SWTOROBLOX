-- DEPENDENCIES
local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local Roact = require(s.rs.Common.RojoModules.Roact)
local AbilityButtonEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild('AbilityButtonEvent')

-- ELEMENTS
local Elements = {}
function Elements.Abilities(props)
    local _string = {}
    local abilities = props[1][1][1]
    
    print(props, abilities)
    table.insert(_string, 'Roact.createElement("UICorner");')
    for i, _Ability in pairs(abilities) do
        -- print(_Ability)
        table.insert(_string, string.format('Roact.createElement(Ability, {Name = [%s]});', _Ability.name))
    end
    table.concat(_string)

    return _string
end

function Elements.AbilityButton(props) -- props = Ability
    return Roact.createElement("ImageButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ImageId = props.ImageId,

        [Roact.Event.MouseButton1Up] = function(rbx)
            AbilityButtonEvent:Fire(props.name)
        end
    }, {
        Roact.createElement("UICorner", {})
    })
end

function Elements.Ability(props) -- props = Ability
    return Roact.createElement("Frame", {
        Name = props.Name, -- Name doesn't seem to set, I'll need another way of identifying the frames
        Size = UDim2.fromOffset(50, 50)
    }, {
        Roact.createElement("UICorner"),
        Roact.createElement(Elements.AbilityButton, {})
    })
end

function Elements.AbilitiesFrame(props) -- props = Ability Array
    return Roact.createElement("Frame", {
        Size = UDim2.fromScale(0.8, 0.8),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    }, loadstring(Elements.Abilities(props)))
end

function Elements.MainFrame(props) -- props = Ability Array
    return Roact.createElement("Frame", {
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.5
    }, {
        Roact.createElement("UICorner"),
        Roact.createElement(Elements.AbilitiesFrame, {props})
    })
end

function Elements.ScreenGui(props) -- props = Ability Array
    print(props)
    return Roact.createElement("ScreenGui", {}, {
        Roact.createElement(Elements.MainFrame, {props})
    })
end

function Elements.Main(args)
    print(args)
    return Roact.createElement(Elements.ScreenGui, {args})
end

return Elements