"""
Run this script from shell as 
# JULIA_LOAD_PATH="/path/to/LoneParentsModel.jl/src:\$JULIA_LOAD_PATH" julia RunTests.jl

or within REPL

julia> push!(LOAD_PATH,"/path/to/SomeUtil.jl")
julia> include("RunTests.jl")
"""

using Test


using SomeUtil: read2DArray, date2yearsmonths, removefirst!, subtract! 


@testset "MultiAgents Components Testing" begin
    
    mutable struct Person 
        id::Int 
        pos 
    end 

    # List of persons 
    person1 = Person(1,"Edinbrugh") 
    person2 = person1               
    person3 = Person(2,"Abderdeen") 
    person4 = Person(3,"Edinbrugh") 
    person5 = Person(4,"Glasgow")
    person6 = Person(5,"Edinbrugh") 

    @testset verbose=true "Utilities" begin
   
        # reading matrix from file 
        T = read2DArray("./test23.csv")         
        @test size(T) == (2,3)
        @test  0.3434 - eps() < T[2,2] < .3434 + eps()

        # dictionary subtraction 
        param = Dict(:a=>1,:b=>[1,2],:c=>3.1,:s=>"msg") 
        paramab = subtract!([:a,:b],param) 
        @test issetequal(keys(paramab),[:a,:b])   
        @test issetequal(keys(param),[:s,:c])          
        @test_throws ArgumentError subtract!([:c,:d],param)
        parama  = [:a] - paramab
        @test issetequal(keys(parama),[:a]) 
        @test issetequal(keys(paramab),[:b])

        @test date2yearsmonths(1059 // 12) == (88 , 3)
        @test_throws ArgumentError   date2yearsmonths(1059 // 5)
        @test_throws ArgumentError   date2yearsmonths(-1059 // 5)

        
        arr = [person3, person2, person6] 
        removefirst!(arr, person2)
        @test arr[1] == person3  && arr[2] == person6 
        @test_throws ArgumentError removefirst!(arr,person5)  
         

    end # MultiAgents.Util


end  # testset MultiAgents components 