//
//  KPCAABinaryStar.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct KPCAABinaryStarDetails {
    double r;
    double Theta;
    double Rho;
} KPCAABinaryStarDetails;

/** Units:
 * t (time): decimal years
 * P (Period): mean solar years
 * T (time of periastron): decimal year
 * e (eccentricity): n.a.
 * a (semi major axis): arcseconds
 * i (inclination): degrees
 * Omega (position angle of ascending nodes): degrees
 * w (longitude of periastron): degrees
 */
KPCAABinaryStarDetails KPCAABinaryStarCalculateDetails(double t, double P, double T, double e, double a, double i, double Omega, double w);

/** Units:
 * e: n.a.
 * i: degrees
 * w: degrees
 */
double KPCAABinaryStarApparentEccentricity(double e, double i, double w);
