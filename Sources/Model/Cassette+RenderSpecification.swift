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

extension CassetteDefinition {
    var renderThickness: Double {
        pureThickness * 1.2
    }
}

enum RenderError: Error {
    case tapeAreaLessThanZero
}

extension Cassette {
    struct RenderSpecification {
        let spoolMaxRadius: Double
        let spoolRadiusLeft: Double
        let spoolRadiusRight: Double
        let spoolRotationLeft: Double
        let spoolRotationRight: Double
    }

    func currentRenderSpecification(isFlipped: Bool = false) -> RenderSpecification {
        let percentagePlayed = playbackPosition / type.tapeDuration

        let spoolArea = pow(CassetteDefinition.spoolRadius, 2) * .pi

        let tapeArea = type.tapeLength * type.renderThickness //m squared
        let tapeAreaLeft = tapeArea * (1 - percentagePlayed)
        let tapeAreaRight = tapeArea * percentagePlayed

        let totalAreaLeft = spoolArea + tapeAreaLeft
        let totalAreaRight = spoolArea + tapeAreaRight

        assert(totalAreaLeft > 0 && totalAreaRight > 0, "Cannot render, tape area less than zero")

        let maxRadius = radius(fromArea: tapeArea + spoolArea)
        let totalRadiusLeft = radius(fromArea: totalAreaLeft)
        let totalRadiusRight = radius(fromArea: totalAreaRight)

        let tapeRotationLeft = rotation(fromTotalRadius: totalRadiusLeft)
        let tapeRotationRight = rotation(fromTotalRadius: totalRadiusRight)

        return .init(
            spoolMaxRadius: maxRadius,
            spoolRadiusLeft: totalRadiusLeft,
            spoolRadiusRight: totalRadiusRight,
            spoolRotationLeft: tapeRotationLeft,
            spoolRotationRight: tapeRotationRight)
    }

    func radius(fromArea area: Double) -> Double {
        sqrt(area / .pi)
    }

    func rotation(fromTotalRadius radius: Double) -> Double {
        let tapeRadius = radius - CassetteDefinition.spoolRadius
        let tapeLayers = tapeRadius / type.renderThickness
        return tapeLayers * .pi * 2 - CassetteDefinition.spoolRotationOffset
    }

//    func totalArea(fr)
}
