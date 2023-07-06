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

t1 = [1, 2]
t2 = push!(t1, 3)
print(t1)

t3 = vcat(t1, 4)
print(t1)
print(t3)

function badDeleteHead(t)
    t = t[2:end]
end

badDeleteHead(e)

function tail(t::Vector{})
    return t[2:end]
end

e1 = tail(e)
print(e)
print(e1)

t = [3, 1, 2]
t2 = deepcopy(t)
t2 ≡ t

insert!(e1, 2, 22)

insert!(e1, 3, 50)
insert!(e1, 5, 50)
insert!(e1, 6, 80)

"""
    nestedSum(arr::Vector{Vector{Int64}})
 Calculate the sum of all elements in a nested vector of integers.
 # Arguments
- `arr::Vector{Vector{Int64}}`: The input vector containing nested vectors of integers.
 # Returns
The sum of all elements in the nested vector.
 # Examples
 julia 
# Example 1 
nestedSum([[1, 2, 3], [4, 5, 6], [7, 8, 9]])  # Output: 45 
 
# Example 2 
nestedSum([[10, 20], [30, 40, 50]])  # Output: 150
 """
function nestedSum(arr::Vector{Vector{Int64}})
    sum = 0
    for subArr ∈ arr
        for num ∈ subArr
            sum += num
        end
    end
    return sum
end

t = [[1, 2], [3], [4, 5, 6]]
t1 = [2, 3, 4, [5, 6]]
nestedSum(t)

function nestedSum2(arr)
    sum = 0
    for subArr ∈ arr
        if isa(subArr, Vector)
            println("Latest element of the array $arr is $subArr")
            # sum += nestedSum2(subArr)
            for num ∈ subArr
                println("Element to be added: $num")
                sum += num
            end
            println("Now sum = $sum")
        elseif isa(subArr, Int)
            println("Element to be added: $subArr")
            sum += subArr
            println("Now sum = $sum")
        end
    end
    return sum
end

t1 = [2, 3, 4, [5, 6]]
result = nestedSum2(t1)

function cumulSum(arr)
    n = length(arr)
    sums = zeros(n+1)
    sums[1] = 0
    idx = 2
    for subArr ∈ arr
        if isa(subArr, Vector)
            println("Latest element of the array is $subArr")
            sums[idx] = sums[idx-1] + nestedSum2(subArr)
        elseif isa(subArr, Int)
            sums[idx] = sums[idx-1] + subArr
        end
        idx += 1
    end
    return sums[2:end]
end
            
cumulSum(t1)
t2 = [1, 2, 3]
cumulSum(t2)

function interior(arr)
    return arr[2:end-1]
end

interior(cumulSum(t1))

function interior!(arr)
    pop!(arr);
    popfirst!(arr);
    return 
end

t1 = [1, 2, 3, 5, [3, 5], 4]
interior(t1)
interior!(t1)

function isSort(arr)
    if sort(arr) == arr
        return true
    else
        return false
    end
end

arr1 = [1, 2, 3]
arr2 = ['b', 'a']
isSort(arr1)
isSort(arr2)

function isAnagram(str1::String, str2::String)
    orderedChars1 = sort!(collect(str1))
    orderedChars2 = sort!(collect(str2))
    num1 = length(orderedChars1)
    num2 = length(orderedChars2)
    if num1 != num2
        return false
    else
        n = num1
        for i = 1:n
            if orderedChars1[i] != orderedChars2[i]
                return false
            end
        end
    end
    return true
end

str1 = "anagrams"
str2 = "nagrmsaa"
str3 = "hello"
str4 = "helo"
isAnagram(str1, str2)
isAnagram(str3, str4)

function myprint(verbose, args)
    if verbose == true
        print(args)
    end
end

function hasDuplicates(arr; verbose = false)
    if isa(arr, String)
        myprint(verbose, "Argument is a String, converting into a Vector of chars.\n")
        arr = collect(arr)
    end
    println(arr)
    @show n = length(arr)
    @show nUnique = length(Set(arr))
    if n == nUnique
        return false
    else
        return true
    end
end

hasDuplicates(str1)
hasDuplicates(str2)
hasDuplicates(str3)
hasDuplicates(str4, verbose=true)
hasDuplicates(t1, verbose=true)

function birthdayParadox(n::Int64=23; 
    numSims::Int64=1000, 
    verbose::Bool=false)
    samesies = 0
    if n > 60
        myprint(verbose, "Number of students large enough that the number of " *
        "simulations may need to be increased to a very high number to " *
        "accurately catch cases with no shared birthdays.\n")
    end
    for run = 1:numSims
        bdays = rand(1:365, n)
        if length(bdays) != length(Set(bdays))
            samesies += 1
        end
    end
    prob = samesies/numSims
    return prob
end

birthdayParadox(61, verbose=true)

function listOfWords(filename::String="words.txt";
    method::String="push!",
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool=false)
    if !contains(filename, ".")
        myprint(verbose, "filename does not have extension embedded.\n
        adding extension $extension at its end.\n")
        filename = filename*extension
    end
    fin = open(rawDataFolder*filename)
    words = []
    if method == "push!"
        myprint(verbose, "Supposedly the faster and space-efficient method.\n")
        for line ∈ eachline(fin)
            word = line
            push!(words, word);
        end
    elseif method == "copyAndAdd"
        myprint(verbose, "Supposedly the slower and space-inefficient method.\n")
        for line ∈ eachline(fin)
            word = line
            words = [words..., word]
        end
    else
        error("Unknown array building method!")
    end

    return words
end

@time listOfWords(verbose=true)
@time listOfWords(method="copyAndAdd", verbose=true)

words1 = sort!(listOfWords())
function inBisect(arr::Vector{Any}=sort!(listOfWords());
    targetStr::String="baby",
    verbose = false)
    
    if sort(arr) != arr
        error("Array is NOT sorted.")
    else
        lookups = 0;
        left = 1
        right = length(arr)
        while left != right
            lookups += 1;
            mid = (left+right)÷2 + 1
            if arr[mid] == targetStr
                myprint(verbose, "Target found! At index $mid \n")
                myprint(verbose, "using only $lookups lookups!\n")
                return true, mid
            elseif arr[mid] > targetStr
                right = mid
            elseif arr[mid] < targetStr
                left = mid
            else
                error("Didn't see that coming.")
            end
        end
    end
    
    return false
end

arr1 = ["a", "b", "c", "d", "e"]
inBisect(arr1, targetStr="hello", verbose=true)