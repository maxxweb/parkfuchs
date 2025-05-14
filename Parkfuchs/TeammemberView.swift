//
//  TeammemberView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct TeammemberView: View {
    let info: TeamMemberInfo
    let circleSize: CGFloat = 128
    @State private var showActionSheet = false

    var body: some View {

        HStack {
            Image(info.imagename, bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: circleSize, height: circleSize, alignment: Alignment.center)
                .padding([.trailing], nil)
                .padding(.trailing, 8.0)
                .accessibilityHidden(true)
  
            VStack(alignment: .leading, spacing: 0) {
                Text(info.name.uppercased())
                    .font(Font.ladefuchsHeader())
                    .foregroundColor(Color.ladefuchsOrange)
                    .padding(.bottom, 0.0)
                
                Text(info.job).font(Font.ladefuchsItalic())
                    .padding(.bottom, 12.0)
                // Optionals
                if let mastodon = info.mastodonName {
                    HStack {
                        Image ("icon_masto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(.bottom, 6.0)
                           // .clipShape(Circle())
                        Text(mastodon).font(Font.ladefuchsItalic())
                            .padding(.bottom, 7.0)
                            .accessibilityLabel("\(Texts.Accessibility.prefixTwitter): \(mastodon)")
                            .accessibilityAddTraits(.isButton)
                            .accessibilityRemoveTraits(.isStaticText)
                    }
                }
                if let twitter = info.twitterName {
                    HStack{
                        Image ("icon_bluesky")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(.bottom, 6.0)
                        //.background(Color.ladefuchsDarkGrayBackground)
                            //.clipShape(Circle())
                    Text(twitter).font(Font.ladefuchsItalic())
                        .padding(.bottom, 7.0)
                        .accessibilityLabel("\(Texts.Accessibility.prefixTwitter): \(twitter)")
                        .accessibilityAddTraits(.isButton)
                        .accessibilityRemoveTraits(.isStaticText)
                }
            }
                if let email = info.emailAddress {
                    HStack{
                        Image ("icon_mail")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(.bottom, 4.0)
                        //.background(Color.ladefuchsDarkGrayBackground)
                            //.clipShape(Circle())
                        Text(email).font(Font.ladefuchsItalic())
                            .padding(.bottom, 4.0)
                            .accessibilityLabel("\(Texts.Accessibility.prefixEmail): \(email)")
                            .accessibilityAddTraits(.isButton)
                            .accessibilityRemoveTraits(.isStaticText)
                    }
                }
            }
            Spacer()
        }
        .onTapGesture {
            if info.twitterURL != nil || info.emailAddress != nil || info.mastodonURL != nil {
                showActionSheet = true
            } else {
                showActionSheet = false
            }

        }
        .confirmationDialog(Text("\(info.name) kontaktieren"), isPresented: $showActionSheet, actions: {
            if let url = info.mastodonURL {
                Button("Mastodon") {
                    UIApplication.shared.open(url)
                }
            }
            if let url = info.twitterURL {
                Button("BlueSky") {
                    UIApplication.shared.open(url)
                }
            }
            if let email = info.emailAddress {
                Button("Email") {
                    UIApplication.shared.open(
                        URL(string: "mailto:\(email)")!
                    )
                }
            }
        }, message: {
            Text("\(info.name) kontaktieren")
        })
    }
}

struct TeammemberView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamView()
            TeamView().previewLayout(PreviewLayout.fixed(width: 500, height: 2000))
//            AboutNavigation(closeBlock: {})
        }
        .previewLayout(PreviewLayout.fixed(width: 400, height: 200))
        // .padding()
    }

}
