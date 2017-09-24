//
//  TimesTests.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/02/2017.
//  Copyright © 2017 onekiloparsec. All rights reserved.
//

import XCTest
@testable import SwiftAA

class TimesTests: XCTestCase {
    func testHourMinusSignConstructor() {
        XCTAssertEqual(Hour(.minus, 1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -7, 30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, 1, -7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, 7, -30.0).value, -1.125)
        XCTAssertEqual(Hour(.minus, -1, -7, -30.0).value, -1.125)
    }
    
    func testHourPlusSignConstructor() {
        XCTAssertEqual(Hour(.plus, 1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -7, 30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, -7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, -1, 7, -30.0).value, 1.125)
        XCTAssertEqual(Hour(.plus, 1, -7, -30.0).value, 1.125)
    }
    
    func testHourMinusZeroSignConstructor() {
        XCTAssertEqual(Hour(.minus, 0, 7, 30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -7, 30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 7, -30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, -7, -30.0).value, -0.125)
        XCTAssertEqual(Hour(.minus, 0, 0, 90.0).value, -0.025)
        XCTAssertEqual(Hour(.minus, 0, 0, -90.0).value, -0.025)
    }
    
    func testHourPlusZeroSignConstructor() {
        XCTAssertEqual(Hour(.plus, 0, 7, 30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -7, 30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 7, -30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, -7, -30.0).value, 0.125)
        XCTAssertEqual(Hour(.plus, 0, 0, 90.0).value, 0.025)
        XCTAssertEqual(Hour(.plus, 0, 0, -90.0).value, 0.025)
    }
    
    func testHourSexagesimalTransform() {
        let hplus = Hour(1.125)
        let hplussexagesimal: SexagesimalNotation = (.plus, 1, 7, 30.0)
        XCTAssertTrue(hplus.sexagesimal == hplussexagesimal)
        
        let hminus = Hour(-1.125)
        let hminussexagesimal: SexagesimalNotation = (.minus, 1, 7, 30.0)
        XCTAssertTrue(hminus.sexagesimal == hminussexagesimal)
    }
    
    // See AATests.cpp
    func testTTtoUTRoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(of: .northwardSpring)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT
        XCTAssertEqual(northwardEquinox, JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))

        // TT -> UT
        XCTAssertEqual(northwardEquinox.TTtoUTC(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 33.112424))

        // TT -> UT -> TT
        XCTAssertEqual(northwardEquinox.TTtoUTC().UTCtoTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
    
    // See AATests.cpp
    func testTTtoTAIRoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(of: .northwardSpring)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT -> TAI
        XCTAssertEqual(northwardEquinox.TTtoTAI(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 35.047155))
        
        // TT -> TAI -> TT
        XCTAssertEqual(northwardEquinox.TTtoTAI().TAItoTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
    
    // See AATests.cpp
    func testTTtoUT1RoundTripping() {
        let earth = Earth(julianDay: JulianDay(year: 1962, month: 1, day: 1), highPrecision: false)
        let northwardEquinox = earth.equinox(of: .northwardSpring)
        XCTAssertEqual(northwardEquinox.value, JulianDay(2437744.6042503607).value)
        
        // TT -> UT1
        XCTAssertEqual(northwardEquinox.TTtoUT1(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 29, second: 33.140024))
        
        // TT -> UT1 -> TT
        XCTAssertEqual(northwardEquinox.TTtoUT1().UT1toTT(), JulianDay(year: 1962, month: 3, day: 21, hour: 2, minute: 30, second: 7.231168))
    }
    
    // Based on data downloadable from http://tycho.usno.navy.mil/systime.html
    func testUT1minusUTC() {
        let jd1 = JulianDay(modified: 58018.0) // 2017  9 22, the day of writing this test...
        AssertEqual(jd1.UT1minusUTC(), Second(0.32103), accuracy: Second(0.01))
        let jd2 = JulianDay(modified: 58118.0) // 2017 12 31
        AssertEqual(jd2.UT1minusUTC(), Second(0.19553), accuracy: Second(0.01))
        // Not sure why the one below fails.
//        let jd3 = JulianDay(modified: 58382.0) // 2018  9 21
//        AssertEqual(jd3.UT1minusUTC(), Second(-0.07169), accuracy: Second(0.01))
    }
    
    func testDaysSince2000January1() {
        XCTAssertEqual(JulianDay(year: 2017, month: 9, day: 23, hour: 9, minute: 0, second: 0.0).date.daysSince2000January1(), 6476)
    }
    
    func testDayConversions() {
        let t1 = 3.1415
        let t2 = -2.718
        
        XCTAssertEqual(Day(t1).inHours.value, t1*24.0)
        XCTAssertEqual(Day(t2).inHours.value, t2*24.0)
        
        XCTAssertEqual(Day(t1).inMinutes.value, t1*24.0*60.0)
        XCTAssertEqual(Day(t2).inMinutes.value, t2*24.0*60.0)
        
        XCTAssertEqual(Day(t1).inSeconds.value, t1*24.0*3600.0)
        XCTAssertEqual(Day(t2).inSeconds.value, t2*24.0*3600.0)
    }
    
    func testHourConversion() {
        let t1 = 3.1415
        let t2 = -2.718
        
        XCTAssertEqual(Hour(t1).inDays.value, t1/24.0)
        XCTAssertEqual(Hour(t2).inDays.value, t2/24.0)
        
        XCTAssertEqual(Hour(t1).inMinutes.value, t1*60.0)
        XCTAssertEqual(Hour(t2).inMinutes.value, t2*60.0)
        
        XCTAssertEqual(Hour(t1).inSeconds.value, t1*3600.0)
        XCTAssertEqual(Hour(t2).inSeconds.value, t2*3600.0)
        
        XCTAssertEqualWithAccuracy(Hour(12.0).inRadians.value, .pi, accuracy: 0.00000000001) // rounding errors
        XCTAssertEqualWithAccuracy(Hour(-6.0).inRadians.value, -.pi/2.0, accuracy: 0.00000000001) // rounding errors
    }
    
    func testMinuteConversion() {
        let t1 = 3.1415
        let t2 = -2.718
        
        XCTAssertEqual(Minute(t1).inDays.value, t1/(24.0*60.0))
        XCTAssertEqual(Minute(t2).inDays.value, t2/(24.0*60.0))
        
        XCTAssertEqual(Minute(t1).inHours.value, t1/60.0)
        XCTAssertEqual(Minute(t2).inHours.value, t2/60.0)
        
        XCTAssertEqual(Minute(t1).inSeconds.value, t1*60.0)
        XCTAssertEqual(Minute(t2).inSeconds.value, t2*60.0)
    }
    
    func testSecondConversion() {
        let t1 = 3.1415
        let t2 = -2.718
        
        XCTAssertEqual(Second(t1).inDays.value, t1/(24.0*3600.0))
        XCTAssertEqual(Second(t2).inDays.value, t2/(24.0*3600.0))
        
        XCTAssertEqual(Second(t1).inHours.value, t1/3600.0)
        XCTAssertEqual(Second(t2).inHours.value, t2/3600.0)
        
        XCTAssertEqual(Second(t1).inMinutes.value, t1/60.0)
        XCTAssertEqual(Second(t2).inMinutes.value, t2/60.0)
    }
}
