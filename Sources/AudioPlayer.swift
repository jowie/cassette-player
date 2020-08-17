import AVFoundation

//struct AudioPlayer {
//    let audioEngine = AVAudioEngine()
//    let player = AVAudioPlayerNode()
//
//    private var buffer: AVAudioPCMBuffer!
//
//    init?() throws {
//        let url = Bundle.main.url(forResource: "archangel", withExtension: "mp3")!
//
//        let audioFile = try AVAudioFile(forReading: url)
//        guard let buffer = AVAudioPCMBuffer(
//            pcmFormat: audioFile.processingFormat,
//            frameCapacity: .init(audioFile.length)) else { return nil }
//
//        self.buffer = buffer
//        try audioFile.read(into: buffer)
//        audioEngine.attach(player)
//        audioEngine.connect(player, to: audioEngine.mainMixerNode, format: buffer.format)
//        try audioEngine.start()
//
//        player.play()
//        player.scheduleBuffer(buffer, at: nil, options: .loops)
////
////        let length = audioFile.length
////        let format = audioFile.processingFormat
//
//
//    }
//
//    func play() {
//        player.play()
//        player.scheduleBuffer(buffer, at: nil, options: .loops)
//    }
//}

import AVFoundation

final class AudioPlayer {
    var engine = AVAudioEngine()
    var player = AVAudioPlayerNode()
    var rateEffect = AVAudioUnitTimePitch()

    var audioFile: AVAudioFile? {
        didSet {
            if let audioFile = audioFile {
                audioLengthSamples = audioFile.length
                audioFormat = audioFile.processingFormat
                audioSampleRate = Float(audioFormat?.sampleRate ?? 44100)
                audioLengthSeconds = Float(audioLengthSamples) / audioSampleRate
            }
        }
    }
    var audioFileURL: URL? {
        didSet {
            if let audioFileURL = audioFileURL {
                audioFile = try? AVAudioFile(forReading: audioFileURL)
            }
        }
    }
    var audioBuffer: AVAudioPCMBuffer?

    // MARK: other properties
    var audioFormat: AVAudioFormat?
    var audioSampleRate: Float = 0
    var audioLengthSeconds: Float = 0
    var audioLengthSamples: AVAudioFramePosition = 0
    var needsFileScheduled = true
    let rateSliderValues: [Float] = [0.5, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0]
    var rateValue: Float = 1.0 {
        didSet {
            rateEffect.rate = rateValue
        }
    }
    var currentFrame: AVAudioFramePosition {
        guard let lastRenderTime = player.lastRenderTime,
            let playerTime = player.playerTime(forNodeTime: lastRenderTime) else {
                return 0
        }

        return playerTime.sampleTime
    }
    var seekFrame: AVAudioFramePosition = 0
    var currentPosition: AVAudioFramePosition = 0
    let pauseImageHeight: Float = 26.0
    let minDb: Float = -80.0

    enum TimeConstant {
        static let secsPerMin = 60
        static let secsPerHour = TimeConstant.secsPerMin * 60
    }

    // MARK: - ViewController lifecycle
    //
    init() {
        setupAudio()
    }
}

// MARK: - Actions
//
extension AudioPlayer {
    func setRateValue(_ value: Float) {
        rateValue = value
    }

    func play() {
        if currentPosition >= audioLengthSamples {
            updateUI()
        }

        if player.isPlaying {
            disconnectVolumeTap()
            player.pause()
        } else {
            connectVolumeTap()
            if needsFileScheduled {
                needsFileScheduled = false
                scheduleAudioFile()
            }
            player.play()
        }
    }

    func updateUI() {
        currentPosition = currentFrame + seekFrame
        currentPosition = max(currentPosition, 0)
        currentPosition = min(currentPosition, audioLengthSamples)

        let time = Float(currentPosition) / audioSampleRate

        if currentPosition >= audioLengthSamples {
            player.stop()
            disconnectVolumeTap()
        }
    }
}

// MARK: - Display related
//
extension AudioPlayer {
    func formatted(time: Float) -> String {
        var secs = Int(ceil(time))
        var hours = 0
        var mins = 0

        if secs > TimeConstant.secsPerHour {
            hours = secs / TimeConstant.secsPerHour
            secs -= hours * TimeConstant.secsPerHour
        }

        if secs > TimeConstant.secsPerMin {
            mins = secs / TimeConstant.secsPerMin
            secs -= mins * TimeConstant.secsPerMin
        }

        var formattedString = ""
        if hours > 0 {
            formattedString = "\(String(format: "%02d", hours)):"
        }
        formattedString += "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
        return formattedString
    }
}

// MARK: - Audio
//
extension AudioPlayer {
    func setupAudio() {
        audioFileURL  = Bundle.main.url(forResource: "archangel", withExtension: "mp3")

        engine.attach(player)
        engine.attach(rateEffect)
        engine.connect(player, to: rateEffect, format: audioFormat)
        engine.connect(rateEffect, to: engine.mainMixerNode, format: audioFormat)

        engine.prepare()

        do {
            try engine.start()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func scheduleAudioFile() {
        guard let audioFile = audioFile else { return }

        seekFrame = 0
        player.scheduleFile(audioFile, at: nil) { [weak self] in
            self?.needsFileScheduled = true
        }
    }

    func connectVolumeTap() {
        let format = engine.mainMixerNode.outputFormat(forBus: 0)
        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, when in

            guard let channelData = buffer.floatChannelData else {
                return
            }

            let channelDataValue = channelData.pointee
            let channelDataValueArray = stride(from: 0,
                                               to: Int(buffer.frameLength),
                                               by: buffer.stride).map{ channelDataValue[$0] }
            let fl = Float(buffer.frameLength)
            let rms = sqrt(channelDataValueArray.map{ $0 * $0 }.reduce(0, +) / fl)
            let avgPower = 20 * log10(rms)
            let meterLevel = self.scaledPower(power: avgPower)


            let volumeMeterHeight = CGFloat(
            min(
                (meterLevel * self.pauseImageHeight),
                self.pauseImageHeight))
        }
    }

    func scaledPower(power: Float) -> Float {
        guard power.isFinite else { return 0.0 }

        if power < minDb {
            return 0.0
        } else if power >= 1.0 {
            return 1.0
        } else {
            return (abs(minDb) - abs(power)) / abs(minDb)
        }
    }

    func disconnectVolumeTap() {
        engine.mainMixerNode.removeTap(onBus: 0)
    }

    func seek(to time: Float) {
        guard let audioFile = audioFile else {
            return
        }

        seekFrame = currentPosition + AVAudioFramePosition(time * audioSampleRate)
        seekFrame = max(seekFrame, 0)
        seekFrame = min(seekFrame, audioLengthSamples)
        currentPosition = seekFrame

        player.stop()

        if currentPosition < audioLengthSamples {
            updateUI()
            needsFileScheduled = false

            player.scheduleSegment(audioFile, startingFrame: seekFrame, frameCount: AVAudioFrameCount(audioLengthSamples - seekFrame), at: nil) { [weak self] in
                self?.needsFileScheduled = true
            }
        }
    }

}
