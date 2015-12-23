//
//  KPCAAAberration.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 04/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAAAberration.h"
#import "AAAberration.h"

KPCAA3DCoordinateComponents EarthVelocity(double JD)
{
    CAA3DCoordinate coords = CAAAberration::EarthVelocity(JD);
    return KPCAA3DCoordinateComponentsMake(coords.X, coords.Y, coords.Z);
}

KPCAA2DCoordinateComponents EclipticAberrationForAlpha(double Alpha, double Delta, double JD)
{
    CAA2DCoordinate coords = CAAAberration::EclipticAberration(Alpha, Delta, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}

KPCAA2DCoordinateComponents EquatorialAberrationForLambda(double Lambda, double Beta, double JD)
{
    CAA2DCoordinate coords = CAAAberration::EquatorialAberration(Lambda, Beta, JD);
    return KPCAA2DCoordinateComponentsMake(coords.X, coords.Y);
}
