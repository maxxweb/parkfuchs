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
            HeaderView(title: "Infofuchs".uppercased(), subtitle: " Hier gibt es noch mehr Infos für Füchse. Schau vorbei bei Clean Electric")
            HStack(spacing: 8.0){
                Image("cleanelectric", bundle: nil).resizable().aspectRatio(contentMode: ContentMode.fit)
                    .frame(height: 120)
                    .onTapGesture {
                        UIApplication.shared.open(ExternalURLs.cleanelectricURL)
                    }
                Spacer()
            }
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.sizeThatFits)
    }
}
