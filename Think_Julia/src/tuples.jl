# tuples.jl


include("setup.jl");

include("./arrays.jl"); # for speed comparision with array implementations
include("./dictionaries.jl");
include("./functions.jl");
include("./strings.jl");

function printall(args...) ## ... gathers arguments into a tuple
    println(args)
end

# Exercise 12-1 in Think Julia
"""
Exercise 12-1 in Think Julia

    sumall(args::Number...) -> Number

Calculates the sum of all arguments provided to the function. This variadic function accepts any number of numeric arguments and returns their sum.

# Arguments
- `args::Number...`: A comma-separated list of numbers.

# Returns
- The sum of the arguments as a `Number`.

# Notes
- This function can be particularly useful when the number of arguments is not known in advance, and you need a quick way to obtain their sum.
- The implementation uses Julia's built-in `sum` function, taking advantage of its efficient handling of arithmetic operations on numeric types.
- Variadic arguments in Julia are denoted by the ellipsis `...`, which allows the function to accept any number of arguments.

# Example
- To sum the numbers 1 through 5:
```julia
sumall(1, 2, 3, 4, 5)  # Expected output: 15
```
"""
function sumall(args::Number ...)
    sum(args)
end

function mostFrequent(str::String)

    hist = histogramViaDictionaries(str)

    charDict = Dict{Int, Vector{Char}}()
    for (letter, value) in hist
        @show letter, value
        if !haskey(charDict, value)
            charDict[value] = [letter]
        else
            charDict[value] = push!(charDict[value], letter)
        end
    end
    return charDict
end


str = "helloAryan";
str = "QJLGqKRkGTBwfbGCnLsiZxAmwTGJEUcQZHoMUCXhyDAcrZRUGiOngXhEmPoccekrgGqWIPaFhIeErjMBTFSXKCNjHgbmhFAqLqqP"
str = lowercase(str)
hist = histogramViaDictionaries(str);
charDict = invertDict(hist);
freq2charDict = sortDictByKeys(charDict);

"""
    displayZip(z)

Iterates over a `zip` object or any iterable collection of pairs and prints each pair on a separate line, formatting them as `key -- value`.

# Arguments
- `z`: An iterable collection, typically a `zip` object, containing pairs of elements. Each pair is expected to be a tuple or any 2-element collection where the first element represents a key and the second element represents a value.

# Operation
- The function loops through each pair in the provided iterable, extracting the first and second elements of each pair.
- It prints each pair in the format "key -- value", where `key` and `value` are placeholders for the actual contents of each pair.

# Example
To display key-value pairs from a sorted dictionary:
```julia
h = Dict("apple" => 3, "banana" => 2, "cherry" => 1)
sortedPairs = sortDictByKeys(h)  # Assuming this function sorts `h` and returns a `zip` object
displayZip(sortedPairs)
```
This would print:
```julia
banana -- 2
apple -- 3
cherry -- 1
```
"""
function displayZip(z)
    for (z1, z2) in z
        println("$(z1) -- $(z2)")
    end
end

displayZip(freq2charDict)