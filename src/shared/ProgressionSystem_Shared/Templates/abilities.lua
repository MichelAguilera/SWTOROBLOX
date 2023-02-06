abilities = {}

abilities.Push = {
    ['name'] = 'Push',
    ['img_id'] = 0,
    ['isLocked'] = true,
    ['isCommon'] = false,
    ['faction'] = 'sith',
    ['specialization'] = 'force',
    ['alignment'] = nil,
    ['byRank'] = true,
    ['byGrind'] = false,
    ['minRank'] = 30,
    ['minGrind'] = 0,
    ['cost'] = 5,
    ['required_unlockable'] = {}
}

abilities.Pull = {
    ['name'] = 'Pull',
    ['img_id'] = 0,
    ['isLocked'] = true,
    ['isCommon'] = false,
    ['faction'] = 'sith',
    ['specialization'] = 'force',
    ['alignment'] = nil,
    ['byRank'] = true,
    ['byGrind'] = false,
    ['minRank'] = 30,
    ['minGrind'] = 0,
    ['cost'] = 5,
    ['required_unlockable'] = {'Push'}
}

abilities.Spark = {
    ['name'] = 'Spark',
    ['img_id'] = 0,
    ['isLocked'] = true,
    ['isCommon'] = false,
    ['faction'] = 'sith',
    ['specialization'] = 'force',
    ['alignment'] = 'dark',
    ['byRank'] = true,
    ['byGrind'] = false,
    ['minRank'] = 40,
    ['minGrind'] = 250,
    ['cost'] = 5,
    ['required_unlockable'] = {}
}

abilities.Lightning = {
    ['name'] = 'Lightning',
    ['img_id'] = 0,
    ['isLocked'] = true,
    ['isCommon'] = false,
    ['faction'] = 'sith',
    ['specialization'] = 'force',
    ['alignment'] = 'dark',
    ['byRank'] = true,
    ['byGrind'] = false,
    ['minRank'] = 50,
    ['minGrind'] = 400,
    ['cost'] = 5,
    ['required_unlockable'] = {'Spark'}
}

return abilities