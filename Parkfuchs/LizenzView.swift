//
//  LizenzView.swift
//  Parkfuchs
//
//  Created by maxxweb on 04.11.23.
//

import SwiftUI

struct LizenzView: View {
    var body: some View {
        HStack(spacing: 8.0){
            HeaderView(title: "Drittlizenzen".uppercased(), subtitle: "Momentan keine!")
            Spacer()
        }
    }
}

#Preview {
    LizenzView()
}
