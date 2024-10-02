
# # Write a function named rightjustify that takes a string named s as a parameter and prints the string with 
# enough leading spaces so that the last letter of the string is in column 70 of the display.

function rightjustify(str)
    total_width = 70
    leading_space = total_width - length(str) 
    println(" " ^ leading_space * str)

end
rightjustify("monty")
rightjustify("Janice")

# Modify dotwice so that it takes two arguments, a function object and a value, and calls the function twice, 
# passing the value as an argument.

function printlyrics()
    println("I'm a lumberjack, and I'm okay.")
    println("I sleep all night and I work all day.")
end

function repeatlyrics()
    printlyrics()
    printlyrics()
end

repeatlyrics()

function dotwice(f)
    f()
    f()
end
dotwice(printlyrics)

function dotwice1(f,a)
    f(a)
    f(a)
end

dotwice1(rightjustify,"movies")
# dotwice1(rightjustify)
# dotwice(rightjustify,"movies")
# dotwice(rightjustify)

# Copy the definition of printtwice from earlier in this chapter to your script.

function printtwice(s)       #represents variable string
    println(s)
    println(s)
end
# Use the modified version of dotwice to call printtwice twice, passing "spam" as an argument.
function dotwice()
    printtwice("Spam")      #can write any string name
    printtwice("Spam")
end

dotwice()


# Define a new function called dofour that takes a function object and a value and calls the function four times, 
# passing the value as a parameter. There should be only two statements in the body of this function, not four.
function printnames(s)
    println(s)
    println(s)
    
end

function dofour(printnames,s)
end
    dofour()

    # Exercise 3-4
    # Write a function printgrid that draws a grid like the following:
    function printgrid()
        width = "+ - - - - + - - - - +" 
        length = "|         |         |"
        println(width)
        for i in 1:4
            println(length)
        end
        println(width)
        for i in 1:4
            println(length)
        end
        println(length)
    end















