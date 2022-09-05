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
        - [Instructions](#instructions)
        - [Examples](#examples)
    - [Difference of Squares](#difference-of-squares)
        - [Instructions](#instructions-1)
    - [Grains](#grains)
        - [Instructions](#instructions-2)
        - [For bonus points](#for-bonus-points)
    - [Hamming](#hamming)
        - [Instructions](#instructions-3)
        - [Implementation notes](#implementation-notes)
    - [Hello World](#hello-world)
        - [Instructions](#instructions-4)
    - [Leap](#leap)
        - [Instructions](#instructions-5)
        - [Notes](#notes)
    - [Nucleotide Count](#nucleotide-count)
        - [Instructions](#instructions-6)
    - [Pangram](#pangram)
        - [Instructions](#instructions-7)
    - [Reverse String](#reverse-string)
        - [Instructions](#instructions-8)
        - [Bonus](#bonus)
    - [RNA Transcription](#rna-transcription)
        - [Instructions](#instructions-9)
    - [Robot Name](#robot-name)
        - [Instructions](#instructions-10)
        - [Bonus](#bonus-1)
        - [Hints](#hints)
    - [Rotational Cipher](#rotational-cipher)
        - [Instructions](#instructions-11)
        - [Examples](#examples-1)
        - [Bonus](#bonus-2)
        - [Bonus A](#bonus-a)
        - [Bonus B](#bonus-b)
    - [Secret Handshake](#secret-handshake)
        - [Instructions](#instructions-12)

</details>

## Exercises

### Collatz Conjecture

##### Instructions

The Collatz Conjecture or 3x+1 problem can be summarized as follows:

Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is
odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely.
The conjecture states that no matter which number you start with, you will
always reach 1 eventually.

Given a number n, return the number of steps required to reach 1.

##### Examples

Starting with n = 12, the steps would be as follows:

0. 12
1. 6
2. 3
3. 10
4. 5
5. 16
6. 8
7. 4
8. 2
9. 1

Resulting in 9 steps. So for input n = 12, the return value would be 9.

<details>
<summary>Click for solution</summary>

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

</details>

### Difference of Squares

##### Instructions

Find the difference between the square of the sum and the sum of the squares of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.

You are not expected to discover an efficient solution to this yourself from
first principles; research is allowed, indeed, encouraged. Finding the best
algorithm for the problem is a key skill in software engineering.

<details>
<summary>Click for solution</summary>

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

</details>

### Grains

##### Instructions

Calculate the number of grains of wheat on a chessboard given that the number
on each square doubles.

There once was a wise servant who saved the life of a prince. The king
promised to pay whatever the servant could dream up. Knowing that the
king loved chess, the servant told the king he would like to have grains
of wheat. One grain on the first square of a chess board, with the number
of grains doubling on each successive square.

There are 64 squares on a chessboard (where square 1 has one grain, square 2 has two grains, and so on).

Write code that shows:
- how many grains were on a given square, and
- the total number of grains on the chessboard

##### For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- Optimize for speed.
- Optimize for readability.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?

<details>
<summary>Click for solution</summary>

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

</details>

### Hamming

##### Instructions

Calculate the Hamming Distance between two DNA strands.

Your body is made up of cells that contain DNA. Those cells regularly wear out and need replacing, which they achieve by dividing into daughter cells. In fact, the average human body experiences about 10 quadrillion cell divisions in a lifetime!

When cells divide, their DNA replicates too. Sometimes during this process mistakes happen and single pieces of DNA get encoded with the incorrect information. If we compare two strands of DNA and count the differences between them we can see how many mistakes occurred. This is known as the "Hamming Distance".

We read DNA using the letters C,A,G and T. Two strands might look like this:

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

They have 7 differences, and therefore the Hamming Distance is 7.

The Hamming Distance is useful for lots of things in science, not just biology, so it's a nice phrase to be familiar with :)

##### Implementation notes

The Hamming distance is only defined for sequences of equal length, so
an attempt to calculate it between sequences of different lengths should
not work. The general handling of this situation (e.g., raising an
exception vs returning a special value) may differ between languages.

<details>
<summary>Click for solution</summary>

```julia
function distance(a, b)
    length(a) != length(b) && throw(ArgumentError("The sequences must be of equal length!"))
    return sum(map(!=, a, b))
end
```

</details>

### Hello World

##### Instructions

The classical introductory exercise. Just say "Hello, World!".

["Hello, World!"](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) is
the traditional first program for beginning programming in a new language
or environment.

The objectives are simple:

- Write a function that returns the string "Hello, World!".
- Run the test suite and make sure that it succeeds.
- Submit your solution and check it at the website.

If everything goes well, you will be ready to fetch your first real exercise.

<details>
<summary>Click for solution</summary>

```julia
function hello()
    return "Hello, World!"
end
```

</details>

### Leap

##### Instructions

Given a year, report if it is a leap year.

The tricky thing here is that a leap year in the Gregorian calendar occurs:

```text
on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

##### Notes

Though our exercise adopts some very simple rules, there is more to
learn!

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

<details>
<summary>Click for solution</summary>

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

</details>

### Nucleotide Count

##### Instructions

Each of us inherits from our biological parents a set of chemical instructions known as DNA that influence how our bodies are constructed. All known life depends on DNA!

> Note: You do not need to understand anything about nucleotides or DNA to complete this exercise.

DNA is a long chain of other chemicals and the most important are the four nucleotides, adenine, cytosine, guanine and thymine. A single DNA chain can contain billions of these four nucleotides and the order in which they occur is important!
We call the order of these nucleotides in a bit of DNA a "DNA sequence".

We represent a DNA sequence as an ordered collection of these four nucleotides and a common way to do that is with a string of characters such as "ATTACG" for a DNA sequence of 6 nucleotides.
'A' for adenine, 'C' for cytosine, 'G' for guanine, and 'T' for thymine.

Given a string representing a DNA sequence, count how many of each nucleotide is present.
If the string contains characters that aren't A, C, G, or T then it is invalid and you should signal an error.

For example:

```
"GATTACA" -> 'A': 3, 'C': 1, 'G': 1, 'T': 2
"INVALID" -> error
```

<details>
<summary>Click for solution</summary>

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

</details>

### Pangram

##### Instructions

Determine if a sentence is a pangram. A pangram (Greek: παν γράμμα, pan gramma,
"every letter") is a sentence using every letter of the alphabet at least once.
The best known English pangram is:
> The quick brown fox jumps over the lazy dog.

The alphabet used consists of ASCII letters `a` to `z`, inclusive, and is case
insensitive.

<details>
<summary>Click for solution</summary>

```julia
"""
    ispangram(input)
 
Return `true` if `input` contains every alphabetic character (case insensitive).
 
"""
function ispangram(input)
    return 'a':'z' ⊆ lowercase(input)
end

```

</details>

### Reverse String

##### Instructions

Reverse a string

For example:
input: "cool"
output: "looc"

##### Bonus

Preserve grapheme clusters, i.e.

```julia
myreverse("hi 👋🏾") == "👋🏾 ih"
myreverse("as⃝df̅") == "f̅ds⃝a"
```

You will probably find the `Unicode` stdlib useful for this bonus task.

To enable the graphemes test, add `const TEST_GRAPHEMES = true` to the global scope of your file.

<details>
<summary>Click for solution</summary>

```julia
using Unicode:graphemes
function myreverse(s)
    return join(reverse(collect(graphemes(s))))
end
```

</details>

### RNA Transcription

##### Instructions

Given a DNA strand, return its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`

<details>
<summary>Click for solution</summary>

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

</details>

### Robot Name

##### Instructions

Manage robot factory settings.

When a robot comes off the factory floor, it has no name.

The first time you turn on a robot, a random name is generated in the format
of two uppercase letters followed by three digits, such as RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings,
which means that its name gets wiped. The next time you ask, that robot will
respond with a new random name.

The names must be random: they should not follow a predictable sequence.
Using random names means a risk of collisions. Your solution must ensure that
every existing robot has a unique name.

##### Bonus

The test suite only generates ~100 names by default.
There are ~700k valid names, so it will only give a small chance of collisions.
Consider testing your solution for collisions in some other way in addition to the test suite.

This exercise continues our exploration of Julia's
[type system](https://docs.julialang.org/en/v1/manual/types/),
this time with mutable types,
and introduces us to
[random number generation](https://docs.julialang.org/en/v1/stdlib/Random/).

We will imagine that resetting the robot to the factory settings is like a surgery: it makes changes to the subject, but doesn't replace it.
We could also have modeled the problem such that resetting a robot creates a new robot, but not every problem can be modeled solely with immutable data structures (even purely functional languages deal with mutability inside their runtimes!).

In Julia, functions that mutate their arguments have a suffix `!` by convention.
So our method for doing this will be called `reset!`.

This is only a convention, but almost all published Julia code follows it and you might come to agree that it's quite helpful!

##### Hints

You will need to define
a method for generating unique names,
a structure to describe robots,
a method for resetting a robot,
and a method for getting the name of a robot.

You might find it helpful to design your program first to just emit a random name for a robot (without worrying about collisions) and then later to think about and design a scheme that will avoid ever issuing duplicate names.
In your design, be thoughtful about how the run time of name generation changes as names run out. What guarantees do you want to offer the caller?

<details>
<summary>Click for solution</summary>

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

</details>

### Rotational Cipher

##### Instructions

Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.

The Caesar cipher is a simple shift cipher that relies on
transposing all the letters in the alphabet using an integer key
between `0` and `26`. Using a key of `0` or `26` will always yield
the same output due to modular arithmetic. The letter is shifted
for as many values as the value of the key.

The general notation for rotational ciphers is `ROT + <key>`.
The most commonly used rotational cipher is `ROT13`.

A `ROT13` on the Latin alphabet would be as follows:

```text
Plain:  abcdefghijklmnopqrstuvwxyz
Cipher: nopqrstuvwxyzabcdefghijklm
```

It is stronger than the Atbash cipher because it has 27 possible keys, and 25 usable keys.

Ciphertext is written out in the same formatting as the input including spaces and punctuation.

##### Examples

- ROT5  `omg` gives `trl`
- ROT0  `c` gives `c`
- ROT26 `Cool` gives `Cool`
- ROT13 `The quick brown fox jumps over the lazy dog.` gives `Gur dhvpx oebja sbk whzcf bire gur ynml qbt.`
- ROT13 `Gur dhvpx oebja sbk whzcf bire gur ynml qbt.` gives `The quick brown fox jumps over the lazy dog.`

##### Bonus

This is a good exercise to experiment with non-standard string literals and metaprogramming.

A short introduction to non-standard string literals can be found in this [blog post](https://web.archive.org/web/20170625222109/https://iaindunning.com/blog/julia-unicode.html). A detailed metaprogramming guide can be found in the [manual](https://docs.julialang.org/en/v1/manual/metaprogramming/).

You can extend your solution by adding the functionality described below.

Bonus A only requires basics as outlined in the blog post. Bonus B requires significantly more knowledge of metaprogramming in Julia.

##### Bonus A
Implement a string literal that acts as `ROT13` on the string:
```julia
R13"abcdefghijklmnopqrstuvwxyz" == "nopqrstuvwxyzabcdefghijklm"
```

##### Bonus B
Implement string literals `R<i>`, `i = 0, ..., 26`, that shift the string for `i` values:
```julia
R0"Hello, World!" == "Hello, World!"
R4"Testing 1 2 3 testing" == "Xiwxmrk 1 2 3 xiwxmrk"
R13"abcdefghijklmnopqrstuvwxyz" == "nopqrstuvwxyzabcdefghijklm"
```

<details>
<summary>Click for solution</summary>

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

</details>

### Secret Handshake

##### Instructions

> There are 10 types of people in the world: Those who understand
> binary, and those who don't.

You and your fellow cohort of those in the "know" when it comes to
binary decide to come up with a secret "handshake".

```text
1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```

Given a decimal number, convert it to the appropriate sequence of events for a secret handshake.

Here's a couple of examples:

Given the input 3, the function would return the array
["wink", "double blink"] because 3 is 11 in binary.

Given the input 19, the function would return the array
["double blink", "wink"] because 19 is 10011 in binary.
Notice that the addition of 16 (10000 in binary)
has caused the array to be reversed.

<details>
<summary>Click for solution</summary>

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

</details>
