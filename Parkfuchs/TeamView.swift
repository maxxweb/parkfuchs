//
//  TeamView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.

import SwiftUI

struct TeamView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.ladefuchsLightBackground.edgesIgnoringSafeArea(.all)
           
                VStack(alignment: .leading) {
                   
                    MainHeaderView()
                        .padding(.bottom, -33.0)
                    
                    ScrollView(Axis.Set.vertical, showsIndicators: true) {
                    MemberView()
                            .padding(.top,20.0)
                        .padding(.bottom, 48.0)
                    
                    MapView()
                        .padding(.bottom, 48.0)
                    
                    PodcastView()
                        .padding(.bottom, 48.0)
                   
                    InfoView()
                        .padding(.bottom, 48.0)
                    
                    LadefuchsView()
                        .padding(.bottom, 10.0)
                        
                    IlluView()
                        .padding(.bottom, 28.0)
                        
                    LizenzView()
                        .padding(.bottom, 20.0)
                    
                    FooterView()
                        .padding(.bottom, 10.0)
                    VersionView()
                        .padding(.bottom, 10.0)
                    
                  //  HeaderView(title: "Illufüchse".uppercased(), subtitle: //"Illustriert mit ❤️ von Aga und Marcel-André")
                  //      .padding(.bottom, 48.0)

                 //   HeaderView(title: "Impressum".uppercased(), subtitle: impressum)
                 //       .padding(.bottom, 48.0)

                  // HeaderView(title: "Drittlizenzen".uppercased(), subtitle: "Momentan keine!")
                  //     .padding(.vertical)

                  // Text("Handgefertigt aus ❤️ zur Elektromobilität in 👑 Aachen, ⚒️ Ahlen, 🏰 Ahrensburg und 🐻 Berlin").font(Font.ladefuchsItalic())
//                    Text("")
//                        .accessibilityHidden(true)
                   // Text("Ladefuchs Version \(versionString)")
                }
                .padding(.horizontal, 16)
                .padding(.leading, 10) // Verschiebung um 20 Pixel nach links
                .background(Color.ladefuchsLightBackground)
            }
        }
        .navigationBarTitle("Kontaktinfos", displayMode: .inline)
                   .navigationBarItems(trailing:
                       Button(action: {
                       // Hier wird zur vorherigen Ansicht zurückgekehrt
                                           self.presentationMode.wrappedValue.dismiss()
                       }) {
                           Image("close")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 14, height: 14)
                               .padding(4)
                               .background(Color.ladefuchsDarkGrayBackground)
                               .clipShape(Circle())

                       }
                   )
               }
           }

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamView()
            TeamView().previewLayout(PreviewLayout.fixed(width: 500, height: 2000))
//            AboutNavigation(closeBlock: {})
        }
    }
}
