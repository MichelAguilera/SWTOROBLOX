ActorStorage = {}
-- Used to store Actor classes on the Server

function ActorStorage.mountActor(Actor)
    ActorStorage[Actor.name] = Actor

    return ActorStorage[Actor.name]
end

function ActorStorage.unmountActor(Actor)
    ActorStorage[Actor.name] = nil
end

return ActorStorage