using CSV
using DataFrames

function addall(t)
    total = 0
    for x ∈ t
        total 
    end
    return total
end

# t = 1:4
# addall(t)

"""
    capitalizeAll(t::Vector{Char})
Converts all characters in the input vector `t` to uppercase.
# Arguments
- `t::Vector{Char}`: The input vector of characters.
# Returns
A new vector with all characters converted to uppercase.
# Examples
```julia 
julia> capitalizeAll(['h', 'e', 'l', 'l', 'o']) 
5-element Vector{Char}: 
'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase) 
'E': ASCII/Unicode U+0045 (category Lu: Letter, uppercase) 
'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase) 
'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase) 
'O': ASCII/Unicode U+004F (category Lu: Letter, uppercase)
```
"""
function capitalizeAll(t::Vector{Char})
    answer = []
    for character ∈ t
        push!(answer, uppercase(character))
    end
    return answer
end

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
```
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

# t3 = ['a', 'B', 'C', 'p', 'I', 'K', 'A', 'c', 'H', 'u']
# onlyUpper(t3)

# print([1, 2, 3].^3)

# t = uppercase.(["abc", "der", "pv", "wind"])

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
```
"""
function capitalizeAll2(t::Vector{Char})
    return uppercase.(t)
end

# capitalizeAll2(t3)

function badDeleteHead(t)
    t = t[2:end]
end

function tail(t::Vector{})
    return t[2:end]
end

"""
    nestedSum(arr::Vector{Vector{Int64}})
Calculate the sum of all elements in a nested vector of integers.
# Arguments
- `arr::Vector{Vector{Int64}}`: The input vector containing nested vectors of integers.
# Returns
The sum of all elements in the nested vector.
# Examples
```julia 
# Example 1 
nestedSum([[1, 2, 3], [4, 5, 6], [7, 8, 9]])  # Output: 45 

# Example 2 
nestedSum([[10, 20], [30, 40, 50]])  # Output: 150
```
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

# t = [[1, 2], [3], [4, 5, 6]]
# t1 = [2, 3, 4, [5, 6]]
# nestedSum(t)

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

# t1 = [2, 3, 4, [5, 6]]
# result = nestedSum2(t1)

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
            
# cumulSum(t1)
# t2 = [1, 2, 3]
# cumulSum(t2)

function interior(arr)
    return arr[2:end-1]
end

# interior(cumulSum(t1))

function interior!(arr)
    pop!(arr);
    popfirst!(arr);
    return 
end

# t1 = [1, 2, 3, 5, [3, 5], 4]
# interior(t1)
# interior!(t1)

function isSort(arr)
    if sort(arr) == arr
        return true
    else
        return false
    end
end

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

# str1 = "anagrams"
# str2 = "nagrmsaa"
# str3 = "hello"
# str4 = "helo"
# isAnagram(str1, str2)
# isAnagram(str3, str4)

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

# hasDuplicates(str1)
# hasDuplicates(str2)
# hasDuplicates(str3)
# hasDuplicates(str4, verbose=true)
# hasDuplicates(t1, verbose=true)

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

# birthdayParadox(61, verbose=true)

function listOfWords(filename::String="words.txt";
    method::String="push!",
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool=false)::Vector{String}
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
    elseif method == "copyAndAdd" #Don't do it for big arrays like words.txt
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

# Supposedly the faster and space-efficient method.
#   0.019763 seconds (113.87 k allocations: 4.935 MiB)
# Supposedly the slower and space-inefficient method.
# 103.316894 seconds (566.53 k allocations: 96.528 GiB, 7.30% gc time)
# @time listOfWords(verbose=true)
# @time listOfWords(method="copyAndAdd", verbose=true)

# arr1 = listOfWords()

"""
    inBisect(arr::Vector{String}, targetStr::String;
        verbose::Bool = false,
        sortingCheck::Bool = false)::Tuple{Bool, Int64}

Exercise 10-10 in Arrays in Think Julia
Check if a target string exists in a sorted array using the binary search algorithm.

This function performs a binary search on a sorted array of strings `arr` to determine if a target string `targetStr` is present in the array.

## Arguments
- `arr::Vector{String}`: The sorted input array of strings.
- `targetStr::String`: The target string to be searched in the array.
- `verbose::Bool`: Optional. If set to `true`, print verbose output. Default is `false`.
- `sortingCheck::Bool`: Optional. If set to `true`, perform a sorting check on the input array to ensure it is sorted. Default is `false`.

## Returns
- `result::Tuple{Bool, Int64}`: A tuple containing the search result.
- The first element is a boolean indicating whether the `targetStr` is found (`true`) or not found (`false`).
- The second element is an integer representing the index of the `targetStr` in the array if found, or `-1` if not found.

## Details
The function assumes that the input array `arr` is sorted in ascending order. If `sortingCheck` is set to `true`, it performs a check to ensure that the array is sorted before proceeding with the binary search. If the array is not sorted, the function raises an error.

The binary search algorithm efficiently searches for the `targetStr` by repeatedly dividing the search interval in half. It compares the middle element of the interval to the `targetStr` and narrows down the search to the left or right half accordingly.

If the `targetStr` is found in the array, the function returns `true` along with the index of the `targetStr`. If the `targetStr` is not found, the function returns `false` along with `-1`.

## Example
```julia
arr = ["apple", "banana", "cherry", "grape", "orange"]
target = "cherry"
result = inBisect(arr, target)  # Returns (true, 3)
```
"""
function inBisect(arr::Vector{String},
    targetStr::String;
    verbose::Bool = false,
    sortingCheck::Bool = false)::Tuple{Bool, Int64}
    
    # @show length(arr)
    if sortingCheck && sort(arr) != arr
        error("Array is NOT sorted.")
    else
        lookups = 0;
        left = 1
        right = length(arr)
        while left ≤ right
            lookups += 1;
            mid = (left+right)÷2
            if arr[mid] == targetStr
                myprint(verbose, "Target found! At index $mid \n")
                myprint(verbose, "using only $lookups lookups!\n")
                return true, mid
            elseif arr[mid] > targetStr
                right = mid - 1
            elseif arr[mid] < targetStr
                left = mid + 1
            else
                error("Didn't see that coming.")
            end
        end
    end
    
    return false, -1
end

# inBisect(arr1, "apple", verbose=false)


function findReversePairs(arr::Vector{String};
    verbose::Bool=false,
    saveToFile::Bool=true,
    filename::String="words",
    processedDataFolder::String="processedData/",
    extension::String=".csv")::DataFrame

    colNames = (:Word1, :Word2, :Idx1, :Idx2, :Palindrome)
    colTypes = (String, String, Int64, Int64, Bool)
    reversePairs = Vector{NamedTuple{colNames , colTypes }}()

    N = length(arr)
    
    function binarySearchReverse(word::String, left::Int, right::Int)::Tuple{Bool, Int64}
        while left <= right
            mid = (left + right) ÷ 2
            if arr[mid] == word
                return true, mid
            elseif arr[mid] < word
                left = mid + 1
            else
                right = mid - 1
            end
        end
        return false, left
    end

    for i = 1:N
        word = arr[i]
        drow = reverse(word)

        if word == drow
            push!(reversePairs, (Word1 = word, Word2 = drow, Idx1 = i, Idx2 = i, Palindrome = true))

            myprint(verbose, "A Palindrome found!")
            myprint(verbose, "$word at index $i.")
        else
            foundFlag, idx = binarySearchReverse(drow, i+1, N)
            if foundFlag
                push!(reversePairs, (Word1 = word, Word2 = drow, Idx1 = i, Idx2 = idx, Palindrome = false))

                myprint(verbose, "A Reverse Pair found!")
                myprint(verbose, "$word at index $i and $drow at index $idx.")
            end
        end
    end
    df = DataFrame(reversePairs)

    if saveToFile && N > 10000
        # Don't accidentally overwrite reverse pairs of words.txt
        # for a small testcase
        filename_output = processedDataFolder*filename*"_reversePairs"*extension
        CSV.write(filename_output, df)
    end

    return df
end

# @time dfReversePairs = findReversePairs2(arr1, verbose=false, saveToFile=true);

function findInterlocks(arr::Vector{String};
    verbose::Bool=false,
    saveToFile::Bool=true,
    filename::String="words",
    processedDataFolder::String="processedData/",
    extension::String=".csv")::DataFrame

    df = DataFrame(ID=Int64[], Word1=String[], Word2=String[], 
    Interlock=String[], Idx1=Int64[], Idx2=Int64[], Idx12=Int64[])

    interlocks = 0
    N = length(arr1)
    for i = 1:N
        word = arr[i]
        word1 = word[1:2:end]
        searchVal1, idx1 = inBisect(arr1, word1)
        if searchVal1
            word2 = word[2:2:end]
            searchVal2, idx2 = inBisect(arr1, word2)
            if searchVal2
                interlocks += 1
                myprint(verbose, "Interlocking words found! $word can be formed using $word1 and $word2 .\n")
                push!(df, (ID = interlocks, Word1 = word1, 
                Word2 = word2, Interlock = word, Idx1 = idx1, Idx2 = idx2,
                Idx12 = i))
            end
        end
    end

    if saveToFile && N > 10000 
        # Don't accidentally overwrite reverse pairs of words.txt
        # for a small testcase
        filename_output = processedDataFolder*filename*"_interlocks"*extension
        CSV.write(filename_output, df)
    end

    return df
end

# @time dfInterlocks = findInterlocks(arr1, verbose=false, saveToFile=true);