//
//  MainHeaderView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct MainHeaderView: View {
    @Environment(\.dismiss) private var dismiss

    /// On iPhone Duo the close control lives in the system toolbar (vertical bar).
    private var showsInlineCloseButton: Bool { !IPhoneDuo.isCurrent }

    private let logoHeight: CGFloat = 50

    var body: some View {
        ZStack {
            Color.accentColor

            HStack {
                Spacer()
                Image("parkfuchs")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: logoHeight)
                    .accessibilityLabel("Parkfuchs")
                Spacer()

                if showsInlineCloseButton {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                            .padding(4)
                            .background(Color.ladefuchsDarkGrayBackground)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Schließen")
                }
            }
            .padding(.horizontal, 15.0)
        }
        // Header ends exactly at the logo bottom (no extra bottom padding).
        .frame(height: logoHeight)
        .frame(maxWidth: .infinity)
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView()
    }
}
