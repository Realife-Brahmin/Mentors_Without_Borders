# recurssion ability of a functin to call on itself
function countdown(n)
    if n ≤ 0
        println("Blastoff!")
    else
        println(n,"")
        countdown(n-1)
    end
end
countdown(7)

# example 2
function printn(s, n)
    if n ≤ 0
        return
    end
    println(s)
    printn(s, n-1)
end
printn(0,5)


# Exercise 5-1
# As an exercise, draw a stack diagram for printn called with s = "Hello" and n = 2. Then write a function called
#  do_n that takes a function object and a number, n, as arguments, and that calls the given function n
#  times

# implementing printn function
function printn(s,n)
    if n ≤ 0
        return
    end
    println(s)
    printn(s,n-1)
end
# implementin do n
function do_n(f,n)
    if n ≤ 0 
        return
    else 
        f()
        do_n(f,n-1)
           end
end
do_n(() -> printn("Hello", 2), 3)

# Exercise 5-2
# 1.Write a script that reads the current time and converts it to a time of day in hours, minutes, and seconds, 
# plus the number of days since the epoch

function convert_seconds_to_time(seconds_since_epoch)

    # seconds per day
    seconds_per_day = 24 * 60 * 60

    day_since_epoch = seconds_since_epoch ÷ seconds_per_day


    remaining_seconds = seconds_since_epoch  % seconds_per_day

    hours = remaining_seconds ÷ (60*60)
    remaining_seconds %= (60*60)

    minutes = remaining_seconds ÷ 60
    seconds = remaining_seconds % 60

    return day_since_epoch, hours, minutes, seconds   
end

seconds_since_epoch =  1700000000     #setting the actual number of seconds since epoch#

day_since_epoch, hours, minutes, seconds = convert_seconds_to_time(seconds_since_epoch)

# displays result
println("Days since the epoch: $day_since_epoch")
println("Time of day: $hours hours, $minutes minutes, $seconds seconds")

# Exercise 5-3
# Write a function named checkfermat that takes four parameters—a, b, c and n—and checks to see if 
# Fermat’s theorem holds.If n is greater than 2 and a^n + b^n == c^n the program should print, 
# “Holy smokes, Fermat was wrong!” Otherwise the program should print, “No, that doesn’t work.”

function checkfermat(a::Int, b::Int, c::Int, n::Int)

    if n > 2 && (a^n +b^n == c^n)
        println("Holy smokes, Fermat was wrong!")
    else
        println("No, that doesn’t work.")
    end
end

checkfermat(5,6,7,3)


# 2.Write a function that prompts the user to input values for a, b, c and n, converts them to integers, 
# and uses checkfermat to check whether they violate Fermat’s theorem

function input_values()
    println("Enter positive integer for a:")
    a = parse(Int, readline())

    println("Enter positive integer for b:")
    b = parse(Int, readline())

    println("Enter positive integer for c:")
    c = parse(Int, readline())

    println("Enter positive integer n (greater than 2):")
    n = parse(Int, readline())

    checkfermat(a, b, c, n)
end

input_values()


# Exercise 5-4
# Write a function named istriangle that takes three integers as arguments, and that prints either “Yes” or “No”,
#  depending on whether you can or cannot form a triangle from sticks with the given lengths.

function istriangle(a::Int, b::Int, c::Int)
    if a+b ==c || a+c == b || b+c == a
        println("YES")
    else
        println("NO")
    end
end

istriangle(1,1,1)

# Exercise5-4
#  2. Write a function that prompts the user to input three stick lengths, converts them to integers, 
# and uses istriangle to check whether sticks with the given lengths can form a triangle.
function input_lengths()
    println("Enter integer a:")
    a =parse(Int, readline())

    println("Enter integer b:")
    b =parse(Int, readline())

    println("Enter integer c:")
    c =parse(Int, readline())

    istriangle(a, b, c)
end
input_lengths()

# Exercise 5-5
# What is the output of the following program? Draw a stack diagram that shows the state of the program when
#  it prints the result.
function recurse(n, s)
    if n == 0
        println(s)
    else
        recurse(n-1, n+s)
    end
end

recurse(3, 0)
# What would happen if you called this function like this: recurse(-1, 0)?
            # it will be in an infinite recursion