//
//  CassetteView.swift
//  Cassette
//
//  Created by Joe Nash on 24/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct CassetteView: View {
    var renderSpec: Cassette.RenderSpecification
    let scale = RenderConfiguration.currentConfiguration.pointsPerMillimeter
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .opacity(0.2)
                .frame(
                    width: CGFloat(CassetteDefinition.shellWidth) * scale.width,
                    height: CGFloat(CassetteDefinition.shellHeight) * scale.height,
                    alignment: .center)
            CassetteSpoolView(
                spoolRadius: .init(CassetteDefinition.spoolRadius),
                tapeRadius: .init(renderSpec.spoolRadiusLeft),
                maxTapeRadius: .init(renderSpec.spoolMaxRadius),
                rotation: Angle(radians: renderSpec.spoolRotationLeft + .pi))
                .offset(
                    x: -CGFloat(CassetteDefinition.spoolDistance) * self.scale.width * 0.5,
                    y: -12)
            CassetteSpoolView(
                spoolRadius: .init(CassetteDefinition.spoolRadius),
                tapeRadius: .init(renderSpec.spoolRadiusRight),
                maxTapeRadius: .init(renderSpec.spoolMaxRadius),
                rotation: Angle(radians: -renderSpec.spoolRotationRight))
                .offset(
                    x: CGFloat(CassetteDefinition.spoolDistance) * self.scale.width * 0.5,
                    y: -12)
        }
    }
}

struct CassetteView_Previews: PreviewProvider {
    static var previews: some View {
        CassetteView(
            renderSpec: Cassette(type: .C90).currentRenderSpecification())
    }
}
