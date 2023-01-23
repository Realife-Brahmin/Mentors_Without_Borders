include("functions/rightJustify.jl")

rightJustify("monty");
name = "Aryan Ritwajeet Jha";
rightJustify(name);
age = 24;
str = "Hello! My name is  $(name) and I'm  $(age) years old. Nice to meet you.";
strSmall = str[1:61]
# println(str)
rightJustify(strSmall)