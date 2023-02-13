using VegaDatasets, DataVoyager, VegaLite

data = dataset("iris")

# vscodedisplay(data)
v = Voyager(data)
p = v[]
save("iris_voyager.png", p)
save("iris_voyager.svg", p)
