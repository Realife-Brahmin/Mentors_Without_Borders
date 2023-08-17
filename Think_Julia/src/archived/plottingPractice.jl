using Plots

theme(:dracula)
domain = LinRange(0, 2π, 100);
xtickValues = vec([0 π/2 π 3π/2 2π])
xtickLabels = ["0", "π/2", "π", "3π/2", "2π"]
typeof(xtickLabels)

plot(domain, 
    sin.(domain),
    xlabel = "time [s]",
    xticks = (xtickValues, xtickLabels),
    ylabel = "distance [m]",
    label = "sin(x)",
    title = "Basic Trig Plots")