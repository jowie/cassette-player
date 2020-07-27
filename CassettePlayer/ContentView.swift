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
        CassetteView(renderSpec: cassette.currentRenderSpecification())
        .onAppear(perform: cassetteViewDidAppear)
    }

    func cassetteViewDidAppear() {
        do {
            try AudioPlayer()
            //            player?.play()
        } catch {
            print(error)
        }

        cassette.playbackPosition = 20.minutes

//        let cassette = Cassette(type: .C90)
//        cassette.side = .B
//        cassette.playbackPosition = 0.minutes
//        let renderSpec = cassette.currentRenderSpecification()
//        print(renderSpec.spoolRadiusLeft)
//        print(renderSpec.spoolRadiusRight)
//        print(renderSpec.spoolRotationLeft)
//        print(renderSpec.spoolRotationRight)

        print(cassette.currentRenderSpecification().spoolRadiusLeft)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
