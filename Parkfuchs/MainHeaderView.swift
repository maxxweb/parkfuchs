//
//  MainHeaderView.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import SwiftUI

struct MainHeaderView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.accentColor
                        .frame(height: 60)
                        .padding(-35)
                        .padding(.bottom, 20.0)
            HStack {
                HStack {
                    Spacer()
                    Image("parkfuchs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .padding(.bottom,20.0)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                            .padding(4)
                            .background(Color.ladefuchsDarkGrayBackground)
                            .clipShape(Circle())
                            .padding(.bottom, 25.0)
                    })
                }.padding(.horizontal, 15.0)}
        }
        .frame(height: 80)
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView()
            //.background(Color.accentColor)
    }
}
