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
    
    var body: some View {
        HStack {
            CassetteSpoolView(rotation: renderSpec.spoolRotationLeft, tapeRadius: renderSpec.spoolRadiusLeft)
                .padding(50)
            CassetteSpoolView(rotation: renderSpec.spoolRotationRight, tapeRadius: renderSpec.spoolRadiusRight)
                .padding(50)
        }
    }
}

struct CassetteSpoolView: View {
    var rotation: Angle
    var tapeRadius: CGFloat
    let scale = RenderConfiguration.currentConfiguration.pointsPerMillimeter

    var body: some View {
        ZStack {
            Image("tape")
                .resizable()
                .frame(width: tapeRadius * 2 * scale.width,
                       height: tapeRadius * 2 * scale.height)
            Image("spool")
                .resizable()
                .scaledToFit()
                .frame(width: CGFloat(CassetteDefinition.spoolRadius) * 2 * scale.width,
                       height: CGFloat(CassetteDefinition.spoolRadius) * 2 * scale.height)
                .rotationEffect(rotation)
        }
    }
}

struct CassettePlayground_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
