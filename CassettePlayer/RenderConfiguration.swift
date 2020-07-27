//
//  RenderConfiguration.swift
//  CassettePlayer
//
//  Created by Joe Nash on 27/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import AppKit

struct RenderConfiguration {
    let pointsPerMillimeter = NSScreen.main?.pointsPerMillimeter ?? CGSize(width: 72.0, height: 72.0)

    static let currentConfiguration = Self()
}
