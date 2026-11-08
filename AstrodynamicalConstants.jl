module AstrodynamicalConstants

include("SI.jl"); using .SI

export c, G, AU
export GM🜨, M🜨, J2, R🜨e, R🜨p, R🜨, 𝓯, ω🜨, a🜨
export GM☉, AU, R☉, P☉
export GM☽, a☽, R☽

# pg N2

#Quantity    Value       References and Remarks
#TIME
#MJD(J2000)  51544.5     IAU 1976 (Seidelmann 1992)
#TT-TAI      32.184s    IAU 1991 (Seidelmann 1992)
#GPS-TAI     - 19 s      Hofmann-Wellenhof et al. (1997)

#UNIVERSAL
c   = 299792458*m/s   #IAU 1976 (Seidelmann 1992)
G = 6.67259e-11*m^3*kg^-1*s^-2
AU  = 149597870.691*km            #DE405 (Standish 1998)

#EARTH
GM🜨 = 398600.4415*km^3/s^2       #JGM-3
M🜨 = GM🜨/G
J2  = 0.00108263                  #JGM-3
R🜨e = 6378.137*km            # equatorial radius of Earth WGS-84
R🜨p = 6356.752*km             # polar radius of Earth
R🜨  = 6371.001*km    # Volumetric mean radius,  cbrt(R🜨e^2 * R🜨p)
𝓯   = 1/298.257223563         #WGS-84 (NIMA 1997)
ω🜨  = 0.7292115e-4*rad/s       #Moritz 1980
a🜨  = 149598261*km         #  semimajor axis of the Earth's orbit

#SUN
GM☉  = 1.32712440018e11*km^3/s^2  #DE405 (Standish 1998)
R☉   = 6.96e5*km             #Seidelmann 1992
P☉   = 4.560e-6*N/m^2        #IERS 1996 (McCarthy 1996)

#MOON
GM☽  = 4902.801*km^3/s^2     # DE405 (Standish 1998)
a☽   = 384400*km           #Seidelmann 1992
R☽   = 1738*km              #Seidelmann 1992

#SATELLITES
#rGEO    42164km             23h 56m 04s orbitaJ period
#VGEO    3.075km/s
#rGPS    26561 km            11h 58m 02s orbital period
#VGPS    3.874km/s
#rLEO   6678 . .. 7878 km   300 ... 1500 km altitude
#VLEO    7.726 ... 7.113km/s


#DE405 constants refer to the TDB time system

end #module AstrodynamicalConstants
