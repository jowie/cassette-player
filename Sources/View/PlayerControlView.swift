//
//  PlayerControlView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 06/08/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct PlayerControlView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        HStack {
            Button(action: { self.viewModel.play() }) {
                Text("▶️PLAY")
                    .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.viewModel.rewind() }) {
                Text("⏪REW")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.viewModel.fastForward() }) {
                Text("⏩F.FWD")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
            Button(action: { self.viewModel.stop() }) {
                Text("⏹STOP")
                .font(.system(size: 10, weight: .bold, design: Font.Design.monospaced))
            }
        }
    }
}

extension PlayerControlView {
    final class ViewModel: ObservableObject {
        func play() {
            Player.shared.play()
        }
        func stop() {
            Player.shared.stop()
        }
        func rewind() {
            Player.shared.rewind()
        }
        func fastForward() {
            Player.shared.fastForward()
        }
    }
}

struct PlayerControlView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlView()
    }
}
