const complements = Dict('A' => 'U', 'C' => 'G', 'G' => 'C', 'T' => 'A')
function to_rna(x::AbstractChar, complements)
    bases = keys(complements)
    x ∈ bases || throw(ErrorException("Nucleotide can be one of 'A', 'C', 'G', 'T'!"))
    return complements[x]
end
to_rna(dna, complements) = map(x -> to_rna(x, complements), dna)
to_rna(dna) = to_rna(dna, complements)
