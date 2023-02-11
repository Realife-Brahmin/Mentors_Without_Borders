###Non-Machine Learning Approach
using CSV, GLM, Plots, TypedTables

rawDataFolder = "rawData/";
rawDataFilename = rawDataFolder*"housingdata.csv";
data1 = CSV.File(rawDataFilename)
houseSize = data1.size
# housePrice = round.(Int, data1.price / 1000)
housePrice = data1.price
table1 = Table(X = houseSize, Y = housePrice)

gr(size = (500, 500));

p_scatter = scatter(houseSize, housePrice,
    xlims = (minimum(houseSize)*0.9, maximum(houseSize)*1.1),
    ylims = (minimum(housePrice)*0.9, maximum(housePrice)*1.1),
    xlabel = "Size (sqft)",
    ylabel = "Price in 1000\$",
    title = "Housing Prices in Portland",
    legend = false,
    color = :red
)

###Use GLM package for Linear Regression Model
#ols = Ordinary Least Squares
ols = lm(@formula(Y ~ X), table1)   