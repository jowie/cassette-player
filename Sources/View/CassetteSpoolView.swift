//
//  CassetteSpoolView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 03/08/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct CassetteSpoolView: View {
    let spoolRadius: CGFloat
    let tapeRadius: CGFloat
    let maxTapeRadius: CGFloat
    let rotation: Angle
    let scale = RenderConfiguration.currentConfiguration.pointsPerMillimeter

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                ZStack {
                    Image("tape")
                        .resizable()
                        .frame(
                            width: maxTapeRadius * 2 * scale.width,
                            height: maxTapeRadius * 2 * scale.height,
                            alignment: .center)
                        .frame(
                            width: tapeRadius * 2 * scale.width,
                            height: tapeRadius * 2 * scale.height,
                            alignment: .center)
                }
                .mask(
                    DonutView(holeRatio: spoolRadius / tapeRadius * 0.9))
            }
            VStack(alignment: .center) {
                Image("spool")
                    .resizable()
                    .frame(width: spoolRadius * 2 * scale.width,
                           height: spoolRadius * 2 * scale.height,
                           alignment: .center)
                    .rotationEffect(rotation)
            }
        }
    }
}

struct CassetteSpoolView_Previews: PreviewProvider {
    static var previews: some View {
        CassetteSpoolView(
            spoolRadius: 10.0,
            tapeRadius: 11.0,
            maxTapeRadius: 30.0,
            rotation: .init(degrees: 30))
    }
}
