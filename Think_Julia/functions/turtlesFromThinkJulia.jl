using ThinkJulia

🐢 = Turtle()

function square(t, a)
    @svg begin
        for i in 1:4
            forward(t, a)
            turn(t, -90)
        end
    end
end

function polygon(t, n, a)
    @svg begin
        for i in 1:n
            forward(t, a)
            turn(t, -360/n)
        end
    end
end

function circle(t , r)
    circumference = 2*π*r;
    n = trunc(circumference/3) + 3;
    a = 2*π*r/n;
    n = trunc(a / 3) + 3
    polygon(t, n, a);
end

function arc(t, r, angle)
    circumference = 2π*r;
    n = trunc(circumference/3) + 3;
    a = 2*π*r/n;
    numSides = trunc(n*angle/360);
    @svg begin
        for i in 1:numSides
            forward(t, a)
            turn(t, -360/n)
        end
    end
end

🐫 = Turtle()
arc(🐫, 100, 330)


