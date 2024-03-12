# dictionaries.jl

# moral of the story: Dictionaries are lightning fast when the corpus of words/numbers/mappings has already been created (and therefore, was finite in the first place), requires minimum changes, and a lot of lookups. Only tradeoff against arrays is the inital building time, which is trivial compared to lookup times (even comparing with binary search on sorted arrays)

include("setup.jl")

include("./arrays.jl") # for speed comparision with array implementations
include("./functions.jl")
include("./strings.jl")


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
    histogramViaDictionaries0(str::String) -> Dict{Char,Int64}

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
histogram = histogramViaDictionaries0("hello")

# Include uppercase characters in the histogram
histogram = histogramViaDictionaries0("Hello World!")
```
"""
function histogramViaDictionaries0(str::String)
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
Ex 11-1 from "Think Julia"

    histogramViaDictionaries(str::String) -> Dict{Char,Int64}

Generates a frequency histogram of letters in a given string using a dictionary. This approach is a streamlined version of the method presented in `histogramViaDictionaries0`, utilizing the `get` function for more concise code.

# Context
This function is an implementation of Exercise 11-1 in "Think Julia," where the goal is to create a histogram of characters in a string. Compared to `histogramViaDictionaries0`, this version simplifies the process of checking for the existence of a key in the dictionary and incrementing its value.

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
histogram = histogramViaDictionaries("hello")

# Create a histogram that includes uppercase characters
histogram = histogramViaDictionaries("Hello World!")
```
"""
function histogramViaDictionaries(str::String)
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
#     global hD1 = histogramViaDictionaries0(testString)
# end;

# @btime begin
    # global hD2 = histogramViaDictionaries(testString)
# end;

# hD2 = histogramViaDictionaries(testString);

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
histogram = histogramViaDictionaries("hello world")

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

function sortDictByKeys(h::Dict)
    ks = keys(h)
    ksSorted = sort!(collect(ks), rev=true) # collect 'collects' all keys in KeySet ks into a vector of type eltype(ks)
    N = length(ksSorted)
    arrVals = Vector()
    for i = 1:N
        # arrVals[i] = h[ksSorted[i]]
        push!(arrVals, sort!(h[ksSorted[i]]))
    end

    z = zip(ksSorted, arrVals)

    return z

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

# @test fib(50, fibMemo, verbose=false) == 12586269025
# @test fib(100, fibMemo) == 354224848179261915075

# Start from Ex 11-2
"""
Exercise 11-2 of Think Julia

    txt2Dict(filename::String="words.txt"; rawDataFolder::String="rawData/", extension::String=".txt", verbose::Bool=false) -> Dict{String, Int64}

Reads a text file and creates a dictionary from its contents. Each line of the file is treated as a unique key in the dictionary, with all values set to 1. This can be useful for quickly indexing or identifying the presence of words in a text file.

# Arguments
- `filename::String="words.txt"`: The name of the file to be processed. If no file extension is provided, the default extension (`.txt`) is appended.
- `rawDataFolder::String="rawData/"`: The directory path where the file is located.
- `extension::String=".txt"`: The file extension to be appended to `filename` if it's not already present.
- `verbose::Bool=false`: If `true`, prints additional information about the file processing, including extension additions.

# Returns
- `Dict{String, Int64}`: A dictionary where each key is a word from the file, and each value is set to 1.

# Notes
- The function assumes that each line of the file contains a single word. It does not perform any splitting or parsing of lines beyond treating each line as a separate word.
- The dictionary's values are fixed at 1, indicating the presence of words rather than counting their occurrences.
- If `verbose` is `true`, and the filename does not include an extension, a message is printed about appending the default `.txt` extension.

# Example
Assuming a file `words.txt` in `rawData/` directory with the content:
hello
world
The following call to `txt2Dict()`:
```julia
julia> txt2Dict()

```
"""
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

    for line ∈ eachline(fin)
        word = line
        words[word] = 1
    end

    return words
end

# Ex 11-2 from Think Julia
# Comparison between Dictionary lookup and Sorted List (using Binary Search) Lookup 
# begin
#     wordsDict = txt2Dict() # gets created slightly faster 7.9 ms

#     wordsList = listOfWords() # gets created slightly slower 10.5 ms

#     nList = length(wordsList)

#     word = wordsList[rand(1:nList)]
#     # word = "zygote" # is in the list of words
#     # word = "zaza" # isn't in the list of words

#     # @btime begin
#         inBisect(wordsList, word) # binary search takes abount 500 ns (sligthly variable)
#     # end

#     # @btime begin
#         word ∈ keys(wordsDict) # dict search takes about 40 ns (slightly variable)
#     # end

# end

# Ex 11-4 in ThinkJulia

# global ackWithMemo_calls = 0

"""
Ex 11-4 from "Think Julia"

    ackWithMemo(m::Int, n::Int, memo::Dict = Dict()) -> (Int, Dict)

Computes the Ackermann function, a classic example of a highly recursive mathematical function, with added memoization to improve performance by caching the results of previous computations.

# Arguments
- `m::Int`: The first parameter of the Ackermann function. Must be a non-negative integer.
- `n::Int`: The second parameter of the Ackermann function. Must be a non-negative integer.
- `memo::Dict`: (Optional) A dictionary used to memoize results of the Ackermann function to avoid redundant computations. Defaults to an empty dictionary.

# Returns
- `(Int, Dict)`: A tuple containing two elements:
    - The first element is the result of the Ackermann function for the given `m` and `n`.
    - The second element is the updated memoization dictionary containing all computed `(m, n)` pairs up to this point.

# Notes
- The Ackermann function is defined as follows:
    - `A(m, n) = n + 1` if `m = 0`
    - `A(m, n) = A(m - 1, 1)` if `m > 0` and `n = 0`
    - `A(m, n) = A(m - 1, A(m, n - 1))` if `m > 0` and `n > 0`
- Due to the highly recursive nature of the Ackermann function, memoization is used to store the results of function calls with specific `(m, n)` pairs. This significantly reduces the number of recursive calls needed, especially for inputs that would otherwise lead to many repeated calculations.
- This implementation automatically caches results of the Ackermann function in the `memo` dictionary, which can be passed to subsequent calls to further optimize performance.

# Warning
- The Ackermann function grows extremely rapidly. Even with memoization, computing `ackWithMemo` with large `m` and `n` can result in significant memory usage due to the large size of the memoization dictionary.

# Examples
```julia
# Compute the Ackermann function without memoization dictionary provided
result, memo = ackWithMemo(2, 3)

# Compute the Ackermann function with a pre-existing memoization dictionary
memo = Dict((0, 1) => 2)
result, updated_memo = ackWithMemo(2, 2, memo)
```
"""
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

# m = 3;
# # m = 3;
# # m = 4;
# n = 4;
# # n = 10;
# # n = 4
# # (3, 4) 35 mews, 100kB
# # (3, 10) 3 ms, 5MB
# # (4, 4) SO
# @btime AwithMemo, memo = ackWithMemo(m, n) 
# # (3, 4) 200 mews , 200kB
# # (3, 10) 1s, 1GB
# # (4, 4) SO
# @btime Awithout = ack(m, n) 

"""
Exercise 11-5 of Think Julia

    hasDuplicatesDict(arr; verbose = false) -> Bool

Efficiently determines whether a string or an array of characters contains any duplicate characters by using a dictionary to track occurrences. This method is highlighted for its efficiency in comparison to an array-based implementation, with the dictionary approach generally providing better performance due to the lower computational complexity of search and insertion operations.

# Arguments
- `arr`: A string or an array of characters to be checked for duplicates.
- `verbose::Bool=false`: If `true`, prints additional information about the process, including notification when a string argument is converted into a vector of characters.

# Returns
- `Bool`: Returns `true` if any duplicate characters are found; otherwise, returns `false`.

# Notes
- The function checks for duplicates by counting character occurrences with a dictionary, which typically allows for O(1) access time on average. This is more efficient than array-based methods, especially for large datasets.
- If the input is a string, it is automatically converted into a vector of characters to ensure uniform processing.
- This approach is significantly faster than the array-based method discussed in Exercise 10-7 of "Think Julia". Benchmarking results using `@btime` show this method to be quicker (e.g., 1 μs vs. 2 ms for a specific string), underlining the efficiency gains from utilizing a dictionary for occurrence tracking.

# Performance Comparison
- Compared to the array-based implementation in Exercise 10-7, this dictionary-based method is notably more efficient for detecting duplicates in strings or character arrays. The efficiency advantage is demonstrated through benchmarking, with `@btime` results indicating faster performance for the dictionary method.

# Example
```julia
julia> hasDuplicatesDict("bananarama")
# Output: true

julia> hasDuplicatesDict("qwertyuipasdfjklzxcvbn")
# Output: false
```
"""
function hasDuplicatesDict(arr; verbose = false)
    if isa(arr, String)
        myprint(verbose, "Argument is a String, converting into a Vector of chars.\n")
        arr = collect(arr)
    end
    counts = Dict()
    for char ∈ arr
        counts[char] = get(counts, char, 0) + 1
        if counts[char] > 1
            return true
        end
    end
    return false
end

# str = "bananarama"
# str = "qwertyuipasdfjklzxcvbn"
# @btime hasDuplicates(str) # 2 ms
# @btime hasDuplicatesDict(str) # 1 mews wow! 

# wordsList = listOfWords();

"""
    array2Dict(arr; verbose::Bool=false) -> Dict{String,Int64}

Transforms an array of strings into a dictionary, where each unique string in the array becomes a key, and the value for each key represents the number of times that string appears in the array.

# Arguments
- `arr`: An array of strings to be converted into a dictionary.
- `verbose::Bool=false`: If `true`, prints additional information about the process. Currently, this option does not alter the output but is included for future extensibility.

# Returns
- `Dict{String,Int64}`: A dictionary with keys representing unique strings from the array, and values indicating the frequency of each string.

# Notes
- The function efficiently tallies occurrences of each string, making it useful for counting and frequency analysis tasks.
- The implementation ensures that each string's count is accurately incremented, regardless of its initial absence or presence in the dictionary, using the `get` function with a default value of 0.

# Example
Given an array of strings `["apple", "banana", "apple", "cherry", "banana", "cherry", "cherry"]`, the function will return a dictionary:
```julia
{
    "apple" => 2,
    "banana" => 2,
    "cherry" => 3
}
```
"""
function array2Dict(arr;
    verbose::Bool=false)::Dict{String,Int64}

    words = Dict{String,Int64}()

    for word ∈ arr
        words[word] = 1 + get(words, word, 0)
    end

    return words
end

"""
Exercise 11-6 of Think Julia

    rotatePairs(wordsArr; verbose::Bool=false) -> Dict{String, Vector{Tuple{String, Int}}}

Finds and records all pairs of words from the given array where one word can be transformed into another by rotating its letters through the alphabet. Each word is rotated through all possible positions (1 to 25), and if a resulting rotation matches another word in the input array, this pair is recorded alongside the rotation degree.

# Arguments
- `wordsArr`: An array of words (strings) to be analyzed for rotational pairs.
- `verbose::Bool=false`: If set to `true`, the function provides verbose output during its execution, detailing each rotation process and found pairs.

# Returns
- A dictionary where each key is a word from the input array, and its value is a vector of tuples. Each tuple contains a word that can be formed by rotating the key word and the degree of rotation needed to do so. Only words that have at least one valid rotation pair are included as keys.

# Operation
- The function iterates over each word in the input array, then for each word, it rotates it through 1 to 25 positions. For each rotation, it checks if the rotated word exists in the original list of words.
- If a rotated word is found in the original list, a tuple consisting of the rotated word and the rotation degree is added to the vector associated with the original word in the result dictionary.
- Utilizes `get!` to efficiently handle the creation or update of vectors in the dictionary for each word, avoiding manual initialization checks.

# Notes
- The function is designed to work with lowercase words. Handling of uppercase or mixed-case words depends on the behavior of the `rotateWord` function.
- Non-alphabet characters in words are handled according to the `rotateWord` function's policy. The function's behavior with such characters is documented separately in `rotateWord`.

# Example
Consider an array of words `["abc", "def", "ghi"]`. If "abc" rotated by 1 position becomes "def", which is in the array, then "abc" will have an entry in the resulting dictionary:
```julia
rotatePairs(["abc", "def", "ghi"], verbose=true)
```
"""
function rotatePairs(wordsArr; 
    verbose::Bool=false)
    
    wordsDict = array2Dict(wordsArr);
    pairs = Dict{String,Vector{Tuple{String,Int}}}()

    for word ∈ keys(wordsDict)
        for rotation = 1:25 # Skipping 26 as it results in the original word
            rotatedWord = rotateWord(word, rotation, verbose=verbose)
            if haskey(wordsDict, rotatedWord)
                # Automatically get or create the vector, then push the new tuple
                push!(get!(pairs, word, Vector{Tuple{String,Int}}()), (rotatedWord, rotation))
                myprintln(verbose, "Processing rotation for word: $word with rotation $rotation resulting in $rotatedWord")
            end
        end
    end

    return pairs
end

# rotationPairs = rotatePairs(wordsList);
# @btime rotationPairs = rotatePairs(wordsList); # 500 ms # includes building of wordsDict from wordsList


filename = "cmudict-0point7b-1.txt";
# filename = "cmudict-0point7b.txt"
fileAddr = joinpath(rawDataDir, filename); # rawDataDir defined in setup.jl
firstWordIdx = 57; # first word (words and pronncitation combo) is at this index (manually checked)
cmudictList = readlines(fileAddr)[57:end];

"""
    createPronunciationDict(pronunciations::Vector{String}) -> Dict{String, String}

Constructs a dictionary from a vector of strings, where each string contains a word and its phonetic pronunciation from the CMU Pronouncing Dictionary. This function is tailored for processing entries starting from a specified line in the CMU dictionary file to skip headers or non-relevant content.

# Usage
This function is used after reading lines from the CMU dictionary file, where the file's path is constructed using `joinpath`, and only lines containing word-pronunciation pairs are considered by slicing the array from a manually identified starting index.

# Arguments
- `pronunciations::Vector{String}`: A vector containing strings, each comprising a word followed by its pronunciation, extracted from the CMU Pronouncing Dictionary.

# Returns
- `Dict{String, String}`: A dictionary with the cleaned-up word as the key and its pronunciation as the value. Special characters and annotations within the word are removed for consistency.

# Details
- The function splits each entry into two parts: the word and its pronunciation, using the `limit=2` argument in `split` to ensure only the first whitespace is used as a delimiter.
- Words are cleaned of any special characters (e.g., `{`, `}`, `'`, `(`, `)`, digits) that might be part of pronunciation annotations or denote special entries in the dictionary, ensuring that the dictionary keys consist only of the core word text.
- The resulting dictionary maps cleaned words to their corresponding pronunciations, facilitating easy access to pronunciation information by word.

# Example
Given a file `cmudict-0.7b` containing CMU dictionary entries, after preprocessing to exclude non-word entries:

```julia
filename = "cmudict-0.7b"
rawDataDir = "path/to/rawData"
fileAddr = joinpath(rawDataDir, filename)
cmudictList = readlines(fileAddr)[57:end]  # Skipping header lines

cmudictDict = createPronunciationDict(cmudictList)
```
"""
function createPronunciationDict(pronunciations::Vector{String})
    dict = Dict{String,String}()
    for entry in pronunciations
        # Split the entry into word and pronunciation parts
        parts = split(entry, limit=2)
        word = parts[1]
        pronunciation = parts[2]

        # Clean up the word (remove special characters and annotations)
        clean_word = replace(word, r"[{}()'0-9]" => "")

        # Insert into the dictionary
        dict[clean_word] = pronunciation
    end
    return dict
end

# cmudictDict = createPronunciationDict(cmudictList);

"""
    isAscii(s::String) -> Bool

Determines if a string is composed entirely of ASCII characters, which are those in the range of 0 to 127. This includes standard English letters, digits, and certain punctuation marks.

# Arguments
- `s::String`: The string to be checked.

# Returns
- `Bool`: Returns `true` if every character in the string is an ASCII character, `false` otherwise.

# Notes
- This function is particularly useful for ensuring that a string meets ASCII-only requirements before undergoing processing that may not support non-ASCII characters.
- ASCII character validation is commonly required when interfacing with systems or protocols that are ASCII-specific.

# Example
- To verify that the string "Hello, World!" consists only of ASCII characters:
```julia
isAscii("Hello, World!") # Expected output: true
```
"""
function isAscii(s::String)
    all(isascii, s)
end

"""
Exercise 11-7 of Think Julia

    findUniqueWords(d::Dict; verbose::Bool = false) -> Vector{String}

Searches through a dictionary for unique words that are homophones of both words derived by removing their first or second letter. This function addresses a CarTalk Puzzle, which likely refers to words like "SCENT," a homophone of "CENT" and "SENT".

# Arguments
- `d::Dict`: A dictionary with each key as a word and the associated value as its phonetic transcription or other comparable data.
- `verbose::Bool=false`: Enables informative output during the function's execution.

# Returns
- `Vector{String}`: A list of words that are homophones with both derivations after removing either the first or second letter.

# Notes
- The function skips words that are two characters or shorter and words containing non-ASCII characters to avoid processing anomalies like "D�J�".
- It checks each word against two derivations: `word1` with the first letter removed and `word2` with the second letter removed.
- For inclusion in the output list, the original word must be a homophone of both `word1` and `word2`, indicated by equality of dictionary values.
- The search is limited by the completeness and accuracy of the dictionary provided.
- Trivial words or those not commonly recognized as single-syllable homophones are also identified but may not align with the puzzle's intended scope.

# Example
Given a dictionary `d` that includes words "scent", "cent", and "sent" with the same phonetic transcription "sɛnt":
```julia
d = Dict("scent" => "sɛnt", "cent" => "sɛnt", "sent" => "sɛnt")
uniqueWordsList = findUniqueWords(d, verbose=true)
```
"""
function findUniqueWords(d::Dict;
    verbose::Bool = false)

    list = Vector{String}()

    for word ∈ keys(d)
        # println(word)
        if length(word) <= 2 || !isAscii(word)
            # The second condition was added to avoid weird words like D�J� which don't behave as expected for me.
            continue;
        else
            word1 = word[2:end] # first letter removed
            # try

            word2 = word[1]*word[3:end] # second letter removed
            if haskey(d, word1) && haskey(d, word2) && d[word] == d[word1] && d[word] == d[word2]
                push!(list, word)
                myprintln(verbose, "Found one Word $(word) is a homophone of both words made by removing its first OR second letter!")
            end
        end 
    end

    return list

    # the authors of this CarTalk Puzzle probably had the word "SCENT" (a monosyllable word which is a homophone of  "CENT" and "SENT", which have been derived by removing the first and second letter from it, respectively) in mind.
    # Other 'trivial' words I can see obeying these criteria in the list are "AAH", "AARGH", "LLANES", "LLOYD", "OOOH", although none of these are what I'd think of when thinking of 'words'.

end

# uniqueWordsList = findUniqueWords(cmudictDict);