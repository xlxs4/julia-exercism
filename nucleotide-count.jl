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
