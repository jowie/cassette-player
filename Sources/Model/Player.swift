import Foundation
import Combine

final class Player: ObservableObject {
    static let speed = 4.7625.centimeters // per second

    var anyCancellable: AnyCancellable?
    var isAutoReverse = false
    var timer: Timer?
    var state = State.stopped

    enum State {
        case stopped, playing, forwarding, rewinding
    }
    
    @Published var cassette: Cassette? {
        didSet {
            guard let cassette = cassette else { return }
            anyCancellable = cassette.objectWillChange.sink { _ in
                self.objectWillChange.send()
            }
        }
    }

    func play() {
        guard let cassette = cassette, state != .playing else { return }

        state = .playing

        let startDate = Date(timeIntervalSinceNow: -cassette.playbackPosition)

        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 1.0 / FPS.default, repeats: true) { _ in
            let ti = Date().timeIntervalSince(startDate)
            cassette.setPlaybackPosition(ti)
        }
    }

    func fastForward() {
        guard let cassette = cassette else { return }

        state = .forwarding

        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 1.0 / FPS.default, repeats: true) { _ in
            let renderSpec = cassette.currentRenderSpecification()
            let rewindSpeed = renderSpec.spoolRadiusRight * 0.01
            cassette.setPlaybackPosition(cassette.playbackPosition + rewindSpeed)
        }
    }

    func rewind() {
        guard let cassette = cassette else { return }

        state = .rewinding

        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 1.0 / FPS.default, repeats: true) { _ in
            let renderSpec = cassette.currentRenderSpecification()
            let rewindSpeed = renderSpec.spoolRadiusLeft * 0.01
            cassette.setPlaybackPosition(cassette.playbackPosition - rewindSpeed)
        }
    }

    func stop() {
        state = .stopped

        timer?.invalidate()
        timer = nil
    }

    func eject() {
        stop()
        cassette = nil
    }
}
