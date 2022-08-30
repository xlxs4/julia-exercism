"""
    ispangram(input)
 
Return `true` if `input` contains every alphabetic character (case insensitive).
 
"""
function ispangram(input)
    return 'a':'z' ⊆ lowercase(input)
end
