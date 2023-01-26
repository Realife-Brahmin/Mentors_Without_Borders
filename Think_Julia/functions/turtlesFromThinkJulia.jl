using ThinkJulia

🐢 = Turtle()

function polyline(t, n, a, angle)
    numSides = trunc(n*angle/360);
    @svg begin
        for i = 1:numSides
            forward(t, a)
            turn(t, -360/n)
        end
        truncatedAngle = mod(angle, trunc(360/n));
        if truncatedAngle != 0
            lastLen = (truncatedAngle*n*a)/360;
            forward(t, lastLen)
        end
    end
end

function polygon(t, n, a)
    polyline(t, n, a, 360);
end

function arc(t, r, angle)
    circumference = 2π*r;
    n = trunc(circumference/3) + 3;
    a = circumference/n;
    polyline(t, n, a, angle)
end

function circle(t , r)
    arc(t, r, 360);
end

🐫 = Turtle()

circle(🐫, 150)