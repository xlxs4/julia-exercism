function secret_handshake(code)
    commands = ("wink", "double blink", "close your eyes", "jump")
    pow = 1
    decode = String[]
    for command in commands
        code & pow == pow && push!(decode, command)
        pow <<= 1
    end
    return code & pow == pow ? reverse!(decode) : decode
end
