using Printf, LinearAlgebra, Dates

include("SI.jl"); using .SI
include("AstrodynamicalConstants.jl"); using .AstrodynamicalConstants

# Exercise_2_1.cpp
# 
# Purpose: 
#
#   Satellite Orbits - Models, Methods, and Applications
#   Exercise 2-1: Orbit raising using Hohmann transfer
#   Last modified:
#   2026/11/08

h1 = 750*km
h2 = 775*km

r1 = R🜨 + h1
r2 = R🜨 + h2

v1 = sqrt(GM🜨/r1) # m/s
v2 = sqrt(GM🜨/r2) # m/s

at = (r1 + r2)/2
vp = sqrt(GM🜨*r2/(at*r1))
va = sqrt(GM🜨*r1/(at*r2))

printfq(h1, " Initial altitude     h1    = %.2f", km)
printfq(h2, " Final   altitude     h2    = %.2f", km)
printfq(v1, " Circular velocity    v1    = %.2f", m/s)
printfq(v2, " Circular velocity    v2    = %.2f", m/s)
printfq(v1 - v2, " Difference                 = %.2f", m/s)
# sma = semi-major axis
printfq(at, " Transfer orbit sma   at    = %.2f", km)
printfq(vp, " Pericenter velocity  vp    = %.2f", m/s)
printfq(va, " Apocenter  velocity  va    = %.2f", m/s)
printfq(vp-v1, " Difference           vp-v1 = %.2f", m/s)
printfq(v2-va, " Difference           v2-va = %.2f", m/s)
printfq(v2-va+vp-v1, " Total velocity diff.       = %.2f", m/s)
