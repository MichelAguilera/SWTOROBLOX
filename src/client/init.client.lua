local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- DEPENDENCIES
local Loaded = s.rs.Common.Globals.Loaded.Value
local UpdateGuiEvent = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('UpdateGui')
local ClientPlayerData = require(s.plrs.LocalPlayer.PlayerScripts.Client.ClientPlayerData)
local GuiFunctions = require(script.GuiFunctions)

-- SERVICES
local DataTransfer = require(s.rs.Common.ProgressionSystem_Shared.Functions.DataTransfer)

-- LOCAL VARIABLES
local Player = s.plrs.LocalPlayer

-- FUNCTIONS
local function Init()
    --[[
        1. Request Data from the Server √
        2. Create the GUI 
        3. Fill the GUI with the Data

        4. Set the triggers for clicking on Ability
        5. Set the trigger for updating the GUI
    ]]

    -- 1. Request Data from the Server and stores it in ClientPlayerData
    ClientPlayerData = DataTransfer.requestServer(Player)

    -- 2. Create the GUI
    -- a)
    local AbilityFrames = GuiFunctions.CreateAbilityFrames(Player.PlayerGui, ClientPlayerData['ability_pool'])

    -- b)
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