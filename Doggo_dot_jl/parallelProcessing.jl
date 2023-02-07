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

vec1 = 1:5
@show eachindex(vec1)

#Data-race example
function multi_sum2(myvector)
    temp = 0;
    Threads.@threads for i in eachindex(myvector)
        temp += myvector[i];
    end
    return temp
end

n = 1_000_000;
myvector = collect(1:n);
myvector[1:5]
sum_dataRace = multi_sum2(myvector)
sum_singleCore = sum(myvector)
sum_singleCore - sum_dataRace