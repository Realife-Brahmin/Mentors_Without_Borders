P_supply(Q) = (Q + 6) / 3

P_demand(Q) = (-Q + 32) / 2
using CairoMakie

scene, layout = layoutscene(resolution = (325, 325))
scene

ax = layout[1, 1] = Axis(scene,
    xlabel = "Quantity", xlabelsize = 10,
    xticklabelsize = 9, xticksize = 3,
    ylabel = "Price", ylablesize = 10,
    yticklabelsize = 9, yticksize = 3,
    ytickformat = "\${:d}",
    title = "Supply and Demand", titlesize = 12
)

scene