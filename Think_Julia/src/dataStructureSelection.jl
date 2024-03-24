# dataStructureSelection.jl

include("setup.jl");

include("./arrays.jl"); # for speed comparision with array implementations
include("./dictionaries.jl");
include("./functions.jl");
include("./strings.jl");
include("./tuples.jl");

charsToRemove = ['.', ',', '{', '}', '[', ']']

function readParagraphs2(filename::String;
    charsToRemove::Vector{Char}=Char[],
    verbose::Bool=false)

    open(filename, "r") do file
        paragraphs = Vector{String}()
        current_paragraph = ""
        for line in eachline(file)
            if isempty(strip(line, charsToRemove))  # Check for an empty line
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

# function paragraphsToString(paragraphs::Vector{String},
#     delimiter::String="\n\n")

#     return join(paragraphs, delimiter)

# end
function readBook(filename::String;
    startLine::String="*** START OF THE PROJECT GUTENBERG EBOOK",
    endLine::String="*** END OF THE PROJECT GUTENBERG EBOOK",
    charsToRemove::Vector{Char}=['.', ',', ''', '`', '"', ';', '-', ':', '{', '}', '[', ']'],
    # charsToRemove::Vector{Char}=Char[],
    verbose::Bool=false)

    joinedCharsToRemove = join(charsToRemove)

    open(filename, "r") do file
        bookLines = Vector{String}()
        reading = false

        for line in eachline(file)
            if occursin(startLine, line)
                reading = true
                continue
            elseif occursin(endLine, line)
                break
            end

            if reading && !isempty(line)
                # Remove specified unwanted characters one by one
                # cleanLine = replace(line, r"[$(join(charsToRemove))]" => "")
                cleanLine = replace(line, r"$(joinedCharsToRemove)" => "")
                # Convert to lowercase
                cleanLine = lowercase(cleanLine)

                if !isempty(cleanLine)
                    push!(bookLines, cleanLine)
                end
            end
        end

        return bookLines
    end
end






# filename = "emma-2021-12-14.txt"
# fileAddr = joinpath(rawDataDir, filename)
# paras = readParagraphs2(fileAddr)
# paraString = paragraphsToString(paras)
# str = lowercase(paraString)

filename = "emma-2021-12-14.txt"
fileAddr = joinpath(rawDataDir, filename)
bookLines = readBook(fileAddr)

# Print the first few lines to verify
# println(bookLines[1:5])
