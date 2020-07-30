//
//  Double+Distance.swift
//  CassettePlayer
//
//  Created by Joe Nash on 27/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

/// Distance is a unit measured in millimeters
public typealias Distance = Double

extension Distance {
    public var micrometers: Self { self / 1000 }

    public var millimeters: Self { self }

    public var centimeters: Self { self * 10 }

    public var meters: Self { self * 1000 }
}
