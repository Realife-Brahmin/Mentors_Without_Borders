using InteractiveUtils
@show versioninfo()
Threads.nthreads()
Threads.threadid()

#single-threaded

for i in 1:Threads.nthreads()
    println("i: ", i, "\t Thread ID: ", Threads.threadid())
end

println("*******");

#Multi-thread example
Threads.@threads for i in 1:Threads.nthreads()
    println("i: ", i, "\t Thread ID: ", Threads.threadid())
end

#Data-race example
function multi_sum2(myvector)
    temp = 0;
    Threads.@threads for i in eachindex(myvector)
        temp += myvector[i];
    end
    return temp
end

n = 1_000_000;
myvector = collect(n-5:n);
println(myvector[1:5])
# multi_sum2(myvector)
 