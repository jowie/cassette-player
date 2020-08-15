//
//  CassetteView.swift
//  Cassette
//
//  Created by Joe Nash on 24/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct CassetteView: View {

    @ObservedObject var viewModel: ViewModel

    init(renderSpec: Cassette.RenderSpecification) {
        viewModel = ViewModel(renderSpec: renderSpec)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .opacity(0.2)
                .frame(
                    width: viewModel.shellWidth,
                    height: viewModel.shellHeight,
                    alignment: .center)
            CassetteSpoolView(
                spoolRadius: viewModel.spoolRadius,
                tapeRadius: viewModel.spoolRadiusLeft,
                maxTapeRadius: viewModel.spoolMaxRadius,
                rotation: viewModel.spoolRotationLeft)
                .offset(
                    x: viewModel.leftSpoolX,
                    y: -12)
            CassetteSpoolView(
                spoolRadius: .init(CassetteDefinition.spoolRadius),
                tapeRadius: viewModel.spoolRadiusRight,
                maxTapeRadius: viewModel.spoolMaxRadius,
                rotation: viewModel.spoolRotationRight)
                .offset(
                    x: viewModel.rightSpoolX,
                    y: -12)
        }
    }
}

// MARK: - ViewModel
extension CassetteView {
    final class ViewModel: ObservableObject {
        let scale = RenderConfiguration.currentConfiguration.pointsPerMillimeter

        var renderSpec: Cassette.RenderSpecification

        init(renderSpec: Cassette.RenderSpecification) {
            self.renderSpec = renderSpec
        }

        let spoolRadius = CGFloat(CassetteDefinition.spoolRadius)

        var leftSpoolX: CGFloat {
             -CGFloat(CassetteDefinition.spoolDistance) * scale.width * 0.5
        }

        var rightSpoolX: CGFloat {
            CGFloat(CassetteDefinition.spoolDistance) * scale.width * 0.5
        }

        var shellWidth: CGFloat {
            CGFloat(CassetteDefinition.shellWidth) * scale.width
        }

        var shellHeight: CGFloat {
            CGFloat(CassetteDefinition.shellHeight) * scale.height
        }

        var spoolRadiusLeft: CGFloat {
            .init(renderSpec.spoolRadiusLeft)
        }
        var spoolRadiusRight: CGFloat {
            .init(renderSpec.spoolRadiusRight)
        }
        var spoolMaxRadius: CGFloat {
            .init(renderSpec.spoolMaxRadius)
        }
        var spoolRotationLeft: Angle {
            .init(radians: renderSpec.spoolRotationLeft + .pi)
        }
        var spoolRotationRight: Angle {
            .init(radians: -renderSpec.spoolRotationRight)
        }
    }
}

// MARK: - PreviewProvider
struct CassetteView_Previews: PreviewProvider {
    static var previews: some View {
        CassetteView(
            renderSpec: Cassette(type: .C90).currentRenderSpecification())
    }
}
