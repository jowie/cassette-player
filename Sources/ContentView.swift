//
//  ContentView.swift
//  CassettePlayer
//
//  Created by Joe Nash on 24/07/2020.
//  Copyright © 2020 Joe Nash. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cassette = Cassette(type: .C90)

    var body: some View {
        ZStack {
            Image("background")
            CassetteView(renderSpec: cassette.currentRenderSpecification())
            .offset(x: 0, y: -30)
                .onAppear(perform: cassetteViewDidAppear)
        }
    }

    func cassetteViewDidAppear() {
        let startDate = Date()

        Timer.scheduledTimer(withTimeInterval: 1.0 / FPS.default, repeats: true) { _ in
            let ti = Date().timeIntervalSince(startDate)
            self.cassette.playbackPosition = ti + 46.minutes
        }

//        do {
//            try AudioPlayer()
//            //            player?.play()
//        } catch {
//            print(error)
//        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
