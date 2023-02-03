local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)
local ChangedEvent = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents:WaitForChild("ChangedEvent")

--
ClientPlayerData = {
    Data = {}
}

function ClientPlayerData.mount(Data)
    ClientPlayerData.Data = Data
    ChangedEvent:Fire()
end

function ClientPlayerData.display()
    print(ClientPlayerData.Data)
end

return ClientPlayerData