//
//  TimeView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 04/08/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI
import YotiFoundation

struct TimeView: View {
    var time: TimeInterval
    var body: some View {
        Text(formatted)
            .font(.system(.body, design: .monospaced))
    }

    var formatted: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        let value = Int((time - time.rounded(.down)) * 100)
        let remainder = String(format: "%02d", value)

        return formatter.string(from: TimeInterval(time))! + ".\(remainder)"
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(time: 5025.6)
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: ClosedRange<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
