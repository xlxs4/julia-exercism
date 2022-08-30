function distance(a, b)
    length(a) != length(b) && throw(ArgumentError("The sequences must be of equal length!"))
    return sum(map(!=, a, b))
end
