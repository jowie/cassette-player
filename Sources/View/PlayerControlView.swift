//
//  PlayerControlView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 06/08/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct PlayerControlView: View {
    @EnvironmentObject var player: Player
    var viewModel = ViewModel()

    var body: some View {
        HStack {
            Button(action: { self.player.play() }) {
                Text("▶️PLAY")
                    .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.player.rewind() }) {
                Text("⏪REW")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.player.fastForward() }) {
                Text("⏩F.FWD")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.player.stop() }) {
                Text("⏹STOP")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
        }
    }
}

extension PlayerControlView {
    final class ViewModel: ObservableObject {
        @EnvironmentObject var player: Player
        func play() {
            player.play()
        }
        func stop() {
            player.stop()
        }
        func rewind() {
            player.rewind()
        }
        func fastForward() {
            player.fastForward()
        }
    }
}

struct PlayerControlView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlView()
    }
}
