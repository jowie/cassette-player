//
//  Copyright (c) Yoti Ltd 2020.
//  All rights reserved.
//  See LICENSE.md for license.
//

import Foundation
import YotiFoundation

extension TimeInterval {
    public func toMinutes() -> Double {
        self / TimeUnits.Conversion.secondsInMinute
    }
}
