# strings.jl
include("setup.jl");
include("./arrays.jl"); # listOfWords

wordsList = listOfWords();
n = length(wordsList);
word = wordsList[rand(1:n)];
rotation = rand(1:26);

"""
    rotateWords0(word, rotation; verbose::Bool = false) -> String

**Deprecated**: This function rotates each lowercase alphabetic character in the given `word` by a specified number of positions in the alphabet, based solely on a 0-based index for lowercase letters. It is now recommended to use the `rotateWords` function for enhanced functionality, including support for both uppercase and lowercase letters and optional warnings for non-alphabetic characters.

# Arguments
- `word`: The string of characters to be rotated. Should consist of lowercase letters only.
- `rotation`: The number of positions to rotate each character by. Can be positive (for forward rotation) or negative (for backward rotation).
- `verbose::Bool=false`: An optional argument intended for future verbosity features. Currently has no effect.

# Returns
- `String`: A new string with each lowercase character of `word` rotated by `rotation` positions. Non-lowercase characters will not be processed correctly.

# Important Notice
- **Use `rotateWords` instead**: `rotateWords0` is limited to lowercase letters and does not handle non-alphabetic characters gracefully. For a more comprehensive solution that supports both uppercase and lowercase letters, and provides options for handling non-alphabetic characters and verbosity, please use the `rotateWords` function.

# Example
Given the limitations of `rotateWords0`, for rotating "hello" by 2 positions:
```julia
rotateWords0("hello", 2)
```
However, for more advanced usage, including handling uppercase letters and non-alphabetic characters, refer to rotateWords.

"""
function rotateWords0(word, rotation;
    verbose::Bool = false)

    chars = collect(word)
    intsAlphabet = Int.(chars) .- Int('a')
    intsAlphabetRotated = mod.( intsAlphabet .+ rotation,  26) # will be from 0 to 25
    intsCharRotated = intsAlphabetRotated .+ Int('a')
    charsRotated = Char.(intsCharRotated)
    rotatedWord = String(charsRotated)

    return rotatedWord
end

rotatedWord = rotateWords0(word, rotation)

"""
    rotateChar(c::Char, rotation::Int; flagNonAlphabet::Bool = true, verbose::Bool = false) -> Char

Rotates a single alphabet character (`c`) by a specified number of positions (`rotation`) in the alphabet. This function supports both lowercase and uppercase characters, applying rotation appropriately while preserving the case. 

For characters outside the a-z and A-Z range, the function can optionally issue a warning and will return the character unmodified.

# Arguments
- `c::Char`: The character to be rotated. Should ideally be an alphabetic character (either lowercase or uppercase).
- `rotation::Int`: The number of positions to rotate the character by. Positive values rotate forwards through the alphabet, while negative values rotate backwards.
- `flagNonAlphabet::Bool=true`: If `true`, the function will issue a warning when encountering a non-alphabetic character.
- `verbose::Bool=false`: If `true`, prints additional information about the operation, particularly when handling non-alphabet characters.

# Returns
- `Char`: The rotated character if `c` is an alphabetic character. If `c` is not an alphabetic character and `flagNonAlphabet` is `true`, returns `c` unchanged and optionally issues a warning.

# Notes
- The rotation respects character case and wraps around the alphabet, ensuring that 'z' rotated forward by 1 becomes 'a', and 'A' rotated backward by 1 becomes 'Z'.
- If `flagNonAlphabet` is `true`, a Julia warning (`@warn`) is triggered for non-alphabetic characters, helping to identify potential issues without halting execution.
- The optional `verbose` argument can be used for debugging or when detailed operation feedback is desired.

# Examples
- Rotating the lowercase character 'a' by 3 positions yields 'd':
```julia
rotateChar('a', 3)
```
Rotating the uppercase character 'Z' by -1 position yields 'Y':
```julia
rotateChar('Z', -1)
```
Attempting to rotate a non-alphabet character '1' with default settings (warnings enabled):
```julia
rotateChar('1', 5)
```
This will issue a warning about the character not being a lowercase or uppercase alphabet letter and return '1' unchanged.
"""
function rotateChar(c::Char, rotation::Int;
    flagNonAlphabet::Bool = true,
    verbose::Bool = false)

    if islowercase(c)
        return Char(mod(Int(c) - Int('a') + rotation, 26) + Int('a'))
    elseif isuppercase(c)
        return Char(mod(Int(c) - Int('A') + rotation, 26) + Int('A'))
    else
        if flagNonAlphabet
            @warn "Character '$(c)' is not a lowercase or uppercase alphabet letter."
            myprintln(verbose, "Returning character as it is.")
        end
        return c
    end

end

"""
Exercise 8-11 from Think Julia

    rotateWords(word, rotation; flagNonAlphabet::Bool = true, verbose::Bool = false) -> String

Rotates each character in the given `word` by a specified number of positions in the alphabet, wrapping around as necessary. This function supports both lowercase and uppercase characters, and can optionally warn about non-alphabetic characters.

# Arguments
- `word`: The string of characters to be rotated.
- `rotation`: The number of positions to rotate each character by. Can be positive (forward) or negative (backward).
- `flagNonAlphabet::Bool=true`: If `true`, issues a warning for each non-alphabetic character encountered.
- `verbose::Bool=false`: If `true`, provides additional output during the function's execution, particularly for non-alphabet characters.

# Returns
- `String`: A new string with each character of `word` rotated by `rotation` positions.

# Notes
- Utilizes the `rotateChar` function for rotating individual characters, passing along the `flagNonAlphabet` and `verbose` flags.
- The function is designed to handle both uppercase and lowercase alphabetic characters accurately, preserving their case after rotation.
- Non-alphabetic characters are returned as-is unless `flagNonAlphabet` is enabled, in which case a warning is issued for each such character when `verbose` is `true`.

# Example
Rotating the word "Hello, World!" by 2 positions, with warnings enabled for non-alphabetic characters, might yield:
```julia
rotateWords("Hello, World!", 2, flagNonAlphabet = true, verbose = true)
# returns "Jgnnq, Yqtnf!"
```
Assuming rotateChar properly handles and warns for non-alphabetic characters like , and !, this would rotate 'H' to 'J', 'e' to 'g', etc., preserving spaces and punctuation.
"""
function rotateWords(word, rotation;
    flagNonAlphabet::Bool = true, 
    verbose::Bool=false)

    charsRotated = [rotateChar(c, rotation, 
    flagNonAlphabet = flagNonAlphabet, 
    verbose = verbose) for c in collect(word)]
    
    rotatedWord = String(charsRotated)
    
    return rotatedWord

end

# rotateWords("asklfjasjdfkjkALKJLJFLK9034af", -1)