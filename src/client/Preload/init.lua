local s = require(game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Globals").service)

Preload = {}
Preload.Events = {
    -- Type,        Name
    {'BindableEvent', 'ChangedEvent'},
    {'BindableEvent', 'UpdateGui'},
    {'BindableEvent', 'AbilityButtonEvent'}
}

function Preload.createEvents()
    local EventsFolder = s.plrs.LocalPlayer.PlayerScripts.Client.ClientEvents

    -- Loop through the events in the Preload.Events table
    for _, event in pairs(Preload.Events) do
        local e = Instance.new(event[1], EventsFolder)
        e.Name = event[2]
    end

    -- Return a boolean indicating success
    return true
end

function Preload.finish()
    local LocalFolder = script.Parent.Locals
    local Loaded = Instance.new('BoolValue', LocalFolder)
    Loaded.Name, Loaded.Value = 'Loaded', true

    return Loaded.Value
end

function Preload.run_all()
    Preload.createEvents()

    return Preload.finish()
end

return Preload