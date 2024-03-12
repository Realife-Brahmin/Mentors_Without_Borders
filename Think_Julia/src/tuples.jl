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

# sumall(1, 2.0, -22π+im*2.0)

function hasmatch(t1, t2)
    for (x, y) in zip(t1, t2)
        if x == y 
            return true
        end
    end
    return false
end

hasmatch("Anne", "Penne")
