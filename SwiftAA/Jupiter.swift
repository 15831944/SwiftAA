//
//  Jupiter.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct GalileanMoon {
    private var details: KPCAAGalileanMoonDetails

    public var name: String
    
    public var MeanLongitude: Degrees { get { return self.details.MeanLongitude } }
    public var TrueLongitude: Degrees { get { return self.details.TrueLongitude } }
    public var TropicalLongitude: Degrees { get { return self.details.TropicalLongitude } }
    public var EquatorialLatitude: Degrees { get { return self.details.EquatorialLatitude } }

    public var radiusVector: AU { get { return self.details.r } }

    public var inTransit: Bool { get { return Bool(self.details.inTransit) } }
    public var inOccultation: Bool { get { return Bool(self.details.inOccultation) } }
    public var inEclipse: Bool { get { return Bool(self.details.inEclipse) } }
    public var inShadowTransit: Bool { get { return Bool(self.details.inShadowTransit) } }

    init(name: String, details: KPCAAGalileanMoonDetails) {
        self.name = name
        self.details = details
    }
    
    // TODO: Improve this by not returning KPCAA3DCoordinateComponents and also add doc.
    public func rectangularCoordinates(apparent: Bool = true) -> KPCAA3DCoordinateComponents {
        return (apparent == true) ? self.details.ApparentRectangularCoordinateComponents : self.details.TrueRectangularCoordinateComponents
    }
}

public struct Jupiter: Planet {
    private var physicalDetails: KPCAAPhysicalJupiterDetails

    public static var color: Color {
        get { return Color(red: 0.647, green:0.608, blue:0.576, alpha: 1.0) }
    }
    
    public private(set) var julianDay: JulianDay
    public private(set) var highPrecision: Bool

    public private(set) var Io: GalileanMoon
    public private(set) var Europa: GalileanMoon
    public private(set) var Ganymede: GalileanMoon
    public private(set) var Callisto: GalileanMoon
    
    public var moons: [GalileanMoon] {
        get { return [self.Io, self.Europa, self.Ganymede, self.Callisto] }
    }

    public init(julianDay: JulianDay, highPrecision: Bool = true) {
        self.julianDay = julianDay
        self.highPrecision = highPrecision
        
        let details = KPCAAGalileanMoons_CalculateDetails(julianDay, highPrecision)
        self.Io = GalileanMoon(name: "Io", details: details.Satellite1)
        self.Europa = GalileanMoon(name: "Europa", details: details.Satellite2)
        self.Ganymede = GalileanMoon(name: "Ganymede", details: details.Satellite3)
        self.Callisto = GalileanMoon(name: "Callisto", details: details.Satellite4)
        
        self.physicalDetails = KPCAAPhysicalJupiter_CalculateDetails(self.julianDay, self.highPrecision)
    }
    
    public init(date: NSDate, highPrecision: Bool = true) {
        self.init(julianDay: KPCAADate(gregorianCalendarDate: date).Julian(), highPrecision: highPrecision)
    }
    
    public var magnitude: Double { get { return KPCAAIlluminatedFraction_JupiterMagnitudeAA(self.radiusVector, self.apparentGeocentricDistance, self.phaseAngle) } }
    
    /// The planetocentric declination of the Earth. When it is positive, the planet' northern pole is tilted towards the Earth
    public var planetocentricDeclinationEarth: Degrees {
        return self.physicalDetails.DE
    }
    
    /// The planetocentric declination of the Sun. When it is positive, the planet' northern pole is tilted towards the Sun
    public var planetocentricDeclinationSun: Degrees {
        return self.physicalDetails.DS
    }

    /// See AA. ch 43, pp. 293-
    
    public var geometricCentralMeridianLongitudeSystemI: Degrees {
        return self.physicalDetails.Geometricw1
    }

    public var geometricCentralMeridianLongitudeSystemII: Degrees {
        return self.physicalDetails.Geometricw2
    }

    public var apparentCentralMeridianLongitudeSystemI: Degrees {
        return self.physicalDetails.Apparentw1
    }
    
    public var apparentCentralMeridianLongitudeSystemII: Degrees {
        return self.physicalDetails.Apparentw2
    }

    /// The position angle of the northern rotation pole of the planet
    public var positionAngleOfNorthernRotationPole: Degrees {
        return self.physicalDetails.P
    }
}
