//
//  Constants.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 18/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

typealias JulianDay=Double
typealias AU=Double // Astronomical Unit

// Check nested types in https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html
extension AU {
    var AU: Double { return self }
    var pc: Double { return self / 206264.80624548031 } // tan(1./3600.0*M_PI/180.)
    var km: Double { return self / 149597870.7 }
    var m:  Double { return self / 149597870700.0 }
}

extension KPCPlanetaryObject {
    func toString() -> String {
        switch self {
        case MERCURY:
            return "Mercury"
        case VENUS:
            return "Venus"
        case MARS:
            return "Mars"
        case JUPITER:
            return "Jupiter"
        case SATURN:
            return "Saturn"
        case URANUS:
            return "Uranus"
        case NEPTUNE:
            return "Neptune"
        }
    }
}