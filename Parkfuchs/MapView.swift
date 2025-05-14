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
        VStack(alignment: .leading){
        HeaderView(title: "Kartenfuchs".uppercased(), subtitle: "Sieh Dir auf der Karte an wo Du schlau Parken kannst.")
            HStack(spacing: 8.0){
                Button(action: {
                    isLocationViewPresented.toggle()
                }) {
                    Image("map", bundle: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 280)
                }
                .sheet(isPresented: $isLocationViewPresented) {
                    LocationCityView()
                }
                Spacer()
            }
                }
            }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {

            TeamView()

    }
}
