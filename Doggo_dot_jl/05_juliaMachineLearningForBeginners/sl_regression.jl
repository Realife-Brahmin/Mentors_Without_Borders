###Non-Machine Learning Approach
using CSV, GLM, Plots, TypedTables

rawDataFolder = "rawData/";
rawDataFilename = rawDataFolder*"housingdata.csv";
data1 = CSV.File(rawDataFilename)
X = data1.size
Y = round.(Int, data1.price / 1000)
table1 = Table(X = X, Y = Y)

gr(size = (600, 600));

p_scatter = scatter(X, Y,
    xlims = (0, 5000),
    ylims = (0, 800),
    xlabel = "Size (sqft)",
    ylabel = "Price in 1000\$",
    title = "Housing Prices in Portland",
    legend = false,
    color = :red
)