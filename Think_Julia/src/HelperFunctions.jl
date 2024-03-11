function myprintln(verbose::Bool, args...)
    if verbose
        println(args...)
    end
end;

"""
    myzeros(array)

Create a new array with the same size and type as the given `array`, but initialized with zeros.
"""
function myzeros(array)
    return zeros(eltype(array), size(array))
end

"""
    myfill(array, value)

Create a new array with the same size and type as the given `array`, but initialized with `value`.
The type of the returned array's elements is preserved from the original array.
"""
function myfill(array, value)
    T = eltype(array)
    return fill(T(value), size(array))
end

"""
    listOfLines(filename::String="words.txt"; rawDataFolder::String="rawData/", extension::String=".txt", verbose::Bool=false) -> Vector{String}

Reads a text file and returns a list of lines from the file. This function is designed to facilitate reading text files where each line is significant—such as files containing a list of words, sentences, or any other data delineated by line breaks.

# Arguments
- `filename::String="words.txt"`: The name of the file to be read. If the filename does not contain an extension, a default extension (`.txt`) is appended.
- `rawDataFolder::String="rawData/"`: The directory where the file is located. Defaults to a folder named `rawData/`.
- `extension::String=".txt"`: The default file extension to append to `filename` if it doesn't already include one.
- `verbose::Bool=false`: If `true`, prints additional information about the file processing, including a notification when the default extension is appended to the filename.

# Returns
- `Vector{String}`: A vector containing each line from the file as a separate string.

# Notes
- The function assumes that the input file's content is text-based and treats each line as a separate data entry to be returned in the vector.
- If `verbose` is enabled, and the filename does not include an extension, the function will notify the user about appending the default `.txt` extension. This helps ensure clarity in file handling, especially in cases where file extensions are omitted or forgotten.

# Example
To read lines from a file named `example.txt` located in the `rawData/` directory, you can call the function as follows:
```julia
lines = listOfLines("example.txt", rawDataFolder="rawData/", verbose=true)
```
"""
function listOfLines(filename::String="words.txt";
    rawDataFolder::String="rawData/",
    extension::String=".txt",
    verbose::Bool=false)

    if !contains(filename, ".")
        myprintln(verbose, "filename does not have extension embedded.\n 
            adding extension $extension at its end.\n"
        )
        filename = filename * extension
    end

    fin = open(rawDataFolder * filename)

    lines = []
    for line ∈ eachline(fin)
        word = line
        push!(lines, word)
    end

    return lines
end