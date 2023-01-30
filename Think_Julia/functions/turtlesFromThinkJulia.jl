using ThinkJulia

🐢 = Turtle()
"""
polyline(t, n, len, angle)

Draws n line segments with the given length and
angle (in degrees) between them.  t is a turtle.
"""
function polyline(t, n, a, angle)
    numSides = trunc(n*angle/360);
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

"""
polygon(t, n, a)

Draws an n sides regular polygon 
with side length a.
"""
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

function rotatedPolygon(t, angle, n, a)
    turn(t, angle)
    polygon(t, n, a)
end

"""
isoTriangle(t, r, theta)

Draws an isosceles triangle with equal
sides of length r with angle = theta
(in degrees) contained between them.
"""
function isoTriangle(t, r, theta)
    forward(t, r);
    turn(t, -(90 + theta/2));
    forward(t, 2*r*sin(theta*π/360));
    turn(t, -(90 + theta/2));
    forward(t, r);
end

function turtlePie(t, n, r)
    angle = 360/n;
    turn(t, angle/2);
    for i = 1:n
        isoTriangle(t, r, angle)
        turn(t, 180)
    end
end

🐫 = Turtle()
@svg begin
    turtlePie(🐫, 8, 100)
end