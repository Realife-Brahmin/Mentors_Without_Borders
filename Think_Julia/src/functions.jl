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

@btime ack(2, 2) # 500 ns, 64003554 function calls
@btime ack(3, 4) # 25-250 mewsec, function is called 308199914 times
@btime ack(10, 10)