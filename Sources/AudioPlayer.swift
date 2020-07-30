import AVFoundation

struct AudioPlayer {
    let audioEngine = AVAudioEngine()
    let player = AVAudioPlayerNode()

    private var buffer: AVAudioPCMBuffer!

    init?() throws {
        let url = Bundle.main.url(forResource: "archangel", withExtension: "mp3")!

        let audioFile = try AVAudioFile(forReading: url)
        guard let buffer = AVAudioPCMBuffer(
            pcmFormat: audioFile.processingFormat,
            frameCapacity: .init(audioFile.length)) else { return nil }

        self.buffer = buffer
        try audioFile.read(into: buffer)
        audioEngine.attach(player)
        audioEngine.connect(player, to: audioEngine.mainMixerNode, format: buffer.format)
        try audioEngine.start()

        player.play()
        player.scheduleBuffer(buffer, at: nil, options: .loops)
//
//        let length = audioFile.length
//        let format = audioFile.processingFormat


    }

    func play() {
        player.play()
        player.scheduleBuffer(buffer, at: nil, options: .loops)
    }
}
