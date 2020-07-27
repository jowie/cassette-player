//
//  Copyright (c) Yoti Ltd 2020.
//  All rights reserved.
//  See LICENSE.md for license.
//

import Foundation

extension TimeInterval {
    public var milliseconds: Self { self * TimeUnits.Conversion.secondsInMillisecond }
    public var millisecond: Self { milliseconds }

    public var seconds: Self { self }
    public var second: Self { self }

    public var minutes: Self { self * TimeUnits.Conversion.secondsInMinute }
    public var minute: Self { minutes }

    public var hours: Self { self * TimeUnits.Conversion.secondsInHour }
    public var hour: Self { hours }

    public var days: Self { self * TimeUnits.Conversion.secondsInDay }
    public var day: Self { days }
}

extension TimeInterval {
    public func toMilliseconds() -> Double {
        self * TimeUnits.Conversion.millisecondsInSecond
    }

    public func toMinutes() -> Double {
        self / TimeUnits.Conversion.secondsInMinute
    }
}
