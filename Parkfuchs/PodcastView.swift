//
//  PodcastView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct PodcastView: View {
    var body: some View {
        VStack(alignment: .leading) {

            HeaderView(title: "Podcastfuchs".uppercased(), subtitle: "Gerne abonnieren, sonst ist der Fuchs ganz traurig.")
                .padding(.bottom, 12.0)
            HStack(spacing: 8.0) {
                Image("podcast_audiodump-600", bundle: nil).resizable().aspectRatio(contentMode: ContentMode.fit)
                    .frame(height: 120)
                    .onTapGesture {
                        UIApplication.shared.open(ExternalURLs.audiodumpURL)
                    }
                   .accessibilityLabel("Audiodump")
                   .accessibilityAddTraits(.isButton)
                   .accessibilityRemoveTraits(.isImage)
                Image("podcast_bitsundso-600", bundle: nil).resizable().aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 120)
                    .onTapGesture {
                        UIApplication.shared.open(ExternalURLs.bitsUndSoURL)
                    }
                   .accessibilityLabel("Bits und so")
                   .accessibilityAddTraits(.isButton)
                   .accessibilityRemoveTraits(.isImage)
                Spacer()

            }
        }
    }
}

struct PodcastView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastView().previewLayout(PreviewLayout.sizeThatFits)
        PodcastView().previewLayout(PreviewLayout.fixed(width: 650, height: 300))

    }
}
