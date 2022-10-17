function is_triangle(sides)
    x, y, z = sort(sides)
    return (x + y ≥ z) && all(i -> i > 0, sides) && length(Set(sides))
end

is_equilateral(sides) = is_triangle(sides) == 1
is_isosceles(sides) = is_triangle(sides) ∈ (1, 2)
is_scalene(sides) = is_triangle(sides) == 3
