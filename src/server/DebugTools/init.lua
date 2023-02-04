--[[
    1. Create the necessary events
    2. Grab the chat service
    3. Define the commands
    4. Listen to the commands
]]
local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local parser = require(script.StringParser)

DebugTools = {}

local commands = {
    ['prefix'] = '/',
    ['commands'] = {
        ['/fsave'] = function(args)
            print('fsave called with', args)
            local sds = require(s.sss.Server.ProgressionSystem_Server.Functions.ServerDataStorage)
            sds.unmountPlayer(args.Player)
        end -- Forces save
    }
}

function DebugTools.init()
    print("DebugTools.init")

    local events_folder = Instance.new('Folder', script.Parent)
    events_folder.Name = 'events'

    local command_signal = Instance.new('RemoteEvent', events_folder)
    command_signal.Name = 'command_signal'
end

function DebugTools.onChat(String)
    print("DebugTools.onChat", String)
    -- print(String, string.split(String, '')[1])
    -- if string.split(String, '')[1] == commands.prefix then
    --     commands.commands[String]({['Player'] = s.plrs:WaitForChild("MitxelReinhardt")})
    -- end
    parser.run(String)
end

return DebugTools