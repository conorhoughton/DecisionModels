

struct PvlModel{T<:Real}

    a::T
    w::T
    η::T
    c::T
    θ::T
    leverN::Int64
    
    expected::Vector{T}
    
    function PvlModel{T}(a::T,w::T,η::T,c::T,leverN::Int64) where T<:Real
        if leverN<1
            error("not enough levers")
        end
        if a<0 || a>1 ||w<0 || η<0 || η> 1 || w>5 || c<0 || c>5
            error("pvl parameter out of bound")
        end
        
        new{T}(a,w,η,c,3^c-1,leverN,zeros(T,leverN))
    end
end

function update(model::PvlModel,leverK::Int64,reward::T) where T<:Real
    u= (reward>0) ? reward^model.a : -w*(-reward)^model.a
    model.expected[leverK]+=model.η*(u-model.expected[leverK])
end

function predictionProbs(model::PvlModel)
    p=exp.(model.θ*model.expected)
    p./sum(p)
end




    
  
