using Printf, LinearAlgebra, Dates

include("SI.jl"); using .SI
include("AstrodynamicalConstants.jl"); using .AstrodynamicalConstants
##########################################################


#alt = 320*km
#a = R🜨 + alt
#v = sqrt(GM🜨/a) # 2.26 pg 20
#T = 2*π*a/v     # 2.27 pg 20
#printfq(v, "v = %.2f", km/s)
#printfq(T, "T = %.1f", mn)

alt = 35786*km
a = R🜨 + alt
v = sqrt(GM🜨/a) # 2.26 pg 20
T = 2*π*a/v     # 2.27 pg 20
printfq(v, "v = %.2f", km/s)
printfq(uconvert(hr, T), "T = %.3f", hr)
