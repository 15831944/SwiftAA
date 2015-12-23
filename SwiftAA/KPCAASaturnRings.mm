//
//  KPCAASaturnRings.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Copyright (c) 2015 onekiloparsec. All rights reserved.
//

#import "KPCAASaturnRings.h"
#import "AASaturnRings.h"

KPCAASaturnRingDetails KPCAASaturnRings(double JD, BOOL highPrecision)
{
    CAASaturnRingDetails details = CAASaturnRings::Calculate(JD, highPrecision);
    KPCAASaturnRingDetails results;
    results.B = details.B;
    results.Bdash = details.Bdash;
    results.P = details.P;
    results.a = details.a;
    results.b = details.b;
    results.DeltaU = details.DeltaU;
    return results;
}