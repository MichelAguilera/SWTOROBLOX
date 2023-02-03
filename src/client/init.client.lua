local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

-- Handle the preload (RUNS ON CLIENT STARTUP)
local Preload = require(script.Preload).run_all()

-- DEPENDENCIES
local Loaded = s.rs.Common.Globals.Loaded.Value
local ClientPlayerData = require(s.plrs.LocalPlayer.PlayerScripts.Client.ClientPlayerData)
local GuiFunctions = require(script.GuiFunctions)

-- CLIENT EVENTS
local UpdateGuiEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild('UpdateGui')
local AbilityButtonEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild('AbilityButtonEvent')
local PlayerDataChangedEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild('ChangedEvent')

-- SERVICES
local DataTransfer = require(s.rs.Common.ProgressionSystem_Shared.Functions.DataTransfer)

-- LOCAL VARIABLES
local Player = s.plrs.LocalPlayer

--- GUI
local Gui = {
    ['handle'] = nil
}

function Gui.create(Data)
    Gui.handle = GuiFunctions.init(Player.PlayerGui, Data)
    return Gui.handle
end

-- MAIN
local function Init()
    --[[
        1. Request Data from the Server √
        2. Create the GUI with Roact    √
        3. Fill the GUI with the Data   √

        4. Set the triggers for clicking on Ability
        5. Set the trigger for updating the GUI
    ]]

    -- 1. Request Data from the Server and stores it in ClientPlayerData
    wait(1)
    ClientPlayerData.mount(DataTransfer.requestServer(Player))
    ClientPlayerData.display()

    -- 2. Create the GUI, 3. Fill the GUI with the Data
    local GUI = Gui.create(ClientPlayerData.Data.abilities)

    -- 4. Set the triggers for clicking on Ability
    AbilityButtonEvent.Event:Connect(function()
        -- Send :unlock order to the server
    end)

    -- 5. Set the trigger for updating the GUI
    UpdateGuiEvent.Event:Connect(function() GUI:update() end)
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