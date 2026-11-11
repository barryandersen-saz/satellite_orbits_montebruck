using Printf, LinearAlgebra, Dates

include("SI.jl"); using .SI
include("AstrodynamicalConstants.jl"); using .AstrodynamicalConstants


# Exercise 2-2: Solution of Kepler's equation
# Based on Montenbruck and Gill,
# Satellite Orbits - Models, Methods, and Applications
#   2026/11/08

# Compute the reference eccentric anomaly
function ecc_anom(M, e)
    E = M

    for i in 1:100
        delta = (E - e*sin(E) - M) / (1.0 - e*cos(E))
        E -= delta

        if abs(delta) < 1.0e-14
            return E
        end
    end

    error("Eccentric anomaly did not converge")
end

function main()

    # Variables
    MeanAnom = [4.0, 50.0]  # [deg]

    for M_deg in MeanAnom

        # Test case
        M = deg2rad(M_deg)
        e = 0.72
        E_ref = ecc_anom(M, e)

        # Header
        println("Exercise 2-2: Solution of Kepler's equation")
        println()

        @printf("  M =%14.11f\n", M)
        @printf("  e =%14.11f\n", e)
        @printf("  E =%14.11f\n", E_ref)

        # a) Newton's iteration
        println()
        println("  a) Newton's iteration")
        println()
        println("  i         E         Accuracy  sin/cos")

        E = M
        i = 0

        while true
            i += 1

            E = E - (E - e*sin(E) - M) /
                    (1.0 - e*cos(E))

            @printf("%3d%16.11f%11.2e%6d\n",
                    i, E, abs(E-E_ref), 2*i)

            if abs(E-E_ref) <= 1.0e-10
                break
            end
        end

        # b) Fixed-point iteration
        println()
        println("  b) Fixed point iteration")
        println()
        println("  i         E         Accuracy  sin/cos")

        E = M
        i = 0

        while true
            i += 1

            E = M + e*sin(E)

            @printf("%3d%16.11f%11.2e%6d\n",
                    i, E, abs(E-E_ref), i)

            if abs(E-E_ref) <= 1.0e-10
                break
            end
        end

        println("\n")
    end
end

main()

