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

freq2CharDict = mostFrequent(str, output="returnOnly");

# displayZip(freq2CharDict)

"""
Exercise 12-3 of Think Julia

    anagramsViaDict(filename::String="words.txt"; 
                    rawDataFolder::String="rawData/",
                    extension::String=".txt",
                    indexBy::String="Number of Anagrams",
                    saveSingleInstances::Bool=false,
                    orderSets::Bool=true,
                    printResult::Bool=true,
                    verbose::Bool=false) -> Union{Dict, Vector}

Analyzes a word list from a file to identify sets of anagrams, printing them or organizing them based on specified criteria. This function supports sorting anagrams by the number of anagrams in a set or by word length, and can print or return the organized sets. It fulfills Exercise 12-3 from "Think Julia", which focuses on identifying, sorting, and printing anagrams.

# Arguments
- `filename::String`: The name of the file containing the word list, defaulting to "words.txt".
- `rawDataFolder::String`: The directory path to the raw data folder, defaulting to "rawData/".
- `extension::String`: The file extension, defaulting to ".txt".
- `indexBy::String`: Determines the sorting criteria of the anagram sets, options are "Number of Anagrams" or "Length of Word".
- `saveSingleInstances::Bool`: If `false`, single-instance 'anagrams' are excluded from the result.
- `orderSets::Bool`: If `true`, organizes anagram sets by the specified indexing criterion.
- `printResult::Bool`: Controls whether notable anagram sets in perspective of the 'Think Julia' questions are printed.
- `verbose::Bool`: Enables detailed logs of the function's execution process.

# Returns
- Depending on `orderSets`, returns either a dictionary mapping base words to tuples of anagram count and anagram list (`Dict`) or a vector of vectors organized according to `indexBy` criteria (`Vector`).

# Notes
- Implements a multi-step process including reading the word list, identifying anagrams, and optionally organizing them based on size or word length.
- Utilizes auxiliary functions `txt2Dict`, `invertDict`, and `sortDictByKeys` for processing, requiring their correct implementation.
- The function can identify the set of letters that forms the most bingos in Scrabble, as per Exercise 12-3's exploration of 8-letter anagrams.

# Example
Analyze and print sets of anagrams sorted by the number of anagrams from "words.txt":
```julia
anagramsViaDict(filename="words.txt", 
                rawDataFolder="rawData/", 
                extension=".txt", 
                indexBy="Number of Anagrams", 
                saveSingleInstances=false, 
                orderSets=true, 
                printResult=true, 
                verbose=true)
```
"""
function anagramsViaDict(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    indexBy::String="Number of Anagrams",
    saveSingleInstances::Bool=false,
    orderSets::Bool=true,
    printResult::Bool=true,
    verbose::Bool = false)

    wordsDict = txt2Dict(filename, rawDataFolder=rawDataFolder, extension=extension, verbose=verbose) # a dict which contains all words in words.txt as keys (and a dummy value of 1 for each key)

    anagramsDict = Dict{String, Tuple{Int, Vector{String}}}()

    maxNumAnagrams = 1
    lengthOfLongestWord = 0;

    for word ∈ keys(wordsDict)
        baseWord = String(sort(collect(word)))
        if haskey(anagramsDict, baseWord)
            myprintln(verbose, "Word $(word) already has a known anagram.")
            valOld = anagramsDict[baseWord]
            numKnownAnagrams = valOld[1]
            knownAnagramsList = valOld[2]
            valNew = (numKnownAnagrams+1, push!(knownAnagramsList, word))
            anagramsDict[baseWord] = valNew
            maxNumAnagrams = max(numKnownAnagrams+1, maxNumAnagrams)
            lengthOfLongestWord = max(lengthOfLongestWord, length(baseWord))
        else
            anagramsDict[baseWord] = (1, [word])
        end
    end

    if !saveSingleInstances
        for word ∈ keys(anagramsDict)
            val = anagramsDict[word]
            numKnownAnagrams = val[1]
            if numKnownAnagrams == 1
                delete!(anagramsDict, word)
            end
        end
    end

    if orderSets
        if indexBy == "Number of Anagrams"
            sortedAnagramSets = [Vector{Vector{String}}() for _ in 1:maxNumAnagrams]

            for word ∈ keys(anagramsDict)
                val = anagramsDict[word]
                numKnownAnagrams = val[1]
                knownAnagramList = val[2]
                push!(sortedAnagramSets[numKnownAnagrams], knownAnagramList)
            end

            myprintln(printResult, "Longest set(s) of Anagrams are $(maxNumAnagrams) anagrams long."*" Printing the set(s):")
            [myprintln(printResult, "$(sortedAnagramSets[maxNumAnagrams][i])") for i in eachindex(sortedAnagramSets[maxNumAnagrams])]

        elseif indexBy == "Length of Word"

            sortedAnagramSets = [Vector{Tuple{Int, Vector{String}}}() for _ in 1:lengthOfLongestWord];

            for word ∈ keys(anagramsDict)
                lengthOfWord = length(word)
                val = anagramsDict[word]
                push!(sortedAnagramSets[lengthOfWord], val)
            end

            if printResult
                bingo_length = 8
                bingo_eligible_anagrams = sortedAnagramSets[bingo_length]
                biggest_bingo_set_size = 0
                biggest_bingo_sets = []
                for (numKnownAnagrams, knownAnagramsList) in bingo_eligible_anagrams
                    if numKnownAnagrams == biggest_bingo_set_size
                        push!(biggest_bingo_sets, knownAnagramsList)
                    elseif numKnownAnagrams > biggest_bingo_set_size
                        biggest_bingo_set_size = numKnownAnagrams;
                        biggest_bingo_sets = [knownAnagramsList];
                    end
                end

                myprintln(printResult, "Longest sets of Scrabble \"bingo\" eligible ($(bingo_length)-lettered words) have $(biggest_bingo_set_size) anagrams." * " Printing the sets:")
                [myprintln(printResult, "$(biggest_bingo_sets[i])") for i in eachindex(biggest_bingo_sets)]
            
            end

        else

            @error "floc"

        end

        return sortedAnagramSets

    else

        return anagramsDict
    
    end

    @error "floc"
    
end

# anagrams = anagramsViaDict(orderSets=false);
# anagrams = anagramsViaDict(orderSets=true, indexBy="Length of Word", printResult=true);
# anagrams = anagramsViaDict(orderSets=true, indexBy="Number of Anagrams");

"""
    generateSwapPatterns(length::Int, numPositions::Int) -> Vector{Vector{Int}}

Generates all unique combinations of positions for swapping in a string or array of a given length. This function is useful for identifying potential metathesis pairs or for systematically generating variations of a word by swapping characters.

# Arguments
- `length::Int`: The length of the string or array for which swap patterns are to be generated.
- `numPositions::Int`: The number of positions to be swapped. For metathesis pairs, this would typically be 2, but can be set to any number less than or equal to `length`.

# Returns
- A vector of vectors, where each inner vector contains indices representing a unique combination of positions for swapping. The indices are 1-based, consistent with Julia's indexing.

# Notes
- This function leverages Julia's `Combinatorics` package for generating combinations, so make sure the package is installed and imported with `using Combinatorics`.
- The function is designed to explore structural variations in words or arrays, aiding in tasks like generating anagrams, metathesis pairs, or other combinatorial manipulations of sequences.

# Example
Generate swap patterns for a 4-letter word, choosing 2 positions to swap:

```julia
swap_patterns = generateSwapPatterns(4, 2)
println(swap_patterns)
```
This will output a list of all pairs of positions in a 4-character sequence that could be swapped, such as [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]].

"""
function generateSwapPatterns(length::Int, numPositions::Int)
    patterns = Vector{Vector{Int}}()
    for combo in combinations(1:length, numPositions)
        push!(patterns, collect(combo))
    end
    return patterns
end

# swap_patterns = generateSwapPatterns(8, 2)
# println(swap_patterns)
"""
    swapTwoLetters(str::String, indices::Vector{Int}) -> String

Swaps two letters in a given string based on specified indices. This function is designed for string manipulation tasks that require exchanging the positions of two characters, such as generating metathesis pairs or exploring word variations.

# Arguments
- `str::String`: The input string from which two letters will be swapped.
- `indices::Vector{Int}`: A vector containing exactly two integers that represent the indices of the characters in `str` to be swapped. Indices are 1-based, following Julia's indexing convention.

# Returns
- `String`: A new string with the specified characters swapped. The original string `str` remains unchanged.

# Notes
- The function validates that `indices` contains exactly two elements. An error is thrown if this condition is not met, ensuring correct usage.
- It's important to ensure that the indices provided in `indices` are valid for the length of `str` to avoid indexing errors.
- This function can be utilized in various contexts, including linguistic studies, puzzles, and games where character manipulation is needed.

# Example
Swap the first and last characters of the word "hello":
```julia
newStr = swapTwoLetters("hello", [1, 5])
println(newStr)  # Output: "oellh"
```
"""
function swapTwoLetters(str::String, indices::Vector{Int})
    # Ensure the indices vector contains exactly two elements
    if length(indices) != 2
        error("Indices vector must contain exactly two elements.")
    end

    # Convert the string to a character array for mutability
    chars = collect(str)

    # Swap the characters at the specified indices
    chars[indices[1]], chars[indices[2]] = chars[indices[2]], chars[indices[1]]

    # Convert the character array back to a string
    strS = String(chars)

    return strS
end


# dictionary = Dict("supes" => 1, "puses" => 1, "spues" => 1) # for testing

"""
Exercise 12-4 of Think Julia

    metathesisPairs(filename::String="words.txt";
                    rawDataFolder::String="rawData/",
                    extension::String=".txt",
                    verbose::Bool=false) -> Dict{String, Vector{String}}

Identifies and returns metathesis pairs from a specified word list. Metathesis pairs are words that can be transformed into each other by swapping two letters. This function reads words from a file, generates all possible two-letter swaps for each word, and checks if the swapped variant exists in the word list.

# Arguments
- `filename::String="words.txt"`: The name of the file containing the word list. Default is "words.txt".
- `rawDataFolder::String="rawData/"`: The directory where the word list file is located. Default is "rawData/".
- `extension::String=".txt"`: The file extension of the word list file. Default is ".txt".
- `verbose::Bool=false`: If set to `true`, enables verbose output for debugging purposes. Note: Currently, verbose messages are set to always off in the implementation.

# Returns
- `Dict{String, Vector{String}}`: A dictionary where each key is a word from the word list, and the value is a vector of its metathesis pairs found in the same list.

# Notes
- The function leverages `txt2Dict` to read the word list and create a dictionary with all words as keys.
- It uses `generateSwapPatterns` to systematically generate all two-letter swap combinations for words of various lengths.
- `swapTwoLetters` is utilized to generate swapped word variants based on the combinations provided by `generateSwapPatterns`.
- The function efficiently caches swap patterns for words of the same length to minimize redundant computations.
- Words with less than two letters are automatically skipped, as they cannot form metathesis pairs.
- For testing or demonstration, a specific dictionary of words can be provided as an argument (commented out in the provided code).

# Example
To find metathesis pairs in a file "words.txt" located in the "rawData/" directory:
```julia
metathesisPairs = metathesisPairs("words.txt", "rawData/", ".txt", verbose=true)
println(metathesisPairs)
```
"""
function metathesisPairs(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool = false
    # ,dictionary::Dict=Dict("supes" => 1, "puses" => 1, "spues" => 1) # for testing
    )

    pairsDict = Dict{String, Vector{String}}()
    # wordsDict = dictionary # for testing with 
    wordsDict = txt2Dict(filename, rawDataFolder=rawDataFolder, extension=extension, verbose=verbose) # a dict which contains all words in words.txt as keys (and a dummy value of 1 for each key)

    swappingDict = Dict{Int, Vector{Vector{Int}}}()

    for word ∈ keys(wordsDict)

        n = length(word)

        if n >= 2 # cannot swap two letters for a single letter word

            if haskey(swappingDict, n)
                swappingWays = swappingDict[n]
            else
                swappingWays = generateSwapPatterns(n, 2)
                swappingDict[n] = swappingWays
            end

            for swappingWay ∈ swappingWays

                wordS = swapTwoLetters(word, swappingWay)

                if wordS != word && haskey(wordsDict, wordS) # don't wanna look for the same word in the dict, or swapped words which don't exist
                    if haskey(pairsDict, word)
                        myprintln(false, "$(word) already has some existing metathesisPairs, so adding $(wordS) to that list")
                        push!(pairsDict[word], wordS)
                    else
                        pairsDict[word] = [wordS]
                        myprintln(false, "$(word) not in existing database, so adding it as a key and the swapped word $(wordS) as a val")
                    end

                end

            end

        end

    end

    return pairsDict
            
end

# pairsDict = metathesisPairs()

# Exercise 12-5 from Think Julia
"""
    generateChildrenWords(word::String; verbose::Bool = false) -> Vector{String}

Generates a list of "children words" derived from a given word by removing one character at a time. Each child word is formed by omitting exactly one character from the original word, resulting in a set of words each one character shorter than the input.

# Arguments
- `word::String`: The input word from which children words will be generated.
- `verbose::Bool=false`: If set to `true`, enables verbose output during the function execution. Currently, this parameter does not affect output but is reserved for future use.

# Returns
- `Vector{String}`: A vector containing all possible children words derived from the input word. The order of the children words in the vector corresponds to the order of removal of each character in the input word.

# Notes
- The function iterates over each character position in the input word, creating a new child word for each position by omitting the character at that position.
- The size of the returned vector will always be equal to the length of the input word, as each character's removal results in one unique child word.
- This function can be particularly useful in linguistic applications, such as generating word ladders or exploring word morphology.

# Example
Generate children words from the word "cat":
```julia
childrenWords = generateChildrenWords("cat")
println(childrenWords)  # Output: ["at", "ct", "ca"]
```
"""
function generateChildrenWords(word::String;
    verbose::Bool = false)

    childrenWords = String[]
    chars = collect(word)
    n = length(chars)

    for idx ∈ 1:n
        charsChild = chars[[1:idx-1; idx+1:n]]
        childWord = String(charsChild)
        push!(childrenWords, childWord)
    end

    return childrenWords

end

generateChildrenWords("hello");

function longestValidWord(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool = false
    # ,dictionary::Dict=Dict("supes" => 1, "puses" => 1, "spues" => 1) # for testing
    )

    pairsDict = Dict{String, Vector{String}}()
    # wordsDict = dictionary # for testing with 
    wordsDict = txt2Dict(filename, rawDataFolder=rawDataFolder, extension=extension, verbose=verbose) # a dict which contains all words in words.txt as keys (and a dummy value of 1 for each key)
    merge!(wordsDict, Dict(zip(["a", "i", ""], ones(3))))

    return wordsDict
end
    
wordsDict1 = longestValidWord()