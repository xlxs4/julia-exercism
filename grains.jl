function validate(square)
    (1 <= square < 65) || throw(DomainError("The square must be between 1 and 64"))
end

"""Calculate the number of grains on square `square`."""
function on_square(square)
    validate(square)
    return UInt64(1) << (square - 1)
end

"""Calculate the total number of grains after square `square`."""
function total_after(square)
    validate(square)
    return (UInt64(1) << square) - 1
end
