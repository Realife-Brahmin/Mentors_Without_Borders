# dictionaries.jl
include("setup.jl")
include("./HelperFunctions.jl");
include("./functions.jl")
include("./arrays.jl") # for speed comparision with array implementations

# using BenchmarkTools
# using Test

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
# @btime begin
#     global hV = histogramViaVectors(testString)
# end;
# @btime begin
#     global hD1 = histogramViaDictionaries1(testString)
# end;

# @btime begin
    # global hD2 = histogramViaDictionaries2(testString)
# end;

hD2 = histogramViaDictionaries2(testString);

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

Sorts a dictionary by its keys and optionally prints the sorted dictionary or returns the sorted values. This function can directly print the sorted dictionary, return a matrix of sorted key-value pairs, or do both based on the `returnType` parameter.

# Arguments
- `h`: Dictionary to be sorted and processed.
- `returnType`: Determines the function's output behavior. Options are:
    - `"printOnly"`: Sorts and prints the dictionary without returning.
    - `"valuesOnly"`: Returns the sorted dictionary as a matrix.
    - `"valuesAndPrint"`: Prints and returns the sorted dictionary.
    - Other values will raise an "Undefined return type." error.

# Returns
- Depending on `returnType`, may return a matrix of sorted key-value pairs or nothing.

# Usage
```julia
dict_example = Dict('a' => 1, 'b' => 2, 'c' => 3)
printDictSorted(dict_example) # Default printOnly
sorted_matrix = printDictSorted(dict_example, returnType="valuesOnly") # Return matrix
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

"""
	printDict2Matrix(a::Union{Dict,Matrix})

Prints the contents of either a dictionary or a matrix in a standardized two-column format. For dictionaries, it first sorts the dictionary by keys, then prints each key-value pair on a new line. For matrices, it directly prints each row assuming each row represents a key-value pair.

# Arguments
-	`a`: The input can be either a `Dict` or a `Matrix`. If a `Dict` is provided, it is first sorted using `printDictSorted` with `returnType="valuesOnly"` to convert it into a matrix format.

# Behavior
-	If `a` is a `Dict`, it is converted into a matrix where the first column represents sorted keys and the second column represents their corresponding values.
-	Iterates through each row of the matrix (or the converted dictionary) and prints the elements of the first two columns, separated by a space.

# Usage
```julia
# Create a dictionary and print it
dict_example = Dict('a' => 1, 'b' => 2, 'c' => 3)
printDict2Matrix(dict_example)

# Create a matrix and print it
matrix_example = [1 2; 3 4; 5 6]
printDict2Matrix(matrix_example)
```
"""
function printDict2Matrix(a::Union{Dict,Matrix})
    if a isa Dict
        a = printDictSorted(a, returnType="valuesOnly")
    end
    N = size(a, 1)
    for i = 1:N
        println(a[i, 1], " ", a[i, 2])
    end
end


"""
	printDictSorted2(h::Dict; returnType::String="printOnly")

Sorts a dictionary by its keys and processes it according to the specified `returnType`. This version uses `sort!` on a collected list of dictionary keys for sorting, then pairs each sorted key with its corresponding value to form a matrix. Depending on `returnType`, it can print this matrix, return it, or both.

# Arguments
- `h`: Dictionary to be sorted and processed. Keys can be of any type that is sortable.
- `returnType`: Specifies how to handle the sorted dictionary. Options include:
	- "printOnly": Only prints the sorted dictionary, does not return it.
	- "valuesOnly": Returns the sorted key-value pairs as a matrix.
	- "valuesAndPrint": Prints the sorted dictionary and returns the key-value pairs as a matrix.
	- Other values trigger an "Undefined return type." error.

# Returns
- Based on `returnType`, this function may return a 2-column matrix where the first column contains sorted keys and the second column contains their corresponding values, or it may not return anything if it only prints.

# Behavior
- Keys are collected and sorted. The sorted keys are then used to create a matrix paired with their corresponding values.
- The function demonstrates flexibility in output handling, supporting different operational modes through the `returnType` parameter.

# Usage
```julia
dict_example = Dict('a' => 1, 'b' => 2, 'c' => 3)

# To simply print the sorted dictionary
printDictSorted2(dict_example)

# To get the sorted dictionary as a matrix
sorted_matrix = printDictSorted2(dict_example, returnType="valuesOnly")

# To print and also return the sorted dictionary as a matrix
sorted_matrix = printDictSorted2(dict_example, returnType="valuesAndPrint")
```
"""
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

# @btime global d2Mat1 = printDictSorted(hD2, returnType="valuesOnly");

# @btime global d2Mat2 = printDictSorted2(hD2, returnType="valuesOnly");

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
```
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

# @btime reverseLookup(hD2, 3);
# @btime findall(x -> x == 3, hD2);

"""
    invertDict0(d)

Inverts a dictionary `d`, transforming it from a mapping of keys to values into a mapping of values to lists of keys. This generic version does not specify type parameters for the dictionary, making it flexible for use with dictionaries containing various types of keys and values.

# Arguments
- `d`: The original dictionary to be inverted.

# Returns
- A new dictionary where each value from the original dictionary becomes a key, and the corresponding value is a list (vector) of keys from the original dictionary that mapped to that value.

# Behavior
- Iterates over each key-value pair in the original dictionary.
- Checks if the value already exists as a key in the inverted dictionary. If not, initializes a new list (vector) with the current key. If the value does exist, appends the current key to the existing list.
- This method does not require the use of the `get` function to simplify existence checks or vector initialization, unlike `invertDict`, and directly checks for key existence in the inverted dictionary.

# Usage
```julia
original_dict = Dict(1 => "a", 2 => "b", 3 => "a")
inverted_dict = invertDict0(original_dict)
# inverted_dict will be Dict("a" => [1, 3], "b" => [2])
```
"""
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

"""
    invertDict(d::Dict{Tk,Tv}) where {Tk,Tv}

Ex 11-3 from "Think Julia"

Inverts a dictionary, transforming it from a mapping of keys to values into a mapping of values to lists of keys. This is useful for cases where you want to find all keys that share the same value.

# Arguments
- `d`: The original dictionary of type `Dict{Tk,Tv}` to be inverted. `Tk` represents the type of the keys, and `Tv` represents the type of the values.

# Returns
- A new dictionary of type `Dict{Tv,Vector{Tk}}` where each value from the original dictionary becomes a key in the new dictionary. The corresponding value in the new dictionary is a vector of keys from the original dictionary that mapped to that value.

# Behavior
- Iterates through each key-value pair in the original dictionary.
- For each pair, the function checks if the value already exists as a key in the inverted dictionary. If it does, the current key is appended to the list of keys for that value. If it does not, a new entry is created in the inverted dictionary with the value as the key and a vector containing the current key.
- Utilizes the `get` function to simplify the process of checking for existence and initializing vectors as needed.

# Usage
```julia
original_dict = Dict("a" => 1, "b" => 2, "c" => 1)
inverted_dict = invertDict(original_dict)
# inverted_dict will be Dict(1 => ["a", "c"], 2 => ["b"])
```
"""
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


# @btime global hD2inv1 = invertDict0(hD2);
# @btime global hD2inv = invertDict(hD2);

"""
    fib(x::Int64, fibMemo::Dict{Int64,Int128}=Dict(0 => 0, 1 => 1); verbose::Bool=false)

Calculates the Fibonacci number for a given index `x` using memoization to optimize recursive calls. The function stores previously calculated Fibonacci numbers in `fibMemo` to avoid redundant calculations. An optional `verbose` mode can be enabled to log the function's progress.

# Arguments
- `x`: The index in the Fibonacci sequence for which the value is sought. Must be of type `Int64`.
- `fibMemo`: An optional memoization dictionary of type `Dict{Int64,Int128}` pre-initialized with the first two Fibonacci numbers. Defaults to `Dict(0 => 0, 1 => 1)`.
- `verbose`: An optional boolean flag that, when set to `true`, enables detailed logging of the function's execution process.

# Returns
- The Fibonacci number at index `x`.

# Behavior
- Checks if the value of `x` is already present in `fibMemo` to return the memoized result, minimizing the number of recursive calls.
- If `x` is not in `fibMemo`, recursively calculates `fib(x - 1, fibMemo)` and `fib(x - 2, fibMemo)`, adds their values, memoizes this result, and returns it.
- Optionally prints detailed logs of its execution steps if `verbose` is `true`.

# Usage
```julia
# Calculate the 10th Fibonacci number with verbose logging
fib(10, verbose=true)

# Calculate the 20th Fibonacci number without logging
fib(20)
```
"""
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

function txt2Dict(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool=false)::Dict{String, Int64}
    if !contains(filename, ".")
        myprint(
            verbose,
            "filename does not have extension embedded.\n
adding extension $extension at its end.\n"
        )
        filename = filename * extension
    end
    fin = open(rawDataFolder * filename)

    words = Dict{String,Int64}()

    # words = Dict()

    for line ∈ eachline(fin)
        word = line
        words[word] = 1
    end

    return words
end

# Ex 11-2 from Think Julia
# Comparison between Dictionary lookup and Sorted List (using Binary Search) Lookup 
begin
    wordsDict = txt2Dict() # gets created slightly faster 7.9 ms

    wordsList = listOfWords() # gets created slightly slower 10.5 ms

    nList = length(wordsList)

    word = wordsList[rand(1:nList)]
    # word = "zygote" # is in the list of words
    # word = "zaza" # isn't in the list of words

    @btime begin
        inBisect(wordsList, word) # binary search takes abount 500 ns (sligthly variable)
    end

    @btime begin
        word ∈ keys(wordsDict) # dict search takes about 40 ns (slightly variable)
    end

end

# Ex 11-4 in ThinkJulia

# global ackWithMemo_calls = 0

function ackWithMemo(m, n, memo=Dict())

    # global ackWithMemo_calls += 1
    if (m, n) ∈ keys(memo)
        A = memo[(m, n)]
    else
        if m == 0
            A = n + 1
            memo[(0, n)] = A
        elseif m > 0 && n == 0
            A, memo = ackWithMemo(m - 1, 1, memo)
        elseif m > 0 && n > 0
            arg2, memo = ackWithMemo(m, n - 1, memo)
            A, memo = ackWithMemo(m - 1, arg2, memo)
        else
            @error "floc"
        end
    end

    memo[(m, n)] = A
    return A, memo
end

m = 3;
# m = 3;
# m = 4;
n = 4;
# n = 10;
# n = 4
# (3, 4) 35 mews, 100kB
# (3, 10) 3 ms, 5MB
# (4, 4) SO
@btime AwithMemo, memo = ackWithMemo(m, n) 
# (3, 4) 200 mews , 200kB
# (3, 10) 1s, 1GB
# (4, 4) SO
@btime Awithout = ack(m, n) 
# still blew up for (4, 4)
