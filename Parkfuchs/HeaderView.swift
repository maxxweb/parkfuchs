//
//  HeaderView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(title)
                .font(Font.ladefuchsHeader())
                .foregroundColor(Color.ladefuchsOrange)
                .padding(.bottom, 4.0)
            Text(subtitle)
                .font(Font.ladefuchsItalic())
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "TEAMFUCHS", subtitle: "Wir sind schuld. Wirklich!")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview 1")
        HeaderView(title: "Podcastfuchs".uppercased(), subtitle: "Abonnieren Sie, sonst ist der Fuchs traurig.")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview 2")
    }
}
