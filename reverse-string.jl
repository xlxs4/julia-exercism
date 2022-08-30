using Unicode:graphemes
function myreverse(s)
    return join(reverse(collect(graphemes(s))))
end
