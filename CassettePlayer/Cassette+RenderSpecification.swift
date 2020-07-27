//
//  Cassette+RenderSpecification.swift
//  Cassette
//
//  Created by Joe Nash on 24/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import CoreGraphics
import SwiftUI

/// All time units are in seconds
/// All distance units are in mm

extension Cassette {
    struct RenderSpecification {
        let spoolRadiusLeft: CGFloat
        let spoolRadiusRight: CGFloat
        let spoolRotationLeft: Angle
        let spoolRotationRight: Angle
    }

    func currentRenderSpecification(isFlipped: Bool = false) -> RenderSpecification {
        let thickness = type.thickness

        let percentagePlayed = playbackPosition / type.tapeDuration
        print("percentagePlayed = \(percentagePlayed)")

        let spoolArea = pow(CassetteDefinition.spoolRadius, 2) * .pi

        let tapeArea = type.tapeLength * thickness //m squared
        let tapeAreaLeft = tapeArea * (1 - percentagePlayed)
        let tapeAreaRight = tapeArea * percentagePlayed

        let totalAreaLeft = tapeAreaLeft + spoolArea
        let totalAreaRight = tapeAreaRight + spoolArea

        let totalRadiusLeft = sqrt(totalAreaLeft / .pi)
        let totalRadiusRight = sqrt(totalAreaRight / .pi)

        let tapeRadiusLeft = totalRadiusLeft - CassetteDefinition.spoolRadius
        let tapeRadiusRight = totalRadiusRight - CassetteDefinition.spoolRadius

        let tapeLayersLeft = tapeRadiusLeft / thickness
        let tapeLayersRight = tapeRadiusRight / thickness

        let tapeRotationLeft = tapeLayersLeft * .pi * 2
        let tapeRotationRight = tapeLayersRight * .pi * 2

        return .init(
            spoolRadiusLeft: .init(totalRadiusLeft),
            spoolRadiusRight: .init(totalRadiusRight),
            spoolRotationLeft: .init(radians: tapeRotationLeft),
            spoolRotationRight: .init(radians: tapeRotationRight))
    }
}
