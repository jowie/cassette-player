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

public extension NSScreen {
    var pointsPerMillimeter: CGSize {
        let screenDescription = deviceDescription
        guard let displayUnitSize = (screenDescription[NSDeviceDescriptionKey.size] as? NSValue)?.sizeValue,
            let screenNumber = (screenDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber)?.uint32Value else {
                // this is the same as what CoreGraphics assumes if no EDID data is available from the display device
                // https://developer.apple.com/documentation/coregraphics/1456599-cgdisplayscreensize?language=objc
                return .init(width: 72.0, height: 72.0)
        }
        let displayPhysicalSize = CGDisplayScreenSize(screenNumber)
        return .init(
            width: displayUnitSize.width / displayPhysicalSize.width,
            height: displayUnitSize.height / displayPhysicalSize.height)
    }
}
