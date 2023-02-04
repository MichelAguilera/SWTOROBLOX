StringParser = {}

function StringParser.SeparateArgs(args)
    return string.split(args, " ")
end

function StringParser.SeparatePrefix(main_arg)
    return string.split(main_arg, "")
end

function StringParser.run(args)
    local command = {}
    
    for _, v in ipairs(StringParser.SeparateArgs(args)) do
        table.insert(command, v)
    end

    -- print(command)
    return command
end

return StringParser