//
//  TeamView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.

import SwiftUI

struct TeamView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        if IPhoneDuo.isCurrent {
            NavigationStack {
                teamContent
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                dismiss()
                            } label: {
                                Label("Schließen", systemImage: "xmark")
                            }
                            .accessibilityLabel("Schließen")
                        }
                    }
            }
        } else {
            teamContent
        }
    }

    private var teamContent: some View {
        ZStack {
            Color.ladefuchsLightBackground.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                MainHeaderView()

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 0) {
                        MemberView()
                            .padding(.top, 20.0)
                            .padding(.bottom, 48.0)

                        MapView()
                            .padding(.bottom, 48.0)

                        PodcastView()
                            .padding(.bottom, 48.0)

                        InfoView()
                            .padding(.bottom, 48.0)

                        LadefuchsView()
                            .padding(.bottom, 10.0)

                        IlluView()
                            .padding(.bottom, 28.0)

                        LizenzView()
                            .padding(.bottom, 20.0)

                        FooterView()
                            .padding(.bottom, 10.0)

                        VersionView()
                            .padding(.bottom, 10.0)
                    }
                    .padding(.horizontal, 16)
                    .padding(.leading, 10)
                    .readableContentWidth()
                    .background(Color.ladefuchsLightBackground)
                }
            }
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
            .previewDisplayName("Standard")
        TeamView()
            .previewLayout(.fixed(width: 900, height: 1400))
            .previewDisplayName("Duo wide")
    }
}
