module SI

using Unitful
#using UnitfulAssets    # for currency
using Printf

export @unit, ustrip, unit, Quantity, uconvert, NoUnits, dimension

export s, ms, mn, hr, dy, yr
export deg, rad, sr, rpm, turn, arcmin, arcsec
export nm, μm, mm, cm, m, km, Pm, AU
export L
export mg, gram, kg
export Nm
export Hz, kHz, MHz, GHz, THz
export K, degC
export J, kJ, MJ
export N, kN
export mW, W, kW, MW
export Wh
export Pa, mPa, hPa, kPa, MPa, GPa, atm
export mol, kmol
export μC, mC, C, Ah, mAh
export mA, A, kA
export mV, V, kV, MV
export μΩ, mΩ, Ω, kΩ, MΩ
export H
export S
export F
export mWh, Wh, kWh, MWh, GWh
#export USD, cent

export printfq

function __init__()
    Unitful.register(SI)
end

#######################################################

#   time
const s = u"s"
const ms = u"ms"
const mn = u"minute"
const hr = u"hr"
const dy = u"d"
const yr = u"yr"

#   angle measure
const deg = u"°"
const rad = u"rad"
const sr  = u"sr"
const rpm = u"rpm"
@unit turn   "turn"      Turn        2*π*u"rad"  false
@unit arcmin "arcmin"    Arcminute   u"°"//60    false
@unit arcsec "arcsec"    Arcsecond   u"°"//3600  false

#   length
const nm = u"nm"
const μm = u"μm"
const mm = u"mm"
const cm = u"cm"
const m  = u"m"
const km = u"km"
const Pm = u"Pm"
""" IAU 1976 value for AU as used in VSOP87 """
@unit   AU  "AU"    AstronomicalUnit    1.49597870e11*m  true


##   volume
const L = u"L"  # liter

#   mass
const mg = u"mg"
const gram = u"g"
const kg = u"kg"

#   frequency
const Hz = u"Hz"
const kHz = u"kHz"
const MHz = u"MHz"
const GHz = u"GHz"
const THz = u"THz"

#   temperature
const K = u"K"
const degC = u"°C"

#   force
const N = u"N"
const kN = u"kN"

#   torque
@unit Nm   "Nm"   NewtonMeter   1*N*m  false

#   power
const mW = u"mW"
const W = u"W"
const kW = u"kW"
const MW = u"MW"

#   energy
const J = u"J"
const kJ = u"kJ"
const MJ = u"MJ"
@unit Wh    "Wh"    WattHour        1*W*hr     false
@unit mWh   "mWh"   MilliWattHour   1e-3*W*hr  false
@unit kWh   "kWh"   KiloWattHour    1e3*W*hr   false
@unit MWh   "MWh"   MegaWattHour    1e6*W*hr   false
@unit GWh   "GWh"   GigaWattHour    1e9*W*hr   false

#   pressure
const Pa = u"Pa"
const mPa = u"mPa"
const hPa = u"hPa"
const kPa = u"kPa"
const MPa = u"MPa"
const GPa = u"GPa"

const atm = u"atm"

#   amount
const mol = u"mol"
@unit kmol  "kmol"  KiloMole    1000*u"mol"   false

#   ELECTROMAGNETISM
#       current
const mA = u"mA"
const A = u"A"
const kA = u"kA"

#       charge
const μC = u"μC"
const mC = u"mC"
const C = u"C"
@unit Ah     "Ah"    AmpereHour      1*A*hr          false
@unit mAh    "mAh"   MilliAmpereHour 1e-3*A*hr       false

#       voltage
const mV = u"mV"
const V = u"V"
const kV = u"kV"
const MV = u"MV"

#       resistance
const μΩ = u"μΩ"
const mΩ = u"mΩ"
const Ω = u"Ω"
const kΩ = u"kΩ"
const MΩ = u"MΩ"

#       inductance
const H = u"H"

#       conductance
const S = u"S"

#       capacitance
const F = u"F"

###########################################################
#const USD = u"USD"
#@unit cent    "cent"    Cent     u"USD"/100     false
##
############################################################
######################################################
# PRINTFQ UTILITIES
#######################################################

function _print_logic(val, u_str, fmt, nl)
    f = Printf.Format(fmt * " %s" * (nl ? "\n" : ""))
    Printf.format(f, val, u_str) |> print
end

fmtstr = "%.1f"


"""
    printfq(Q::Quantity, fmt::String=fmtstr, PU=unit(Q), nl=true)

    **Base Dispatch**: Prints a single physical quantity.
    - `fmt`: C-style format string for the magnitude.
    - `PU`: Preferred Unit for output (defaults to the current unit of Q).
    - `nl`: Boolean to include a newline.
"""
function printfq(Q::Quantity, fmt::String=fmtstr, PU=unit(Q), nl=true)
    Q_conv = uconvert(PU, Q)
    _print_logic(ustrip(Q_conv), string(unit(Q_conv)), fmt, nl)
end


"""
    printfq(Q::AbstractArray{<:Quantity}, fmt::String=fmtstr, PU=unit(first(Q)), nl=true)

    **Collection Dispatch**: Optimized for Vectors, Matrices, and Higher-Dimensional Arrays.
    This dispatch avoids manual loops in the user script and ensures all elements in a 
    tensor or list are converted to the same `PU` before printing as a formatted block.
"""
function printfq(Q::AbstractArray{<:Quantity}, fmt::String=fmtstr, PU=unit(first(Q)), nl=true)
    Q_conv = uconvert.(PU, Q)
    vals = ustrip.(Q_conv)
    u_str = string(unit(first(Q_conv)))
    
    print("[")
    for i in eachindex(vals)
        Printf.format(Printf.Format(fmt), vals[i]) |> print
        i < lastindex(vals) && print(", ")
    end
    print("] ", u_str, nl ? "\n" : "")
end

const superscripts = Dict(0=>'⁰', 1=>'¹', 2=>'²', 3=>'³', 4=>'⁴', 5=>'⁵', 6=>'⁶', 7=>'⁷', 8=>'⁸', 9=>'⁹')

function superscript(n::Int)
    s = string(abs(n))
    join(superscripts[parse(Int, d)] for d in s)
end


"""
**Type Dispatch (Engineering)**: Triggered by passing `Val(:eng)`.
Formats large values (e.g., `1.2×10⁶`) using powers-of-3 exponents with Unicode superscripts.
Standard for FPS engineering calculations (energy, stress).
"""
function printfq(Q::Quantity, ::Val{:eng}, sigdigits::Int=3, PU=unit(Q), nl=true)
    Q_conv = uconvert(PU, Q)
    val = ustrip(Q_conv)
    if val == 0
        output = "0"
    else
        exp3 = floor(Int, log10(abs(val)) / 3) * 3
        scaled = round(val / 10.0^exp3, sigdigits=sigdigits)
        sup_exp = superscript(exp3)
        output = "$scaled×10$sup_exp"
    end
    print(output, " ", unit(Q_conv), nl ? "\n" : "")
end



end # module SI


#    SI prefixes
#    quetta Q   10^30    1000000000000000000000000000000     2022
#    ronna  R   10^27    1000000000000000000000000000
#    yotta  Y   10^24    1000000000000000000000000   1991
#    zetta  Z   10^21    1000000000000000000000
#    exa    E   10^18    1000000000000000000     1975
#    peta   P   10^15    1000000000000000
#    tera   T   10^12    1000000000000   1960
#    giga   G   10^9     1000000000
#    mega   M   10^6     1000000     1873
#    kilo   k   10^3     1000    1795
#    hecto  h   10^2     100
#    deca   da  10^1     10
#    —      —   10^0     1   —
#    deci   d   10^−1    0.1     1795
#    centi  c   10^−2    0.01
#    milli  m   10^−3    0.001
#    micro  μ   10^−6    0.000001    1873
#    nano   n   10^−9    0.000000001     1960
#    pico   p   10^−12   0.000000000001
#    femto  f   10^−15   0.000000000000001   1964
#    atto   a   10^−18   0.000000000000000001
#    zepto  z   10^−21   0.000000000000000000001     1991
#    yocto  y   10^−24   0.000000000000000000000001
#    ronto  r   10^−27   0.000000000000000000000000001   2022
#    quecto q   10^−30   0.000000000000000000000000000001



#    #   ASTRONOMICAL CONSTANTS
#    au = 149597870700*m                 #   Astronomical Unit
#    @unit   au  "au"    AstronomicalUnit    149597870700*m  true
#    G = 6.67430e-11*m^3*kg^-1*s^-2      #   Gravitational Constant
#    dySid = 86164.09053083288*s         #   Sidereal Day
#    dyStel = 86164.098903691*s          #   Stellar Day
#    yrSid = 365.256363004*dy            #   Sidereal Year
#    yrTrop = 365.2421897*dy             #   Tropical Year, J2000
#    yrTrop = (365.2121896698 - 6.15359e-6*T - 7.29e-10*T^2 + 2.64e-10*T^3)*dy # Laskar
#    T = (JD - 2451545)/36525            #   Julian centuries from J2000

 

##   pc = parsec
##   S = r*θ # r = pc
#    S = 1*au
#    θ = 1*arcsec
#    r = S/θ
#    println(uconvert(Pm, r))

##    ly = lightyear
#    ly = c*yr      c from fundamental constants
#    println(uconvert(Pm, ly))

