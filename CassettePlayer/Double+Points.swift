//
//  Copyright © 2019 Yoti Ltd. All rights reserved.
//

import CoreGraphics
import AppKit

public typealias PointSize = CGFloat

public extension Double {
    var points: PointSize { return PointSize(self) }
    var point: PointSize { return self.points }
    var pixels: PointSize { return CGFloat(self) / (NSScreen.main?.backingScaleFactor ?? 1) }
    var pixel: PointSize { return self.pixels }
}

/// Distance is a unit measured in millimeters
public typealias Distance = Double

extension Distance {
    public var micrometers: Self { self / 1000 }

    public var millimeters: Self { self }

    public var centimeters: Self { self * 10 }

    public var meters: Self { self * 1000 }
}


extension Distance {
    public func toPoints() -> Double {
        self * TimeUnits.Conversion.millisecondsInSecond
    }
}

public extension NSScreen {
    var pointsPerMillimeter: CGSize {
        let screenDescription = deviceDescription
        if let displayUnitSize = (screenDescription[NSDeviceDescriptionKey.size] as? NSValue)?.sizeValue,
            let screenNumber = (screenDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber)?.uint32Value {
            let displayPhysicalSize = CGDisplayScreenSize(screenNumber)
            return CGSize(width: displayUnitSize.width / displayPhysicalSize.width,
                          height: displayUnitSize.height / displayPhysicalSize.height)
        } else {
            return CGSize(width: 72.0, height: 72.0) // this is the same as what CoreGraphics assumes if no EDID data is available from the display device — https://developer.apple.com/documentation/coregraphics/1456599-cgdisplayscreensize?language=objc
        }
    }
}
