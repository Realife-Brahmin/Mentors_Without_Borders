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

# question 3 exercise 2.3
distance1= 1  #miles
pace1=(8*60)+15 # seconds per mile
distance2=3   
pace2=(7*60)+12
distance3= distance1
pace3=pace1
duration=(distance1*pace1)+(distance2*pace2)+(distance3*pace3)
duration_hour=(duration ÷ 3600) #div is used in long division 
duration_minute, duration_second=divrem(duration,60)
starting_hour,starting_minute,starting_second=6,52,0
ending_hour=starting_hour+duration_hour
ending_minute=starting_minute+duration_minute
ending_second=starting_second+duration_second
ending_hour=ending_hour+ending_minute ÷ 60
ending_minute=ending_minute-(ending_minute ÷ 60)*60
ending_second=ending_second-(ending_second ÷ 60) * 60
println("author gets home for breakfast at $ending_hour:$ending_minute:$ending_second AM")