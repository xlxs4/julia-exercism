function collatz_steps(n)
    n > 0 || throw(DomainError("n must be ≥ 1"))
    steps = 0
    while n != 1
        n & 1 == 0 ? n = n ÷ 2 : n = 3n + 1
        steps += 1
    end
    return steps
end
