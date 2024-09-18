# question 1 exercise 2.3
r = 5
v = 4/3*π*r^3
println("volume of sphere of radius $r is $v")

# question 2 exercise 2.3
coverprice =24.95
discount_percent= 40
shipping_1_copy = 3
shipping_rest = 0.75
total_copies = 60
total_cost = coverprice*(100-discount_percent)/100*total_copies + shipping_1_copy*1 +shipping_rest*(total_copies-1)