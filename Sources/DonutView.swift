//
//  DonutView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 03/08/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct DonutView: View {
    let holeRatio: CGFloat

    var body: some View {
        GeometryReader { g in
            Circle()
                .fill(Color.black)
                .mask(self.HoleShapeMask(
                    width: g.size.width,
                    height: g.size.height)
                    .fill(style: FillStyle(eoFill: true)))

        }
    }

    func HoleShapeMask(width: CGFloat, height: CGFloat) -> Path {
        let innerOffset = 0.5 - holeRatio * 0.5
        
        var shape = Rectangle().path(in: .init(
            x: 0, y: 0, width: width, height: height))
        shape.addPath(Circle().path(in: .init(
            x: width * innerOffset,
            y: height * innerOffset,
            width: width * holeRatio,
            height: height * holeRatio)))
        return shape
    }
}

struct DonutView_Previews: PreviewProvider {
    static var previews: some View {
        DonutView(holeRatio: 0.8)
            .frame(width: 50, height: 50, alignment: .center)
    }
}
