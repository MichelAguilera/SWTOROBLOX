StringParser = {}

function StringParser.SeparateArgs(args)
    return string.split(args, " ")
end

function StringParser.SeparatePrefix(main_arg)
    return string.split(main_arg, "")
end

function StringParser.run(args)
    local sep_args = StringParser.SeparateArgs(args)
    local sep_prefix = StringParser.SeparatePrefix(sep_args[1])
    table.remove(sep_prefix, 1)
    table.remove(sep_args, 1)
    table.concat(sep_prefix, '') -- TEST THIS

    local command = {}
    table.insert(command, sep_prefix)
    
    for _, v in ipairs(sep_args) do

        table.insert(command, v)
    end

    print(command)
    return command
end

return StringParser