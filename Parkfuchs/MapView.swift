//
//  MapView.swift
//  Parkfuchs
//
//  Created by maxxweb on 10.09.23.
//

import SwiftUI

struct MapView: View {
    @State private var isLocationViewPresented = false

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(
                title: "Kartenfuchs".uppercased(),
                subtitle: "Sieh Dir auf der Karte an wo Du schlau Parken kannst."
            )

            Button {
                isLocationViewPresented.toggle()
            } label: {
                Image("map", bundle: nil)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 420)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .sheet(isPresented: $isLocationViewPresented) {
                LocationCityView()
                    .duoSheetPresentation()
            }
            .accessibilityLabel("Karte öffnen")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
