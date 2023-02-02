local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

----------------------------------------------------------------

-- EVENTS
local DataSend = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataSend')
local DataRequest = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataRequest')

-- FUNCTIONS
DataTransfer = {}

-- transfer: client --> server
function DataTransfer.signalServer(args)
    DataSend:FireServer(args)
end

-- request: client --> server --> client
function DataTransfer.requestServer(args)
    return DataRequest:InvokeServer(args)
end

return DataTransfer