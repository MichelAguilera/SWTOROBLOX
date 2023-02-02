local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

Preload = {}
Preload.Events = {
    -- Type,        Name
    {'RemoteEvent', 'SendData'},
    {'RemoteEvent', 'UnlockAbility'},
    {'BindableEvent', 'UpdateGui'}
}

function Preload.createEvents()
    local EventsFolder = s.rs.Common.ProgressionSystem_Shared.Events

    -- Loop through the events in the Preload.Events table
    for _, event in pairs(Preload.Events) do
        local e = Instance.new(event[1], EventsFolder)
        e.Name = event[2]
    end

    -- Return a boolean indicating success
    return true
end

function Preload.finish()
    local GlobalFolder = s.rs.Common.Globals
    local Loaded = Instance.new('BoolValue', GlobalFolder)
    Loaded.Name = 'Loaded'
    Loaded.Value = true

    return Loaded.Value
end

function Preload.run_all()
    Preload.createEvents()

    return Preload.finish()
end

return Preload