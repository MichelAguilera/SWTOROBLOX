local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local Loaded = s.rs.Common.Globals.Loaded.Value
local UpdateGuiEvent = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('UpdateGui')
local ClientPlayerData = require(s.plrs.LocalPlayer.PlayerScripts.Client.ClientPlayerData)
local GuiFunctions = require(script.GuiFunctions)

-- LOCAL VARIABLES
local Player = s.plrs.LocalPlayer

-- FUNCTIONS
local function Init()
    --[[
        x. Request Data from the Server
            z. DataTransfer.signalServer(-- Tell server to send the Actor data to the client)
            z. DataTransfer.recieveData(-- Recieve data here): add the return value of this function to ClientPlayerData
            NOTE:   To be honest I don't know if the logic for the steps above will work as intended.
                    I might need to change the way I communicate between the Client and the Server


        x. Create the GUI
        x. Fill the GUI with the Data

        x. Set the triggers for clicking on Ability
        x. Set the trigger for updating the GUI
    ]]

    local AbilityFrames = GuiFunctions.CreateAbilityFrames(Player.PlayerGui, data['ability_pool'])

    for i, v in pairs(AbilityFrames) do
        v.ImageButton.MouseButton1Up:Connect(function()
            GuiFunctions.AbilityFrameButtonHit(v.NAME.Value)
        end)
    end

    GuiFunctions.update(PlayerGui, data)
end


if Loaded then
    Init()
end

--[[

local unlockables_table = require(s.rs.Common.ProgressionSystem_Shared.unlockables_table)
local SendData_RemoteEvent = s.rs.ProgressionSystem_Events.SendData
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

]]