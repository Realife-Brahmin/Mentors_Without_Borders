include("setup.jl")
# functions.jl

function printlyrics()
    println("I'm a lumberjack, and I'm okay.")
    println("I sleep all night and I work all day.")
end

function repeatlyrics()
    printlyrics()
    printlyrics()
end

# repeatlyrics()

function printtwice(bruce)
    println(bruce)
    println(bruce)
end

# printtwice(π)
# "Spam"
"Spam"^4 # * concatenates two strings
# printtwice("Spam "^4)

function cattwice(part1, part2)
    part1 = string(part1)
    part2 = string(part2)
    concat = part1 * part2
    printtwice(concat)
end

# Exercise 6-5 Ackermann function

global ack_calls = 0

function ack(m, n)
    
    global ack_calls += 1
    if m == 0
        A = n+1
    elseif m > 0 && n == 0
        A = ack(m-1, 1)
    elseif m > 0 && n > 0
        A = ack(m-1, ack(m, n-1))
    else
        @error "floc"
    end

    return A
end

# m = 2; 
# m = 3;
# m = 4;
# n = 2; 
# n = 4;
# n = 4;
# @btime ack(m, n)
# A = ack(m, n)
# println("Ackermann value = $(A)")
# println("Ackermann calls for A($(m), $(n)) = $(ack_calls)")
# println("Trying to increase m to even 3 makes the function explode.")

