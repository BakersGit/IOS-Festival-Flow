import Foundation
import SwiftUI

struct ItemSplash:Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotation: CGFloat = 0
    var zindex: CGFloat = 0
    var extraOffset: CGFloat = -350
}

let items: [ItemSplash] = [
    .init(image: "fireworks",
          title: "Welcome to 'Festival Flow' traveler!",
          scale: 1
         ),
    .init(
        image: "calendar.and.person",
        title: "Keep track of awesome events all around the globe.",
        scale: 0.6,
        anchor: .topLeading,
        offset: -70,
        rotation: 30
    ),
    .init(
        image: "list.number.rtl",
        title: "Create and manage your own preperation lists.",
        scale: 0.5,
        anchor: .bottomLeading,
        offset: -60,
        rotation: -35
    ),
    .init(
        image: "lightbulb.min.badge.exclamationmark",
        title: "Get useful dynamic preperation suggestions.",
        scale: 0.4,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 160,
        extraOffset: -120
    ),
    .init(
        image: "gear.circle",
        title: "More Features in Progress.",
        scale: 0.35,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 250,
        extraOffset: -100
    )
    ]
