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

# function mostFrequent(str::String)

#     hist = histogramViaDictionaries(str)

#     charDict = Dict{Int, Vector{Char}}()
#     for (letter, value) in hist
#         if !haskey(charDict, value)
#             charDict[value] = [letter]
#         else
#             charDict[value] = push!(charDict[value], letter)
#         end
#     end
#     return charDict
# end

function readParagraphs(filename::String)
    open(filename, "r") do file
        paragraphs = Vector{String}()
        current_paragraph = ""
        for line in eachline(file)
            if isempty(strip(line))  # Check for an empty line
                if !isempty(current_paragraph)
                    push!(paragraphs, current_paragraph)
                    current_paragraph = ""
                end
            else
                current_paragraph *= (isempty(current_paragraph) ? "" : " ") * line
            end
        end
        # Check if the last paragraph needs to be added
        if !isempty(current_paragraph)
            push!(paragraphs, current_paragraph)
        end
        return paragraphs
    end
end

function paragraphsToString(paragraphs::Vector{String}, 
    delimiter::String="\n\n")
    
    return join(paragraphs, delimiter)

end

filename = "exampleText.txt"
fileAddr = joinpath(rawDataDir, filename)
paras = readParagraphs(fileAddr)
paraString = paragraphsToString(paras)
str = lowercase(paraString)

"""
Exercise 12-2 of Think Julia

    mostFrequent(str::String; output::String = "printOnly", verbose::Bool = false)

Analyzes a string to find the most frequent characters and their frequencies, allowing for different modes of output based on the `output` parameter.

# Arguments
- `str::String`: The input string to analyze for character frequencies.
- `output::String="printOnly"`: Controls the function's output behavior. Options are:
    - `"printOnly"`: The function will only print the sorted frequency data.
    - `"returnOnly"`: The function returns the sorted frequency data without printing.
    - `"printAndReturn"`: The function prints and returns the sorted frequency data.
- `verbose::Bool=false`: If set to `true`, enables verbose output for additional insights during execution.

# Returns
- Depends on the `output` parameter. If `"returnOnly"` or `"printAndReturn"` is specified, it returns a `zip` object containing tuples of frequencies and characters sorted by frequency in descending order. Otherwise, it doesn't return a value.

# Notes
- The function comprises three main steps: generating a character frequency histogram from the input string, inverting this histogram to map frequencies to characters, and sorting this mapping by frequency in descending order.
- Utilizes `myprintln` for conditional verbosity to provide step-by-step insights when `verbose` is `true`.
- It's crucial to have `histogramViaDictionaries`, `invertDict`, and `sortDictByKeys` functions correctly implemented for `mostFrequent` to work as intended.

# Example
Analyze the string "hello world", with verbosity enabled, and print the frequency data:
```julia
mostFrequent("hello world", output="printOnly", verbose=true)
```

## TODO:
- Make adjustments so that only letters are counted, and not whitespaces, numbers, commas, etc.
- Add a feature of returning percentages instead of absolute numbers (total instances only counting letters)
- Perhaps, there's a better way of displaying the percentages, like maybe a nice in-terminal bar graph?

"""
function mostFrequent(str::String;
    output::String = "printOnly", 
    verbose::Bool=false)

    # Step 1: Generate histogram of character frequencies
    hist = histogramViaDictionaries(str)
    myprintln(verbose, "Histogram generated.")

    # Step 2: Invert the histogram dictionary
    charDict = invertDict(hist)
    myprintln(verbose, "Dictionary inverted.")

    # Step 3: Sort the inverted dictionary by frequencies (keys) in descending order
    freq2CharZip = sortDictByKeys(charDict; rev=true)
    myprintln(verbose, "Dictionary sorted by keys in descending order.")

    if output == "printOnly"
        displayZip(freq2CharZip)
    elseif output == "returnOnly"
        return freq2CharZip
    elseif output == "printAndReturn"
        displayZip(freq2CharZip)
        return freq2CharZip
    else
        @error "floc"
    end

end

freq2CharDict = mostFrequent(str, output="printAndReturn");

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

displayZip(freq2CharDict)