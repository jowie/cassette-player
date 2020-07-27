import Foundation

public enum CassetteDefinition {
    case C46, C60, C90, C120

    public static let spoolRadius = 10.millimeters

    public var pureDuration: TimeInterval {
        switch self {
        case .C46: return 46.minutes
        case .C60: return 60.minutes
        case .C90: return 90.minutes
        case .C120: return 120.minutes
        }
    }

    public var tapeDuration: TimeInterval {
        tapeLength / Player.speed
    }

    /// The thickest tape normally used in cassettes is about 16 µm in thickness, and is used in C60 cassettes and in shorter lengths such as the C46.
    /// C90s are 10 to 11 μm
    /// (the less common) C120s are just 6 μm (0.24 mils) thick, rendering them more susceptible to stretching or breakage
    public var thickness: Double {
        switch self {
        case .C46, .C60: return 16.micrometers
        case .C90: return 11.2.micrometers
        case .C120: return 9.micrometers // Some sources say 6 µm
        }
    }

    public var tapeLength: Double {
        switch self {
        case .C46: return 68.meters // made up
        case .C60: return 90.meters // Maxell
        case .C90: return 132.meters // 135 generous, 129 tight
        case .C120: return 177.meters // made up
        }
    }
}

public enum CassetteSide {
    case A, B
}

class Cassette {
    public let type: CassetteDefinition
    public var playbackPosition = 0.minutes
    public var side = CassetteSide.A

    public init(type: CassetteDefinition) {
        self.type = type
    }
}
