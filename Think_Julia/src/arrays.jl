[10, 20, 30, 40]
["crunchy frog", "ram bladder", "lark vomit"]
x22 = ["spam", 2.0, 5, [10, 20]]
cheeses = ["cheddar", "edam", "gouda"]
numbers = [42, 123];
empty = [];
print(cheeses, " ", numbers, " ", empty)
typeof(empty)
numbers[2] = 5
println(numbers)
"Edam" ∈ cheeses
for cheese ∈ cheeses
    println(cheese)
end

for i in eachindex(numbers)
    numbers[i] *= 2
end

for x ∈ x22
    println("This can never happen?")
end

t = ['a', 'b', 'c', 'd', 'e', 'f']


print(t[1:3])
print(t[4:end])
print(t[:])
t[2:3] = ['x', 'y']
t = ['a', 'b', 'c']
push!(t, 'd')
print(t)
t2 = ['d', 'e']
append!(t, t2)
print(t)
sort!(t)
print(t)

function addall(t)
    total = 0
    for x ∈ t
        total 
    end
    return total
end

t = 1:4
addall(t)

"""
    capitalizeAll(t::Vector{Char})
 Converts all characters in the input vector `t` to uppercase.
 # Arguments
- `t::Vector{Char}`: The input vector of characters.
 # Returns
A new vector with all characters converted to uppercase.
 # Examples
 julia 
julia> capitalizeAll(['h', 'e', 'l', 'l', 'o']) 
5-element Vector{Char}: 
 'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase) 
 'E': ASCII/Unicode U+0045 (category Lu: Letter, uppercase) 
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase) 
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase) 
 'O': ASCII/Unicode U+004F (category Lu: Letter, uppercase)
 """
function capitalizeAll(t::Vector{Char})
    answer = []
    for character ∈ t
        push!(answer, uppercase(character))
    end
    return answer
end

capitalizeAll(t2)

"""
    onlyUpper(t::Vector{Char})

This function takes in a vector of characters `t` and returns a new vector containing only the uppercase characters from `t`.
This function basically is a filter.
# Arguments
- `t::Vector{Char}`: The input vector of characters.

# Returns
A new vector containing only the uppercase characters from `t`.

# Examples
```julia
julia> onlyUpper(['A', 'b', 'C', 'd'])
3-element Vector{Char}:
 'A'
 'C'
 'D'
"""
function onlyUpper(t::Vector{Char})
    answer = []
    for character ∈ t
        if character == uppercase(character)
            push!(answer, character)
        end
    end
    return answer
end

t3 = ['a', 'B', 'C', 'p', 'I', 'K', 'A', 'c', 'H', 'u']
onlyUpper(t3)

print([1, 2, 3].^3)

t = uppercase.(["abc", "der", "pv", "wind"])

"""
    capitalizeAll2(t::Vector{Char})
 Converts all characters in the input vector `t` to uppercase.
 # Arguments
- `t::Vector{Char}`: The input vector of characters.
 # Returns
A new vector with all characters converted to uppercase.
 # Examples
 julia> capitalizeAll2(['h', 'e', 'l', 'l', 'o'])
5-element Vector{Char}:
 'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase)
 'E': ASCII/Unicode U+0045 (category Lu: Letter, uppercase)
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase)
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase)
 'O': ASCII/Unicode U+004F (category Lu: Letter, uppercase)
 """
function capitalizeAll2(t::Vector{Char})
    return uppercase.(t)
end

capitalizeAll2(t3)

t4 = ['a', 'b', 'c']
splice!(t4, 2)
pop!(t4)
print(t4)
pop!(t4)
print(t4)
t = ['a', 'c', 'd', 'f']
popfirst!(t)
pushfirst!(t, 'w')
push!(t, 'r')
print(t)
print(deleteat!(t, 2))
insert!(t, 3, 'y')
print(t)
t = collect("Spam")
print(t)
t = split("Pining for the fjords")
typeof(t)

t = split("spam-spam-spam", '-')
print(t)
s = join(t, ' ')
print(s)

collect(s)
join(collect("Pining for the fjords"), ' ')

a = "banana"
b = "banana"
a ≡ b

c = [1, 2, 3]
d = [1, 2, 3]
c ≡ d

e = [1, 2, 3]
f = e
push!(e, 420)
popfirst!(f)

