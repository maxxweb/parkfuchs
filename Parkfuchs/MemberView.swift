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
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderView(title: "Teamfuchs".uppercased(),
                       subtitle: "Wir sind schuld. Wirklich! Trotzdem alle Angaben ohne Gewähr.")
                .padding([.bottom], 32)

            TeammemberView(info: TeamMemberInfo.malik)
            TeammemberView(info: TeamMemberInfo.dominic)
            TeammemberView(info: TeamMemberInfo.sven)
            TeammemberView(info: TeamMemberInfo.kay)
            
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static let height: CGFloat = 500

    static var previews: some View {
        ZStack {
            Color.accentColor.edgesIgnoringSafeArea(.all)
            MemberView()
        }
        .previewLayout(PreviewLayout.fixed(width: 400, height: height))
        .previewDisplayName("Preview with background")

        ZStack {
            MemberView()
        }
        .previewLayout(PreviewLayout.sizeThatFits)
        .previewDisplayName("Preview layout")
    }
}
