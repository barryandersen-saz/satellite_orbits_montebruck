using Printf, LinearAlgebra, Dates

# if modules in higher directory
include("SI.jl")
#include(joinpath(@__DIR__, "..", "FundamentalConstants.jl"))
#include(joinpath(@__DIR__, "..", "MolarMass.jl"))
#include(joinpath(@__DIR__, "..", "PlanetaryFacts.jl"))

using .SI
#using .FundamentalConstants
#using .MolarMass
#using .PlanetaryFacts

## if modules in same directory
#include("SI.jl"); using .SI
#include("FundamentalConstants.jl"); using .FundamentalConstants


#Α Β Γ Δ Ε Ζ Η Θ Ι Κ Λ Μ Ν Ξ Ο Π Ρ Σ Τ Υ Φ Χ Ψ Ω
#α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ σ τ υ ϕ χ ψ ω
#◌̂ U+0302, ◌⃗ U+20D7, ⃑  U+20d1,   ◌̅ U+0305, ◌̇ U+0307, ◌̈ U+0308, #ʹ U+02B9, ʺ U+02BA
#printfq(μ, "μ = %.2e", N*s/m^2)
#print("F⃗ = "); printfq(F⃗, "%.2f")
# × , ⋅ ,  ℯ = 2.718...
#   ☊ ☉ ☽ ☿ ♀ 🜨 ♂ ♃ ♄ ♅ ♆ ♇
##########################################################
dateUTC = DateTime(2000, 1, 1, 11, 58, 56, 200)
print("date (UTC) = ")
@printf("%s\n", Dates.format(dateUTC, "yyyy-mm-dd HH:MM:SS.sss"))

G = 6.67259e-11*m^3*kg^-1*s^-2
GM🜨 = 398600.4405*km^3*s^-2
M🜨 = GM🜨/G
printfq(M🜨, "M🜨 = %.3e", kg)

const g = 9.8*m/s^2
const ρair = 1.225*kg/m^3    #   15 °C
const ρH2O = 1000*kg/m^3
const ρsw = 1024*kg/m^3     #   seawater



#P = 1*atm
#T = uconvert(K, 0*degC)
#n = 1*mol
#V = n*R*T/P
#printfq(V, "Vol = %.3f", L)
#printfq(T, "T = %6.2f")
#printfq(T, "T = %6.2f", degC)

#println()

#constants = [c, 𝓮, h, ħ, G, R, Na, kB, σ, ε0, μ0, Me, Mp, Mn, eV]
#symbols = ["c", "𝓮", "h", "ħ", "G", "R", "Na", "kB", "σ", "ε0", "μ0", "Me", "Mp", "Mn", "eV"]

#for (sym, val) in zip(symbols, constants)
#     @printf("%-3s = ", sym); printfq(val,"%.6g")
#end

#for i in 1:length(constants)
#    @printf("%-3s = ", symbols[i])
#    printfq(constants[i], "%.2g")
#end

#println()

# rotation rate to get 1 g by spinning spacecraft of 100 m radius
r = 100*m
ω = sqrt(g/r)
v = ω*r
printfq(ω, "ω = %.2f", rpm)
printfq(v, "v = %.2f", km/hr)
println()

## 1 liter of water
#VH2O = 5*L
#MH2O = ρH2O*VH2O
#nH2O = MH2O/MMH2O
#NH2O = nH2O*Na
#printfq(nH2O, "n = %.1f", mol)
#printfq(NH2O, "N = %.2e molecules", NoUnits)


println()

## julia symbols
#×	U+000D7		Cross operator
#⋅	U+022C5		Dot Operator

#✖   U+2716    character not operator
#ꞏ   U+a78f    character not operator


println()
A⃗ = [1, 2, 3]
B⃗ = [4, 5, 6]
print("A⃗ = "); println(A⃗)
print("B⃗ = "); println(B⃗)

A⃗ꞏB⃗ = A⃗⋅B⃗
print("A⃗ꞏB⃗ = "); println(A⃗ꞏB⃗)
A⃗✖B⃗ = A⃗×B⃗
print("A⃗✖B⃗ = "); println(A⃗✖B⃗)
A = norm(A⃗)
print("A = ");@printf("%.4f\n", A)
print("A⃗^2 = ");println(A⃗.^2)
A⃗ꞏA⃗ = A⃗⋅A⃗ 
print("A⃗ꞏA⃗ == A^2 => ");println(A⃗ꞏA⃗ == A^2)
B = norm(B⃗)
θ = uconvert(deg, acos(A⃗ꞏB⃗/(A*B))*rad)
print("θ = "); printfq(θ,"%.2f")

Â = A⃗/A
print("Â = "); @printf("[%6.4f,%9.4f,%9.4f]\n", Â... );

print("acosd(Â) = "); printfq(acosd.(Â)*deg)

#print("τ̂ = "); @printf("[%6.4f,%9.4f,%9.4f]", τ̂... ); println("  direction cosines"
#println()
#for planet in planets
#    @printf("%-10s", planet.name)
#    printfq(planet.T, "%15.3f")
#end

