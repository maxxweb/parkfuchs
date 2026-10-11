//
//  MemberView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct MemberView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let members = [
        TeamMemberInfo.malik,
        TeamMemberInfo.dominic,
        TeamMemberInfo.sven,
        TeamMemberInfo.kay
    ]

    private var columns: [GridItem] {
        let count = horizontalSizeClass == .regular ? 2 : 1
        return Array(repeating: GridItem(.flexible(), spacing: 24), count: count)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderView(
                title: "Teamfuchs".uppercased(),
                subtitle: "Wir sind schuld. Wirklich! Trotzdem alle Angaben ohne Gewähr."
            )
            .padding([.bottom], 32)

            LazyVGrid(columns: columns, alignment: .leading, spacing: 24) {
                ForEach(members, id: \.name) { member in
                    TeammemberView(info: member)
                }
            }
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView()
            .previewLayout(.fixed(width: 400, height: 900))
            .previewDisplayName("Compact")

        MemberView()
            .previewLayout(.fixed(width: 900, height: 600))
            .previewDisplayName("Duo wide")
    }
}
