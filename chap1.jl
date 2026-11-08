using Printf, LinearAlgebra
push!(LOAD_PATH, pwd())

using SI, AstrodynamicalConstants

#constants = [c, G, AU, GM🜨, M🜨, J2, R🜨e, R🜨p, R🜨, 𝓯, ω🜨, a🜨, GM☉, R☉, P☉, GM☽, a☽, R☽]
#symbols = ["c", "G", "AU", "GM🜨", "M🜨", "J2", "R🜨e", "R🜨e", "R🜨", "𝓯", "ω🜨", "a🜨",  "GM☉", "R☉", "P☉", "GM☽", "a☽", "R☽"]
#for i in 1:length(constants)
#     @printf("%-4s = ", symbols[i]), printfq(constants[i],"%.7g")
#end

#r = norm(𝗿)
#𝗿̂ = 𝗿/r
#𝗿̈ = -GM🜨*𝗿̂/r^2 = -GM🜨*𝗿/r^3

# pg 21
hp = 320*km         # altitude at perigee
ha = 35786*km       # altitude at apogee
a = ((R🜨e + hp) + (R🜨e + ha))/2 # semimajor axis
e = 0.726           # eccentricity
vper = sqrt(GM🜨/a)*sqrt((1+e)/(1-e))
vapo = sqrt(GM🜨/a)*sqrt((1-e)/(1+e))
printfq(a)
printfq(vper)
printfq(vapo)
