function rotate(n, c::AbstractChar)
    a = isuppercase(c) ? 'A' : 'a'
    return isletter(c) ? ((c - a + n) % 26) + a : c
end
function rotate(n, s::AbstractString)
    return map(x -> rotate(n, x), s)
end
for shift in 1:26
    @eval macro $(Symbol(:R, shift, :_str))(s)
        rotate($shift, s)
    end
end
