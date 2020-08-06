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
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        ZStack {
            Image("background")

            if viewModel.hasCassette {
                CassetteView()
                    .offset(x: 0, y: -30)
                TimeView(time: Player.shared.cassette!.playbackPosition)
                    .offset(x: 0, y: 15)
            } else {
                TimeView(time: 0)
                    .offset(x: 0, y: 15)
            }

            PlayerControlView()
                .offset(x: 0, y: 150)
                .onAppear(perform: playerViewDidAppear)
        }
    }

    func playerViewDidAppear() {
        Player.shared.cassette = Cassette(type: .C90)

//        do {
//            try AudioPlayer()
//            //            player?.play()
//        } catch {
//            print(error)
//        }

    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        var hasCassette: Bool {
            Player.shared.cassette != nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
