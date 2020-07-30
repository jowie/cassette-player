//
//  Copyright © 2018 Yoti Ltd. All rights reserved.
//

import Foundation

struct FPS {
    static let `default` = 60.0
}

public extension Int {
    var frames: TimeInterval { return Double(self) / FPS.default }
    var frame: TimeInterval { return self.frames }
}
