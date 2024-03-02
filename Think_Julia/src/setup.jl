own_addr = @__DIR__
root_addr = dirname(own_addr)
cd(root_addr)
using Pkg
Pkg.activate(".")

Pkg.instantiate()
# Pkg.add("BenchmarkTools")
# Pkg.add("CSV")
# Pkg.add("DataFrames")
# Pkg.add("LinearAlgebra")

using BenchmarkTools
using CSV
using DataFrames
using LinearAlgebra
