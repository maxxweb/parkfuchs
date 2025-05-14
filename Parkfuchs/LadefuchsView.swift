//
//  LadefuchsView.swift
//  Parkfuchs
//
//  Created by maxxweb on 27.10.23.
//

import SwiftUI

struct LadefuchsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HeaderView(title: "Ladefuchs".uppercased(), subtitle: "Kennst Du schon den anderen Fuchs? Mit einem Fingerwischen zeigt Dir der Ladefuchs die günstigste Ladekarte an der Elektro-Ladesäule.")
                .padding(.bottom, -20.0)
            HStack(spacing: 8.0) {
                Image("Ladefuchs", bundle: nil).resizable().aspectRatio(contentMode: ContentMode.fit)
                    .frame(height: 200)
                    .onTapGesture {
                        UIApplication.shared.open(ExternalURLs.ladefuchsURL)
                    }
                    .accessibilityLabel("Ladefuchs")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityRemoveTraits(.isImage)

               Spacer()
            }
        }
    }
}

#Preview {
    LadefuchsView()
}
