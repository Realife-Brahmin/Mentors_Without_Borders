# dictionaries.jl

using BenchmarkTools
eng2sp = Dict();
eng2sp["one"] = "uno";
eng2sp = Dict("one" => "uno", "two" => "dos", "three" => "tres");

eng2sp["two"]
l = length(eng2sp)
ks = keys(eng2sp);
print(ks)
"one" ∈ ks
"two" ∈ ks
"uno" ∈ ks
vs = values(eng2sp);
"uno" ∈ vs # hash table
"one" ∈ vs

function histogramViaVectors(str::String)
    h = zeros(Int64, 26)
    N = length(str)
    for i = 1:N
        h[Int(lowercase(str[i])) - 96] += 1
    end
    return h
end

function histogramViaDictionaries1(str::String)
    h = Dict{Char, Int64}()
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
    Ex 11-1
"""
function histogramViaDictionaries2(str::String)
    h = Dict{Char, Int64}()
    N = length(str)
    for i = 1:N
        letter = lowercase(str[i])
            h[letter] = get(h, letter, 0) + 1
    end
    return h
end

testString = "pZbXvJUxqQKdYrMzVcsgaAeBnOhLjRkDyFmCwTtGpIuHlSfNiWvEoX";
@btime hV = histogramViaVectors(testString)
@btime hD1 = histogramViaDictionaries1(testString)
@btime hD2 = histogramViaDictionaries2(testString)

