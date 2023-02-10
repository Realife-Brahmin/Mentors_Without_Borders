function printgrid(boxWidth, boxHeight, numRows, numCols)
    strBaseHorz = "+ " * "- "^boxWidth;
    strLineHorz = strBaseHorz^numRows * "+\n";
    strBaseVert = "|" * " "^(2*boxWidth + 1);
    strLineVert = strBaseVert^numRows * "|\n";
    strBox = strLineHorz* strLineVert^boxHeight;
    strBoxes = strBox^numCols * strLineHorz
    println(strBoxes);
end

printgrid(4, 4, 4, 4)