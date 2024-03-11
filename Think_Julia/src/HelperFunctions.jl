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

