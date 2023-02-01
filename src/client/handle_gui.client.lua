local unlockables_table = require(game:GetService("ReplicatedStorage").Common.ProgressionSystem_Shared.unlockables_table)
local SendData_RemoteEvent = game:GetService("ReplicatedStorage").ProgressionSystem_Events.SendData
local LocalData = require(script.Parent.player_data)
local GuiFunctions = require(script.Parent.GuiFunctions)

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player.PlayerGui

local function init(data)
    LocalData[1] = data

    local AbilityFrames = GuiFunctions.CreateAbilityFrames(PlayerGui, data['ability_pool'])

    for i, v in pairs(AbilityFrames) do
        v.ImageButton.MouseButton1Up:Connect(function()
            GuiFunctions.AbilityFrameButtonHit(v.NAME.Value)
        end)
    end

    while true do
        GuiFunctions.update(PlayerGui, data)
        wait(0.5)
    end
end

SendData_RemoteEvent.OnClientEvent:Connect(function(data) 
    init(data)
end)