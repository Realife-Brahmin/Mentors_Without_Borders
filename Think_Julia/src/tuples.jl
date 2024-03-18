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

function generateSwapPatterns(length::Int, numPositions::Int)
    patterns = Vector{Vector{Int}}()
    for combo in combinations(1:length, numPositions)
        push!(patterns, collect(combo))
    end
    return patterns
end

# swap_patterns = generateSwapPatterns(8, 2)
# println(swap_patterns)

function swapTwoLetters(str::String, indices)
    chars = collect(str)
    charsS = chars
    charsS[indices] = chars[indices[end:-1:1]]
    strS = String(charsS)

    return strS
end

function metathesisPairs(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool = false,
    dictionary::Dict=Dict("supes" => 1, "puses" => 1, "spues" => 1) )

    pairsDict = Dict{String, Vector{String}}()
    wordsDict = dictionary
    # wordsDict = txt2Dict()
    # wordsDict = txt2Dict(filename, rawDataFolder=rawDataFolder, extension=extension, verbose=verbose) # a dict which contains all words in words.txt as keys (and a dummy value of 1 for each key)

    swappingDict = Dict{Int, Vector{Vector{Int}}}()

    for word ∈ keys(wordsDict)
        n = length(word)
        if n >= 2
            if haskey(swappingDict, n)
                swappingWays = swappingDict[n]
            else
                swappingWays = generateSwapPatterns(n, 2)
                swappingDict[n] = swappingWays
            end
            for swappingWay ∈ swappingWays
                wordS = swapTwoLetters(word, swappingWay)
                if wordS != word && haskey(wordsDict, wordS) # don't wanna look for the same word in the dict
                    if haskey(pairsDict, word)
                        push!(pairsDict[word], wordS)
                    else
                        pairsDict[word] = [wordS]
                    end
                end
            end
        end
    end

    return pairsDict
            
end

pairsDict = metathesisPairs()