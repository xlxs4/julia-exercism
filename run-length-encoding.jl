function encode(s)
    function collapse(s)
        l = length(s)
        l == 1 ? s : string(l) * s[end]
    end

    replace(s, r"(.)\1*" => collapse)
end

function decode(s)
    function expand(s)
        l = length(s)
        l == 1 ? s : s[end]^parse(Int, s[1:end-1])
    end

    replace(s, r"(\d*)(\D)" => expand)
end
