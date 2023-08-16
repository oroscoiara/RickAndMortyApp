//
//  EpisodeDetailViewController.swift
//  RickAndMorty-App
//
//  Created by Iara Denise Orosco on 13/08/2023.
//

import UIKit
import SwiftUI

/// Controller to show the detail of an episode.
class EpisodeDetailHostingController: UIHostingController<EpisodeDetailView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: EpisodeDetailView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episodes"
    }
}

struct EpisodeDetailView: View {
    @State internal var isGearTapped = false

    var body: some View {
        VStack {
            Text("Ups, work in progress. Come back soon!")
                .foregroundColor(.indigo)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .scaleEffect(isGearTapped ? 1.0 : 0.8)
                .opacity(isGearTapped ? 1 : 0)
                .animation(.easeInOut(duration: 1.0))

            Image(uiImage: UIImage(named: "RYM") ?? UIImage(systemName: "gearshape.2")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 220, height: 120)
                            .scaleEffect(isGearTapped ? 1.0 : 0.8)
                            .opacity(isGearTapped ? 1 : 0)
                            .animation(.easeInOut(duration: 1.0))


            Image(systemName: "gearshape.2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(isGearTapped ? .gray : .gray)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(isGearTapped ? 300 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isGearTapped.toggle()
                    }
                }

            Text("Tap the gear")
                .foregroundColor(.indigo)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

@available(iOS 13.0, *)
struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EpisodeDetailView()
        }
    }
}
