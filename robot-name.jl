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
