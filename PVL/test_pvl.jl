

include("pvl.jl")

a=0.1::Float64
w=-2.0::Float64
η=0.1::Float64
c=2.0::Float64

leverN=4::Int64

model=PvlModel{Float64}(a,w,η,c,leverN)

trialN=100

for trial in 1:trialN
    update(model,rand(collect(1:4)),rand(Float64))
end

println(predictionProbs(model))
