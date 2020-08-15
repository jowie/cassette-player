//
//  ContentView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 24/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI
import YotiFoundation
struct ContentView: View {
    //@ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var player: Player

    var body: some View {
        ZStack {
            Image("background")
            player.cassette.map {
                CassetteView(renderSpec: $0.currentRenderSpecification())
                    .offset(x: 0, y: -30)
            }
            TimeView(time: displayTime)
                .offset(x: 0, y: 15)

            PlayerControlView()
                .offset(x: 0, y: 150)
                .onAppear(perform: playerViewDidAppear)

            if !hasCassette {
                Button(action: {
                    self.insertTape()
                }) {
                    Text("INSERT TAPE")
                }
                .offset(x: 0, y: -200)
            }

        }
    }

    func playerViewDidAppear() {
//        do {
//            try AudioPlayer()
//            //            player?.play()
//        } catch {
//            print(error)
//        }

    }
}

private extension ContentView {
    var displayTime: TimeInterval {
        if let cassette = player.cassette {
            return cassette.playbackPosition
        } else {
            return 0
        }
    }

    var hasCassette: Bool {
        return player.cassette != nil
    }

    func insertTape() {
        player.cassette = Cassette(type: .C90)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Player())
    }
}
