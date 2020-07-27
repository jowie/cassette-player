//
//  Copyright (c) Yoti Ltd 2016.
//  All rights reserved.
//  See LICENSE.md for license.
//

import Foundation

public struct TimeUnits: Equatable {
    public var hours: Int
    public var minutes: Int
    public var seconds: Int

    public init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }

    public func timeInterval() -> TimeInterval {
        return Double(hours) * Conversion.secondsInHour
            + Double(minutes) * Conversion.secondsInMinute
            + Double(seconds)
    }

    public static func == (lhs: TimeUnits, rhs: TimeUnits) -> Bool {
        return lhs.hours == rhs.hours
            && lhs.minutes == rhs.minutes
            && lhs.seconds == rhs.seconds
    }
}

extension TimeUnits {
    public init(timeInterval: TimeInterval) {
        hours = Int(timeInterval / Conversion.secondsInHour)
        minutes = Int(timeInterval.truncatingRemainder(
            dividingBy: Conversion.secondsInHour) / Conversion.secondsInMinute)
        seconds = Int(timeInterval.truncatingRemainder(
            dividingBy: Conversion.secondsInMinute))
    }
}
