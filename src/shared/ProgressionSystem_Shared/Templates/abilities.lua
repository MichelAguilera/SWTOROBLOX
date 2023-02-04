abilities = {

    -- [ID] = {IMG_ID, NAME, IS_COMMON, FACTION, SPECIALIZATION, BY_RANK, BY_GRIND, MIN_RANK, MIN_GRIND, COST}
    -- [1] = {
    --     ["img_id"]          = 3845386987,
    --     ["name"]            = "test",
    --     ["is_common"]       = false,
    --     ["faction"]         = "sith",
    --     ["specialization"]  = "test_spec",
    --     ["by_rank"]         = true,
    --     ["by_grind"]        = true,
    --     ["min_rank"]        = 1,
    --     ["min_grind"]       = 0,
    --     ["cost"]            = 1,
    --     ["required_unlockable"] = {"test_ab1"}
    -- },

    -- [2] = {
    --     ["img_id"]          = 3845386987,
    --     ["name"]            = "test_ab1",
    --     ["is_common"]       = false,
    --     ["faction"]         = "sith",
    --     ["specialization"]  = "test_spec",
    --     ["by_rank"]         = true,
    --     ["by_grind"]        = true,
    --     ["min_rank"]        = 1,
    --     ["min_grind"]       = 0,
    --     ["cost"]            = 1,
    --     ["required_unlockable"] = {}
    -- },

    -- [3] = {
    --     ["img_id"]          = 3845386987,
    --     ["name"]            = "test_ab2",
    --     ["is_common"]       = false,
    --     ["faction"]         = "sith",
    --     ["specialization"]  = "test_spec",
    --     ["by_rank"]         = true,
    --     ["by_grind"]        = true,
    --     ["min_rank"]        = 1,
    --     ["min_grind"]       = 0,
    --     ["cost"]            = 1,
    --     ["required_unlockable"] = {}
    -- },

}

abilities.Push = {
    ['name'] = 'Push',
    ['img_id'] = 0,
    ['isLocked'] = false,
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
    ['isLocked'] = false,
    ['isCommon'] = false,
    ['faction'] = 'sith',
    ['specialization'] = 'force',
    ['alignment'] = nil,
    ['byRank'] = true,
    ['byGrind'] = false,
    ['minRank'] = 30,
    ['minGrind'] = 0,
    ['cost'] = 5,
    ['required_unlockable'] = {'Force Push'}
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