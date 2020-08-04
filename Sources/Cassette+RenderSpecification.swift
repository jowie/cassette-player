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
        let thickness = type.renderThickness

        let percentagePlayed = playbackPosition / type.tapeDuration

        let spoolArea = pow(CassetteDefinition.spoolRadius, 2) * .pi

        let tapeArea = type.tapeLength * thickness //m squared
        let tapeAreaLeft = tapeArea * (1 - percentagePlayed)
        let tapeAreaRight = tapeArea * percentagePlayed

        let totalAreaLeft = tapeAreaLeft + spoolArea
        let totalAreaRight = tapeAreaRight + spoolArea

        assert(totalAreaLeft > 0 && totalAreaRight > 0, "Cannot render, tape area less than zero")

        let maxRadius = sqrt((tapeArea + spoolArea) / .pi)
        let totalRadiusLeft = sqrt(totalAreaLeft / .pi)
        let totalRadiusRight = sqrt(totalAreaRight / .pi)

        let tapeRadiusLeft = totalRadiusLeft - CassetteDefinition.spoolRadius
        let tapeRadiusRight = totalRadiusRight - CassetteDefinition.spoolRadius

        let tapeLayersLeft = tapeRadiusLeft / thickness
        let tapeLayersRight = tapeRadiusRight / thickness

        let tapeRotationLeft = tapeLayersLeft * .pi * 2 - CassetteDefinition.spoolRotationOffset
        let tapeRotationRight = tapeLayersRight * .pi * 2 - CassetteDefinition.spoolRotationOffset

        return .init(
            spoolMaxRadius: maxRadius,
            spoolRadiusLeft: totalRadiusLeft,
            spoolRadiusRight: totalRadiusRight,
            spoolRotationLeft: tapeRotationLeft,
            spoolRotationRight: tapeRotationRight)
    }
}
