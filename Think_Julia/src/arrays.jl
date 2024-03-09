include("setup.jl")
# using CSV
# using DataFrames

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
    nestedSum0(arr::Vector{Vector{Int64}}) -> Int

Calculates the sum of integers within a two-dimensional array (a vector of vectors of integers). This function iterates over each sub-array and sums its integers, accumulating the total sum of all elements.

# Arguments
- `arr::Vector{Vector{Int64}}`: A two-dimensional array where each element is a vector of integers.

# Returns
- `Int`: The total sum of all integers contained within the two-dimensional array.

# Limitations
- The function only works with two-dimensional arrays, specifically vectors of vectors of integers. It cannot handle deeper nesting or mixed data structures (e.g., arrays containing both integers and further sub-arrays).
- Unlike `nestedSum`, which can recursively handle arrays nested to any depth and mixed types within the same array, `nestedSum0` is restricted to a single level of nested arrays. This makes `nestedSum0` less versatile for applications requiring the processing of complex nested data structures.

# Example
```julia
julia> nestedSum0([[1, 2, 3], [4, 5], [6]])
# Output: 21
```
"""
function nestedSum0(arr::Vector{Vector{Int64}})
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
"""
    nestedSum(arr) -> Int

Recursively calculates the total sum of all integers in a nested array structure, which can contain both integers and further sub-arrays of integers. The function handles arbitrary levels of nesting by recursively summing the contents of each sub-array.

# Arguments
- `arr`: A nested array of integers and/or sub-arrays of integers.

# Returns
- `Int`: The total sum of all integers found within the nested array structure.

# Process
- For each element in `arr`, the function checks if it is an integer or a sub-array.
    - If it is an integer, the value is added directly to the running total sum.
    - If it is a sub-array, the function iteratively processes each element of this sub-array. For elements that are themselves arrays, `nestedSum` is called recursively to sum their contents.
- The function prints details about its progress, including elements being added and the current sum, enhancing traceability and understanding of its operation.

# Examples
```julia
julia> nestedSum([2, 3, 4, [5, 6]])
# Output: 20

julia> nestedSum([1, [2, 3], [4, [5, 6]]])
# Output: 21

julia> nestedSum([1, [2, 3], [4, [5, 6, [7]]]])
# Output: 28
```
"""
function nestedSum(arr)
    sum = 0
    for subArr ∈ arr
        if isa(subArr, Vector)
            println("Latest element of the array $arr is $subArr")
            for subArr_1 ∈ subArr
                println("It's own subarray to be added: $subArr_1")
                sum += nestedSum(subArr_1)
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
t2 = [1, [2, 3], [4, [5, 6]]]
t3 = [1, [2, 3], [4, [5, 6, [7]]]]

result = nestedSum(t1)
result = nestedSum(t2)
result = nestedSum(t3)

function cumulSum(arr)
    n = length(arr)
    sums = zeros(n+1)
    sums[1] = 0
    idx = 2
    for subArr ∈ arr
        if isa(subArr, Vector)
            println("Latest element of the array is $subArr")
            sums[idx] = sums[idx-1] + nestedSum(subArr)
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

# function myprint(verbose, args)
#     if verbose == true
#         print(args)
#     end
# end

"""
    hasDuplicates(arr; verbose = false) -> Bool

Exercise 10-7 in Think Julia.

Checks whether the input array `arr` has duplicate elements.

# Arguments
- `arr`: An array or string to check for duplicates. If `arr` is a string, it is converted into an array of characters.
- `verbose::Bool=false`: If `true`, additional information about the processing is printed. By default, this is set to `false`.

# Returns
- `Bool`: Returns `true` if there are duplicates in the array, `false` otherwise.

# Notes
- If the input `arr` is a string, the function first prints a message about the conversion (if `verbose` is `true`), then checks the characters of the string for duplicates.
- The function prints the input array, the total number of elements `n`, and the number of unique elements `nUnique` as part of its operation. This function demonstrates basic type checking, optional verbose output, and the use of sets to identify unique elements in an array or string.

# Examples
The following examples illustrate how to use `hasDuplicates`:

```julia
julia> hasDuplicates([1, 2, 3, 4])
[1, 2, 3, 4]
n = 4
nUnique = 4
false

julia> hasDuplicates("hello"; verbose = true)
Argument is a String, converting into a Vector of chars.

['h', 'e', 'l', 'l', 'o']
n = 5
nUnique = 4
true
```
"""
function hasDuplicates(arr; verbose = false)
    if isa(arr, String)
        myprint(verbose, "Argument is a String, converting into a Vector of chars.\n")
        arr = collect(arr)
    end
    println(arr)
    n = length(arr)
    nUnique = length(Set(arr))
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

"""
    birthdayParadox(n::Int64=23; numSims::Int64=1000, verbose::Bool=false) -> Float64

Exercise 10-8 in Think Julia.

Simulates the birthday paradox to estimate the probability that at least two people in a group of `n` share the same birthday.

# Arguments
- `n::Int64=23`: The number of individuals in the simulated group. Default is 23, which is the smallest number where the probability exceeds 50%.
- `numSims::Int64=1000`: The number of simulations to run. More simulations increase the accuracy of the probability estimate. Default is 1000.
- `verbose::Bool=false`: If `true`, prints additional information during the simulation, especially warnings about the adequacy of the number of simulations for large `n`. Default is `false`.

# Returns
- `Float64`: The estimated probability (as a fraction of 1) that at least two people in a group of `n` have the same birthday.

# Notes
- The function generates random birthdays for each individual in the group and checks for duplicates to determine if any two individuals share a birthday.
- The birthday paradox demonstrates that in a group of 23 people, there is over a 50% chance that at least two people will have the same birthday, despite there being 365 possible birthdays.
- For large `n` values (greater than 60), the function suggests increasing `numSims` for more accurate results due to the increased likelihood of shared birthdays. This simulation provides an intuitive understanding of the birthday paradox and the counterintuitive nature of probability in large groups.

# Examples
The following examples illustrate how to use `birthdayParadox`:

```julia
julia> birthdayParadox()
0.507

julia> birthdayParadox(50; verbose=true)
Number of students large enough that the number of simulations may need to be increased to a very high number to accurately catch cases with no shared birthdays.
0.97
```
"""
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

"""
    listOfWords(filename::String="words.txt"; method::String="push!", rawDataFolder::String="rawData/", extension::String=".txt", verbose::Bool=false) -> Vector{String}

Exercise 10-9 of Think Julia

Reads a list of words from a specified file and returns them as a vector of strings. This function is designed to be flexible in terms of file location, naming, and the method used to construct the list.

# Arguments
- `filename::String="words.txt"`: The name of the file to read. If the filename does not contain an extension, `.txt` is appended by default.
- `method::String="push!"`: The method used to construct the list of words. Options are `"push!"` for appending each word to the vector (recommended for efficiency) and `"copyAndAdd"` for creating a new vector each time (not recommended for large files).
- `rawDataFolder::String="rawData/"`: The directory where the file is located. Defaults to a folder named `rawData/`.
- `extension::String=".txt"`: The default file extension to append to `filename` if it does not already contain an extension.
- `verbose::Bool=false`: If `true`, prints additional information about the file reading and list construction process.

# Returns
- `Vector{String}`: A vector containing all words read from the file.

# Notes
- The function checks if the provided `filename` includes a file extension. If not, it appends the default extension (`.txt`) to the filename.
- The `method` argument allows the user to choose between using `push!` to efficiently build the list or `copyAndAdd`, which is less efficient and not recommended for large files.
"""
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

"""
    findReversePairs(arr::Vector{String}; verbose::Bool=false, saveToFile::Bool=true, filename::String="words", processedDataFolder::String="processedData/", extension::String=".csv") -> DataFrame

Exercise 10-11 in Think Julia

Searches a sorted array of strings for all pairs of words where one is the reverse of the other. Optionally, identifies palindromes (words that are the same when reversed). The results are returned as a DataFrame and optionally saved to a CSV file.

# Arguments
- `arr::Vector{String}`: A sorted vector of strings to search through.
- `verbose::Bool=false`: If `true`, prints additional information about found pairs and palindromes during the search.
- `saveToFile::Bool=true`: If `true`, saves the found pairs and palindromes to a CSV file. The saving occurs only if the array length is greater than 10,000 to avoid overwriting small test cases.
- `filename::String="words"`: The base name for the output file when saving results. The full filename is constructed using the `processedDataFolder` and `extension`.
- `processedDataFolder::String="processedData/"`: The folder where the output file is saved.
- `extension::String=".csv"`: The file extension for the output file.

# Returns
- `DataFrame`: A DataFrame containing the found reverse pairs and palindromes. The columns are: `Word1`, `Word2`, `Idx1` (index of `Word1`), `Idx2` (index of `Word2` or the same as `Idx1` for palindromes), and `Palindrome` (a boolean indicating whether the pair is a palindrome).

# Details
The function implements a binary search algorithm to efficiently find reverse pairs in the sorted array. For each word, it searches for its reverse and checks if it exists in the array. If a reverse pair is found or a word is identified as a palindrome, it is added to the results.

Palindromes are words that are identical to their reverse and are specially flagged in the output. The function uses a binary search to minimize the search space for each word's reverse, improving efficiency over a naive search approach.

# Notes
- The array `arr` must be sorted for the binary search to work correctly.
- The function checks the array's size before saving to file to prevent overwriting detailed data from a large dataset with results from a smaller, test case.
"""
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

"""
    findInterlocks(arr::Vector{String}; verbose::Bool=false, saveToFile::Bool=true, filename::String="words", processedDataFolder::String="processedData/", extension::String=".csv") -> DataFrame

Exercise 10-12 in Think Julia

Searches a sorted array of strings for interlocking words. An interlock occurs when two words can be intertwined to form a third word. For example, "shoe" and "cold" interlock to form "schooled". The results are returned as a DataFrame and optionally saved to a CSV file.

# Arguments
- `arr::Vector{String}`: A sorted vector of strings to search through for interlocks.
- `verbose::Bool=false`: If `true`, prints information about found interlocks during the search process.
- `saveToFile::Bool=true`: If `true`, saves the found interlocks to a CSV file. The saving occurs only if the array length is greater than 10,000 to prevent overwriting detailed data from a large dataset with results from a smaller test case.
- `filename::String="words"`: The base name for the output file when saving results. The full filename is constructed using the `processedDataFolder` and `extension`.
- `processedDataFolder::String="processedData/"`: The folder where the output file is saved.
- `extension::String=".csv"`: The file extension for the output file.

# Returns
- `DataFrame`: A DataFrame containing the found interlocks. Columns include: `ID`, `Word1`, `Word2`, `Interlock`, `Idx1` (index of `Word1`), `Idx2` (index of `Word2`), and `Idx12` (index of the interlocked word in the original array).

# Details
For each word in the array, the function splits it into two components: one containing characters at odd indices and one with characters at even indices. It then searches for these two components in the array. If both components are found, it considers them as interlocking words that form the original word.

# Notes
- The array `arr` must be sorted for the binary search (`inBisect`) to work correctly.
- The function uses a counter to assign a unique ID to each found interlock, which is included in the output DataFrame.
- Saving to a file is conditional on the array's size and the `saveToFile` flag, providing a safeguard against overwriting valuable data with results from smaller, possibly test, datasets.
"""
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