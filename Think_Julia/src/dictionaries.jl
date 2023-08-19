# dictionaries.jl
include("./HelperFunctions.jl");

using BenchmarkTools
using Test

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
@btime begin
    global hV = histogramViaVectors(testString);
end;
@btime begin 
    global hD1 = histogramViaDictionaries1(testString);
end;

@btime begin
    global hD2 = histogramViaDictionaries2(testString);
end;

function printhist(h)
    for c in keys(h)
        println(c, " ", h[c])
    end
end

function printDict2Matrix(a::Union{Dict, Matrix})
    if a isa Dict
        a = printDictSorted(a, returnType="valuesOnly")
    end
    N = size(a, 1)
    for i = 1:N
        println(a[i, 1], " ", a[i, 2])
    end
end

function printDictSorted(h::Dict; returnType::String="printOnly")
    N = length(h)
    arrChar = fill(Char(0), N);
    arrNum = zeros(Int64, N);
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

# printhist(hD2)

@btime global d2Mat1 = printDictSorted(hD2, returnType="valuesOnly");

@btime global d2Mat2 = printDictSorted2(hD2, returnType="valuesOnly");

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

@btime reverseLookup(hD2, 3);
@btime findall(x -> x == 3, hD2);

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

function invertDict(d::Dict{Tk, Tv}) where {Tk, Tv}
    ks = keys(d)
    vs = values(d)
    dinv = Dict{Tv, Vector{Tk}}()
    for k ∈ ks
        v = d[k]
        dinv[v] = push!(get(dinv, v, Vector{Tk}()), k)
    end
    return dinv
end


@btime global hD2inv1 = invertDict0(hD2);
@btime global hD2inv = invertDict(hD2);

function fib(x::Int64, fibMemo::Dict{Int64, Int128}=Dict(0=>0, 1=>1);
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
        fibMemo[x] = fib(x-1, fibMemo, verbose=verbose) + fib(x-2, fibMemo, verbose=verbose)
    end 
end
fibMemo = Dict{Int64, Int128}(0=>0, 1=>1);  # Clearing the memoization cache

@test fib(50, fibMemo, verbose=false) == 12586269025
@test fib(100, fibMemo) == 354224848179261915075

# Start from Ex 11-2