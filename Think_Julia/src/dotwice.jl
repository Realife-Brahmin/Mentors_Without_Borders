function dotwice(f, x)
    f(x);
    f(x);
end

function dofour(f, x)
    dotwice(f, x);
    dotwice(f, x);
end