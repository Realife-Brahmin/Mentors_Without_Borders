P_supply(Q) = (Q + 6) / 3

P_demand(Q) = (-Q + 32) / 2
using CairoMakie

scene, layout = layoutscene(resolution = (325, 325))
# scene

ax = layout[1, 1] = Axis(scene,
    xlabel = "Quantity", xlabelsize = 10,
    xticklabelsize = 9, xticksize = 3,
    ylabel = "Price", ylablesize = 10,
    yticklabelsize = 9, yticksize = 3,
    ytickformat = "\${:f}",
    title = "Supply and Demand", titlesize = 12
)

Q_range = 1:25

lineobject1 = lines!(ax, Q_range, P_supply, linewidth = 1, color = :blue)
lineobject2 = lines!(ax, Q_range, P_demand, linewidth = 1, color = :red)

scene

