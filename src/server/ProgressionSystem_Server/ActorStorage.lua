ActorStorage = {}
-- Used to store Actor classes on the Server

function ActorStorage.mountActor(Actor)
    table.insert(ActorStorage, Actor.Player.UserId, Actor)

    return ActorStorage[Actor.Player.UserId]
end

function ActorStorage.unmountActor(Actor)
    ActorStorage[Actor.Player.UserId] = nil
end

function ActorStorage.viewAllActors()
    print(ActorStorage)
end

function ActorStorage.viewActor(Player)
    print(ActorStorage[Player.UserId])
end

return ActorStorage