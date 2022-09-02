# julia-exercism

This is the collection of my [solutions](https://exercism.org/profiles/xlxs4/solutions?track_slug=julia) for the [Julia track](https://exercism.org/tracks/julia) exercises over at [Exercism](https://exercism.org/).

## Description

Exercism is a cool website where you can work through completing exercises that all fall under what's called a "track"; a collection that usually corresponds to a programming language. What's cool is you can have more experienced people mentor you, give you feedback based on your solutions. I've had a lot of discussions that had nothing to do with the exercise I was solving, it's a great way to learn about things. You can also share your solutions with the rest of the community, as well as browse publicly available solutions contributed by other users. There's also a [CLI app](https://exercism.org/docs/using/solving-exercises/working-locally) ([GitHub](https://github.com/exercism/cli)) that allows you to work locally.

## Table of Contents

<details>
<summary>Click to expand</summary>

- [julia-exercism](#julia-exercism)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [Exercises](#exercises)
    - [Collatz Conjecture](#collatz-conjecture)
    - [Difference of Squares](#difference-of-squares)
    - [Grains](#grains)
    - [Hamming](#hamming)
    - [Hello World](#hello-world)
    - [Leap](#leap)
    - [Nucleotide Count](#nucleotide-count)
    - [Pangram](#pangram)
    - [Reverse String](#reverse-string)
    - [RNA Transcription](#rna-transcription)
    - [Robot Name](#robot-name)
    - [Rotational Cipher](#rotational-cipher)
    - [Secret Handshake](#secret-handshake)

</details>

## Exercises

### Collatz Conjecture

```julia
function collatz_steps(n)
    n > 0 || throw(DomainError("n must be ≥ 1"))
    steps = 0
    while n != 1
        n & 1 == 0 ? n = n ÷ 2 : n = 3n + 1
        steps += 1
    end
    return steps
end
```

### Difference of Squares

```julia
"Square the sum of the first `n` positive integers"
function square_of_sum(n)
    return ((n * (n + 1)) ÷ 2)^2
end
"Sum the squares of the first `n` positive integers"
function sum_of_squares(n)
    return (n * (n + 1) * (2 * n + 1)) ÷ 6
end
"Subtract the sum of squares from square of the sum of the first `n` positive ints"
function difference(n)
    return square_of_sum(n) - sum_of_squares(n)
end
```

### Grains

```julia
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
```

### Hamming

```julia
function distance(a, b)
    length(a) != length(b) && throw(ArgumentError("The sequences must be of equal length!"))
    return sum(map(!=, a, b))
end
```

### Hello World

```julia
function hello()
    return "Hello, World!"
end
```

### Leap

```julia
"""
    is_leap_year(year)
 
Return `true` if `year` is a leap year in the gregorian calendar.
 
"""
function is_leap_year(year)
    year % 4 == 0 || return false
    year % 100 == 0 || return true
    return year % 400 == 0
end
```

### Nucleotide Count

```julia
"""
    count_nucleotides(strand)
 
The count of each nucleotide within `strand` as a dictionary.
 
Invalid strands raise a `DomainError`.
 
"""
function count_nucleotides(strand)
    utf8 = transcode(UInt8, strand)
    counts = zeros(Int, 256)
    @inbounds for byte in utf8
        counts[byte+1] += 1
    end
    result = Dict(base => counts[Int(base)+1] for base in "ACGT")
    if sum(values(result)) != length(utf8)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    return result
end

```

### Pangram

```julia
"""
    ispangram(input)
 
Return `true` if `input` contains every alphabetic character (case insensitive).
 
"""
function ispangram(input)
    return 'a':'z' ⊆ lowercase(input)
end

```

### Reverse String

```julia
using Unicode:graphemes
function myreverse(s)
    return join(reverse(collect(graphemes(s))))
end
```

### RNA Transcription

```julia
const complements = Dict('A' => 'U', 'C' => 'G', 'G' => 'C', 'T' => 'A')
function to_rna(x::AbstractChar, complements)
    bases = keys(complements)
    x ∈ bases || throw(ErrorException("Nucleotide can be one of 'A', 'C', 'G', 'T'!"))
    return complements[x]
end
to_rna(dna, complements) = map(x -> to_rna(x, complements), dna)
to_rna(dna) = to_rna(dna, complements)
```

### Robot Name

```julia
const used_names = Set{UInt32}(26001:(26^2)*10^3)
mutable struct Robot
    name::UInt32
    Robot() = new(pickname!())
end
function pickname!()
    return pop!(used_names)
end
reset!(instance::Robot) = instance.name = pickname!()
function name(instance::Robot)
    name = instance.name
    numbers = reverse(digits(name, base=10)[1:3])
    letters = ['A' + i for i ∈ reverse(digits(name ÷ 1000, base=26))]
    return join([letters; numbers])
end
```

### Rotational Cipher

```julia
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
```

### Secret Handshake

```julia
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
```
