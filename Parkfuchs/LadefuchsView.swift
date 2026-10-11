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
            HeaderView(
                title: "Ladefuchs".uppercased(),
                subtitle: "Kennst Du schon den anderen Fuchs? Mit einem Fingerwischen zeigt Dir der Ladefuchs die günstigste Ladekarte an der Elektro-Ladesäule."
            )
            .padding(.bottom, -20.0)

            Image("Ladefuchs", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 420, maxHeight: 280)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    UIApplication.shared.open(ExternalURLs.ladefuchsURL)
                }
                .accessibilityLabel("Ladefuchs")
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
        }
    }
}

#Preview {
    LadefuchsView()
}
