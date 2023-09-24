function printlyrics()
    println("I'm a lumberjack, and I'm okay.")
    println("I sleep all night and I work all day.")
end

function repeatlyrics()
    printlyrics()
    printlyrics()
end

repeatlyrics()

function printtwice(bruce)
    println(bruce)
    println(bruce)
end

printtwice(π)
# "Spam"
"Spam"^4 # * concatenates two strings
printtwice("Spam "^4)

function cattwice(part1, part2)
    part1 = string(part1)
    part2 = string(part2)
    concat = part1 * part2
    printtwice(concat)
end