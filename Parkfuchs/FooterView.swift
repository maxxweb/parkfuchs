//
//  FooterView.swift
//  Parkfuchs
//
//  Created by maxxweb on 04.11.23.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack(spacing: 8.0){
            Text("Handgefertigt aus ❤️ zur Elektromobilität in 👑 Aachen, ⚒️ Ahlen, 🏰 Ahrensburg und 🐻 Berlin").font(Font.ladefuchsItalic())
            Spacer()
        }
    }
}

#Preview {
    FooterView()
}
