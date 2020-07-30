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
                .frame(
                    width: CGFloat(CassetteDefinition.shellWidth) * scale.width,
                    height: CGFloat(CassetteDefinition.shellHeight) * scale.height,
                    alignment: .center)
            CassetteSpoolView(
                rotation: Angle(radians: renderSpec.spoolRotationLeft + .pi),
                tapeRadius: renderSpec.spoolRadiusLeft)
                .offset(
                    x: -CGFloat(CassetteDefinition.spoolDistance) * self.scale.width * 0.5,
                    y: 0)
            CassetteSpoolView(
                rotation: Angle(radians: -renderSpec.spoolRotationRight),
                tapeRadius: renderSpec.spoolRadiusRight)
                .offset(
                    x: CGFloat(CassetteDefinition.spoolDistance) * self.scale.width * 0.5,
                    y: 0)
        }
    }
}

struct CassetteSpoolView: View {
    let rotation: Angle
    let tapeRadius: CGFloat
    let scale = RenderConfiguration.currentConfiguration.pointsPerMillimeter

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
            Image("tape")
                .resizable()
                .frame(width: tapeRadius * 2 * scale.width,
                       height: tapeRadius * 2 * scale.height,
                       alignment: .center)
            }
            VStack(alignment: .center) {
            Image("spool")
                .resizable()
                .frame(width: CGFloat(CassetteDefinition.spoolRadius) * 2 * scale.width,
                       height: CGFloat(CassetteDefinition.spoolRadius) * 2 * scale.height,
                       alignment: .center)
                .rotationEffect(rotation)
            }
        }
    }
}

struct CassetteView_Previews: PreviewProvider {
    static var previews: some View {
        CassetteView(
            renderSpec: Cassette(type: .C90).currentRenderSpecification())
    }
}
