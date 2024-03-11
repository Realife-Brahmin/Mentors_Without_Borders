# strings.jl
include("setup.jl");
include("./arrays.jl"); # listOfWords

wordsList = listOfWords();
n = length(wordsList);
word = wordsList[rand(1:n)];
rotation = rand(1:26);

"""
Exercise 8-11 in Think Julia.

    rotateWords(word, rotation; verbose::Bool = false) -> String

Rotates each letter in the given word by a specified number of positions in the alphabet, wrapping around the alphabet if necessary. This function implements a Caesar cipher-like rotation, assuming lowercase alphabetic characters.

# Arguments
- `word`: The word to be rotated. Currently, the function only supports lowercase alphabetic characters correctly.
- `rotation`: The number of positions each letter in the word will be rotated by. Can be positive (for forward rotation) or negative (for backward rotation).
- `verbose::Bool=false`: An optional argument that, if set to `true`, would provide additional output about the function's operation. This feature is currently not implemented.

# Returns
- `String`: The rotated word, with each letter shifted by the specified number of positions within the alphabet.

# Warnings
- The function is designed to work with lowercase letters only. Uppercase letters and non-alphabetic characters will not be rotated correctly and may produce unintended results.
- Non-alphabetic characters, including spaces, punctuation, and numbers, are not specifically handled by this function and will undergo transformation based on their ASCII values, potentially leading to unpredictable outcomes.

# Notes
- This function utilizes modular arithmetic to ensure that letter rotations wrap correctly from 'z' back to 'a'.
- Efficient Julia array and broadcasting operations are used for the rotation process, ensuring good performance even for large words.

# Example
- Rotating the word 'abc' by 3 positions yields 'def':
```julia
julia> rotateWords("abc", 3)
"def"
```
Rotating the word 'xyz' by 2 positions yields 'zab':
```
julia> rotateWords("xyz", 2)
"zab"
```
"""
function rotateWords(word, rotation;
    verbose::Bool = false)

    chars = collect(word)
    intsAlphabet = Int.(chars) .- Int('a')
    intsAlphabetRotated = mod.( intsAlphabet .+ rotation,  26) # will be from 0 to 25
    intsCharRotated = intsAlphabetRotated .+ Int('a')
    charsRotated = Char.(intsCharRotated)
    rotatedWord = String(charsRotated)

    return rotatedWord
end

rotatedWord = rotateWords(word, rotation)