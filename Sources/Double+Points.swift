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
