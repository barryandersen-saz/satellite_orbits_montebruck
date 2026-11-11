using Printf, LinearAlgebra, Dates

include("SI.jl"); using .SI
include("AstrodynamicalConstants.jl"); using .AstrodynamicalConstants


#   Exercise 2-3: Osculating elements
# Based on Montenbruck and Gill,
# Satellite Orbits - Models, Methods, and Applications
#   2026/11/08

r⃗ = [10000, 40000, -5000]*km
v⃗ = r⃗̇ = [-1.5, 1.0, -0.1]*km/s
x, y, z = r⃗
r = norm(r⃗)
v = norm(v⃗)
h⃗ = r⃗×r⃗̇
h = norm(h⃗)
W⃗ = h⃗/h
i = atan(sqrt(W⃗[1]^2 + W⃗[2]^2), W⃗[3])*rad
Ω = atan(W⃗[1], -W⃗[2])*rad
p = h^2/GM🜨
a = (2/r - v^2/GM🜨)^-1
n = sqrt(GM🜨/a^3)
e = sqrt(1 - p/a)
E = atan((r⃗⋅r⃗̇)/(a^2*n), (1 - r/a))*rad
M = E - e*sin(E)*rad
u = atan(z, -x*W⃗[2] + y*W⃗[1])*rad
ν = atan(sqrt(1 - e^2)*sin(E), cos(E) - e)*rad
ω = mod(u - ν, 2*π*rad)

#printfq(h⃗)
#printfq(h)
#println(W⃗)
printfq(a, "a = %.3f", km)
@printf("e = %.7f\n", e)
printfq(i, "i = %.3f", deg)
printfq(Ω, "Ω = %.3f", deg)
printfq(ω, "ω = %.3f", deg)
#@printf("n = %.3e\n", n)
#printfq(E, "E = %.3f", deg)
printfq(M, "M = %.3f", deg)


