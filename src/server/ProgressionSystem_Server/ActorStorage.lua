ActorStorage = {}
-- Used to store Actor classes on the Server

function ActorStorage.mountActor(Actor)
    table.insert(ActorStorage, Actor.player.UserId, Actor)

    return ActorStorage[Actor.player.UserId]
end

function ActorStorage.unmountActor(Actor)
    ActorStorage[Actor.player.UserId] = nil
end

function ActorStorage.getActor(Actor)
    return ActorStorage[Actor.player.UserId]
end

function ActorStorage.viewAllActors()
    print(ActorStorage)
end

function ActorStorage.viewActor(Player)
    print(ActorStorage[Player.UserId])
end

return ActorStorage