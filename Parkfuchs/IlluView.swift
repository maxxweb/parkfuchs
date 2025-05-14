//
//  IlluView.swift
//  Parkfuchs
//
//  Created by maxxweb on 04.11.23.
//

import SwiftUI

struct IlluView: View {
    var body: some View {
        HStack(spacing: 8.0){
            HeaderView(title: "Illufüchse".uppercased(), subtitle: "Illustriert mit ❤️ von Aga und Marcel-André")
            Spacer()
        }
    }
}

#Preview {
    IlluView()
}
