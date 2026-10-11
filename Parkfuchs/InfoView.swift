//
//  InfoView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(
                title: "Infofuchs".uppercased(),
                subtitle: " Hier gibt es noch mehr Infos für Füchse. Schau vorbei bei Clean Electric"
            )
            Image("cleanelectric", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 280, maxHeight: 160)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    UIApplication.shared.open(ExternalURLs.cleanelectricURL)
                }
                .accessibilityLabel("Clean Electric")
                .accessibilityAddTraits(.isButton)
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.sizeThatFits)
    }
}
