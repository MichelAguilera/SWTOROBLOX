local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

----------------------------------------------------------------

-- EVENTS
local DataTransfer = s.rs.Common.ProgressionSystem_Shared.Events:WaitForChild('DataTransfer')

-- FUNCTIONS
DataTransfer = {}

-- request
function DataTransfer.signalServer()

    DataTransfer:FireServer()
end

function DataTransfer.signalClient()

    DataTransfer:FireClient()
end

-- recieve
function DataTransfer.recieveData(data)
    return data
end

-- recieve
DataTransfer.OnServerEvent:Connect(function(data)
    DataTransfer.recieveData({['data']=data})
end)

DataTransfer.OnClientEvent:Connect(function(player, data)
    DataTransfer.recieveData({['player']=player, ['data']=data})
end)

return DataTransfer