using ThinkJulia
🐢 = Turtle()

function square(t, len)
    for i in 1:4
        forward(t, len)
        turn(t, -90)
    end
end
#=
function polygon(t, len,n)
    angle = 360/n
    for i in 1:n
        forward(t,len)
        turn(t, -angle)
    end
end

function circle(t, r)
    circumference = 2 * π * r
    n = trunc(circumference/3)+3
    len = circumference / n
    polygon(t,len, n)
end

function arc(t, r, angle)
    arc_len = 2* π *r *angle/360
    n = trunc(arc_len/3)+1
    step_len =  arc_len/n
    step_angle = angle/n
    for i in 1:n
        forward(t, step_len)
        turn(t, step_angle)
    end
end
=#

function polyline(t, len, n, angle)
    for i in 1:n
        forward(t, len)
        turn(t, -angle)
    end
end

function polygon(t, len, n)
    angle = 360 / n
    polyline(t, len, n, angle)
end

function arc(t, r, angle)
    arc_len = 2 * π * r * angle / 360
    n = trunc(arc_len / 3) + 1
    step_len = arc_len / n
    step_angle = angle / n
    polyline(t, step_len, n, step_angle)
end

function circle(t, r)
    arc(t, r, 360)
end

"""
Trace un arc d'un rayon et d'un angle donnés:
    t: turtle
    r: rayon
    angle: angle sous-tendu par l'arc, en degrés
"""
function arc(t, r, angle)
    arc_len = 2 * π * r * abs(angle) / 360
    n = trunc(arc_len / 4) + 3
    step_len = arc_len / n
    step_angle = angle / n


    turn(t, -step_angle/2)
    polyline(t, n, step_len, step_angle)
    turn(t, step_angle/2)
end

@svg begin
    #square(🐢, 100)
    #polygon(🐢, 100, 7)
    #circle(🐢, 50)
    arc(🐢, 50, 260)
end

