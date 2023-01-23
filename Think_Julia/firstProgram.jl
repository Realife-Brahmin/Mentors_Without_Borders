include("functions/rightJustify.jl")

rightJustify("monty");
name = "Aryan Ritwajeet Jha";
rightJustify(name);
age = 24;
str = "Hello! My name is  $(name) and I'm  $(age) years old. Nice to meet you.";
strSmall = str[1:61]
rightJustify(strSmall)

# using printstyled

# printing text in different colors
for color in [:red, :cyan, :blue, :magenta]
	printstyled("Hello World $(color)\n"; color = color)
end
