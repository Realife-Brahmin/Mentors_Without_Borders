# dictionaries.jl
include("./HelperFunctions.jl");

using BenchmarkTools
using Test

"""
    histogramViaVectors(str::String) -> Vector{Int64}

Generates a histogram of the letters in a given string, assuming a lowercase English alphabet.

# Arguments
- `str::String`: The input string from which to generate the histogram. The function is case-insensitive but only considers lowercase English letters ('a' to 'z').

# Returns
- A 26-element vector of `Int64`, where each index corresponds to a letter in the English alphabet ('a' = 1, 'b' = 2, ..., 'z' = 26) and the value at each index represents the count of that letter in the input string.

# Notes
- The function converts each character in the input string to lowercase before processing to ensure case-insensitivity.
- Non-alphabetic characters are ignored, and only occurrences of English alphabetic characters are counted.
- The ASCII value of 'a' is 97. Therefore, the calculation `Int(lowercase(str[i]))-96` maps 'a' to 1, 'b' to 2, ..., 'z' to 26.

# Examples
```julia
# Generate a histogram for a simple string
histogram = histogramViaVectors("hello")

# Generate a histogram including uppercase characters
histogram = histogramViaVectors("Hello World")
```
"""
function histogramViaVectors(str::String)
    h = zeros(Int64, 26)
    N = length(str)
    for i = 1:N
        h[Int(lowercase(str[i]))-96] += 1
    end
    return h
end

"""
    histogramViaDictionaries1(str::String) -> Dict{Char,Int64}

Creates a frequency histogram of the letters in a given string using a dictionary, accounting for lowercase English letters only.

# Arguments
- `str::String`: The input string from which to generate the histogram. The function processes the string case-insensitively.

# Returns
- A dictionary of type `Dict{Char,Int64}` where each key is a lowercase letter from the English alphabet, and the corresponding value is the count of that letter in the input string.

# Notes
- The function converts each character to lowercase before counting to ensure case-insensitivity.
- Non-alphabetic characters are ignored; the histogram includes only occurrences of English alphabetic characters ('a' to 'z').
- This approach allows for dynamic key insertion into the dictionary, with each key being a character from the string and its value being the occurrence count. This is useful for strings with a diverse set of characters and for efficiently handling large datasets where the exact character set might not be known in advance.

# Examples
```julia
# Create a histogram for a simple string
histogram = histogramViaDictionaries1("hello")

# Include uppercase characters in the histogram
histogram = histogramViaDictionaries1("Hello World!")
```
"""
function histogramViaDictionaries1(str::String)
    h = Dict{Char,Int64}()
    N = length(str)
    for i = 1:N
        letter = lowercase(str[i])
        if letter ∈ keys(h)
            h[letter] += 1
        else
            h[letter] = 1
        end
    end
    return h
end

"""
    histogramViaDictionaries2(str::String) -> Dict{Char,Int64}

Ex 11-1 from "Think Julia"

Generates a frequency histogram of letters in a given string using a dictionary. This approach is a streamlined version of the method presented in `histogramViaDictionaries1`, utilizing the `get` function for more concise code.

# Context
This function is an implementation of Exercise 11-1 in "Think Julia," where the goal is to create a histogram of characters in a string. Compared to `histogramViaDictionaries1`, this version simplifies the process of checking for the existence of a key in the dictionary and incrementing its value.

# Arguments
- `str::String`: The input string from which to generate the histogram. The function is case-insensitive, focusing solely on lowercase English letters.

# Returns
- A `Dict{Char,Int64}` where each key represents a lowercase letter found in the input string, and the corresponding value is the count of that letter.

# Notes
- Utilizes the `get` function to streamline the retrieval and incrementing of character counts, reducing the need for explicit key existence checks.
- As with the previous function, this method ensures case-insensitivity by converting all input characters to lowercase before processing.
- Non-alphabetic characters are ignored, with the histogram focusing on occurrences of English alphabetic characters ('a' to 'z').

# Examples
```julia
# Create a histogram from a simple string
histogram = histogramViaDictionaries2("hello")

# Create a histogram that includes uppercase characters
histogram = histogramViaDictionaries2("Hello World!")
```
"""
function histogramViaDictionaries2(str::String)
    h = Dict{Char,Int64}()
    N = length(str)
    for i = 1:N
        letter = lowercase(str[i])
        h[letter] = get(h, letter, 0) + 1
    end
    return h
end

testString = "pZbXvJUxqQKdYrMzVcsgaAeBnOhLjRkDyFmCwTtGpIuHlSfNiWvEoX";
@btime begin
    global hV = histogramViaVectors(testString)
end;
@btime begin
    global hD1 = histogramViaDictionaries1(testString)
end;

@btime begin
    global hD2 = histogramViaDictionaries2(testString)
end;

"""
    printhist(h::Dict)

Prints the contents of a histogram (or any dictionary) to the console, displaying each key-value pair on a new line.

# Arguments
- `h::Dict`: A dictionary whose keys are characters (or potentially any type that can be converted to a string) and whose values are the counts or any associated value that can be represented as an integer or string.

# Behavior
- Iterates through each key in the dictionary, printing the key followed by its associated value on separate lines. The function assumes that both the keys and values can be meaningfully represented as strings, making it suitable for printing histograms or similar key-value data structures.

# Notes
- This function does not return a value; its sole purpose is to output the dictionary's contents to the console in a readable format.
- While designed with character histograms in mind, `printhist` is generic enough to be used with any dictionary for debugging or display purposes, provided the dictionary's contents are suitable for textual representation.

# Examples
```julia
# Create a histogram from a string
histogram = histogramViaDictionaries2("hello world")

# Print the histogram
printhist(histogram)
```
"""
function printhist(h)
    for c in keys(h)
        println(c, " ", h[c])
    end
end

"""
    printDictSorted(h::Dict; returnType::String="printOnly")

Sorts a dictionary by its keys and can either print the sorted dictionary, return the sorted values, or both.

# Arguments
- `h`: The dictionary to be sorted. Assumes keys of type `Char` and values of type `Int64`.
- `returnType`: Optional. Controls the behavior of the function with respect to its output:
    - `"printOnly"` (default): Prints the sorted dictionary using the `printDict2Matrix` function but does not return a value.
    - `"valuesOnly"`: Returns a matrix where the first column contains the sorted keys and the second column contains the corresponding values.
    - `"valuesAndPrint"`: Both prints the sorted dictionary and returns the matrix as described in `"valuesOnly"`.
    - Any other string results in an error with the message "Undefined return type."

# Returns
- Depending on `returnType`, this function may return a 2-column matrix of sorted keys and their corresponding values, or nothing if it only prints the sorted dictionary.

# Notes
- The function assumes that all keys in the dictionary are of type `Char` and all values are of type `Int64`.
- This function relies on `printDict2Matrix` for printing, which must be implemented to use the printing features.

# Examples
```julia
# Create a dictionary
dict_example = Dict('a' => 1, 'c' => 3, 'b' => 2)

# Print the sorted dictionary
printDictSorted(dict_example)

# Get the sorted dictionary as a matrix
sorted_matrix = printDictSorted(dict_example, returnType="valuesOnly")

# Print and return the sorted dictionary
sorted_matrix = printDictSorted(dict_example, returnType="valuesAndPrint")
```
"""
function printDictSorted(h::Dict; returnType::String="printOnly")
    N = length(h)
    arrChar = fill(Char(0), N)
    arrNum = zeros(Int64, N)
    keysInserted = 0
    for c in keys(h)
        keysInserted += 1
        arrChar[keysInserted] = c
        arrNum[keysInserted] = h[c]
    end
    perm_indices = sortperm(arrChar)
    arrCharSorted = arrChar[perm_indices]
    arrNumSorted = arrNum[perm_indices]
    hmat = hcat(arrCharSorted, arrNumSorted)

    if returnType == "printOnly"
        printDict2Matrix(hmat)
    elseif returnType == "valuesOnly"
        return hmat
    elseif returnType == "valuesAndPrint"
        printDict2Matrix(hmat)
        return hmat
    else
        error("Undefined return type.")
    end
end

function printDict2Matrix(a::Union{Dict,Matrix})
    if a isa Dict
        a = printDictSorted(a, returnType="valuesOnly")
    end
    N = size(a, 1)
    for i = 1:N
        println(a[i, 1], " ", a[i, 2])
    end
end



function printDictSorted2(h::Dict; returnType::String="printOnly")
    ks = keys(h)
    ksSorted = sort!(collect(ks)) # collect 'collects' all keys in KeySet ks into a vector of type eltype(ks)
    N = length(ksSorted)
    arrNum = zeros(Int64, N)
    for i = 1:N
        arrNum[i] = h[ksSorted[i]]
    end
    hmat = hcat(ksSorted, arrNum)

    if returnType == "printOnly"
        printDict2Matrix(hmat)
    elseif returnType == "valuesOnly"
        return hmat
    elseif returnType == "valuesAndPrint"
        printDict2Matrix(hmat)
        return hmat
    else
        error("Undefined return type.")
    end

end

# printhist(hD2)

@btime global d2Mat1 = printDictSorted(hD2, returnType="valuesOnly");

@btime global d2Mat2 = printDictSorted2(hD2, returnType="valuesOnly");

"""
    reverseLookup(d::Dict, v)

Performs a reverse lookup by searching for all keys in the dictionary `d` that have the value `v`.

# Arguments
- `d::Dict`: The dictionary to search through. Can have keys and values of any type.
- `v`: The value to search for among the dictionary's values.

# Returns
- A vector containing all keys that match the given value `v`. If no matching keys are found, a warning is emitted, and an empty vector is returned.

# Notes
- The function iterates over all keys in the dictionary, comparing each key's associated value with `v`.
- If multiple keys have the same value `v`, all such keys are included in the returned vector.
- If no keys with the value `v` are found, the function warns about the absence of matching keys but still returns an empty vector gracefully.

# Examples
```julia
# Create a dictionary
dict_example = Dict("a" => 1, "b" => 2, "c" => 1)

# Perform a reverse lookup to find keys with the value 1
keys_with_value_1 = reverseLookup(dict_example, 1)

# Perform a reverse lookup for a value that doesn't exist
keys_with_nonexistent_value = reverseLookup(dict_example, 3)
"""
function reverseLookup(d::Dict, v)
    ks = keys(d)
    arr = Vector()
    validKeys = 0
    for c ∈ ks
        if d[c] == v
            push!(arr, c)
        end
    end
    if length(arr) == 0
        @warn "No key matching that value found"
    end
    return arr
end

@btime reverseLookup(hD2, 3);
@btime findall(x -> x == 3, hD2);

function invertDict0(d)
    inverse = Dict()
    for key in keys(d)
        val = d[key]
        if val ∉ keys(inverse)
            inverse[val] = [key]
        else
            push!(inverse[val], key)
        end
    end
    inverse
end

function invertDict(d::Dict{Tk,Tv}) where {Tk,Tv}
    ks = keys(d)
    vs = values(d)
    dinv = Dict{Tv,Vector{Tk}}()
    for k ∈ ks
        v = d[k]
        dinv[v] = push!(get(dinv, v, Vector{Tk}()), k)
    end
    return dinv
end


@btime global hD2inv1 = invertDict0(hD2);
@btime global hD2inv = invertDict(hD2);

function fib(x::Int64, fibMemo::Dict{Int64,Int128}=Dict(0 => 0, 1 => 1);
    verbose::Bool=false)
    myprintln(verbose, "Checking for presence of $(x) in memory.")
    # myprintln(verbose, "Current Dictionary: $(fibMemo)") 
    #= To highlight that fibMemo is indeed has a 'global' scope within the 
    fib function =#
    if x ∈ keys(fibMemo)
        myprintln(verbose, "$(x) is indeed memoized, returning its value.")
        return fibMemo[x]
    else
        myprintln(verbose, "$(x) not memoized, going into $(x-1) and $(x-2).")
        fibMemo[x] = fib(x - 1, fibMemo, verbose=verbose) + fib(x - 2, fibMemo, verbose=verbose)
    end
end
fibMemo = Dict{Int64,Int128}(0 => 0, 1 => 1);  # Clearing the memoization cache

@test fib(50, fibMemo, verbose=false) == 12586269025
@test fib(100, fibMemo) == 354224848179261915075

# Start from Ex 11-2