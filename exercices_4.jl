using ThinkJulia

🐢 = Turtle()
#= 
t: Turtle
len: number of side 
d : distance of side 
a : angle of every side=#

@svg begin
    for i in 1:4 
        forward(🐢,100)
        turn(🐢,-90)
    end
end

function square(t,len)
    @svg begin
        for i in 1:4
            forward(t,len)
            turn(t,-90)
        end
    end

end

square(🐢,8) 


function polygon(t,len,d)
    a=360/d
    @svg begin
        for i in 1:d
            forward(t,len)
            turn(t,-a)
        end
    end

end

polygon(🐢,7,100)



function circle(t,r)
    circumference = 2*π*r
    d=50
    len = circumference/d
    polygon(t,len,d)
end

circle(🐢,60)


function polygon(t,len,d)
    a=360/d
    @svg begin
        for i in 1:d
            forward(t,len)
            turn(t,-a)
        end
    end

end

