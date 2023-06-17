function firstLine(ncols, width)
    for column = 1:ncols
        print("+", "-"^width)
    end
    println("+")
end

function secondLine(ncols, width)
    for column = 1:ncols
        print("|", " "^width)
    end
    println("|")
end

function printgrid(nrows, ncols, length, width)
    for row in 1:nrows
        firstLine(ncols, width)
        for i in 1:length
            secondLine(ncols, width)
        end
    end
    firstLine(ncols, width)
end

nrows = 3;
length = 3;
ncols = 3;
width = 8;
printgrid(nrows, ncols, length, width)

