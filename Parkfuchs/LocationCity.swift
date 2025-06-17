//
//  LocationCity.swift
//  Parkfuchs
//
//  Created by maxxweb on 22.09.23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import SwiftUI
import MapKit

struct IdentifiableString: Identifiable {
    let id = UUID()
    let value: String
    let locationId: String
}

struct LocationCityView: View {
    @State private var locations: [LocationPin] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedInfo: IdentifiableString?

    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Color.accentColor
                        .frame(height: 70)
                        .padding(-35)
                        .padding(.bottom, 0.0)
                    HStack {
                        Spacer()
                        Image("parkfuchs")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                            .padding(.bottom, -8.0)
                            .offset(x: 10)
                        Text("   Hier kannst Du schlau parken.").font(Font.ladefuchsItalic())
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("close")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 14, height: 14)
                                .padding(4)
                                .background(Color.ladefuchsDarkGrayBackground)
                                .clipShape(Circle())
                                .padding(.bottom, 0.0)
                                .offset(x: -16)
                        }
                    }
                }
            }
        }
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image("parkfuchspin")
                    .resizable()
                    .frame(width: 29, height: 29)
                    .offset(x: 0, y: -9)
                    .onTapGesture {
                        selectedInfo = IdentifiableString(value: location.information, locationId: location.id.uuidString)
                    }
            }
        }
        .onAppear {
            fetchLocations()
        }
        .overlay {
            if let infoWrapper = selectedInfo {
                ZStack {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            selectedInfo = nil
                        }
                    
                    VStack(spacing: 16) {
                        if let city = locations.first(where: { $0.id.uuidString == infoWrapper.locationId }) {
                            Text(city.cityName)
                                .font(.title3)
                                .bold()
                            Text(city.state)
                                .foregroundColor(.secondary)
                            Text("Parkinformationen")
                                .font(.headline)

                            if city.information.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                Text("Keine weiteren Informationen verfügbar.")
                                    .foregroundColor(.secondary)
                            } else {
                                Text(city.information)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }

                            if !city.website.isEmpty, let url = URL(string: city.website), UIApplication.shared.canOpenURL(url) {
                                Link("Webseite besuchen", destination: url)
                                    .padding(.top, 10)
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                if city.freeParking {
                                    Label("Kostenloses Parken", systemImage: "checkmark.circle")
                                }
                                if city.withEMark {
                                    Label("Nur mit E-Kennzeichen", systemImage: "car.fill")
                                }
                                if city.whileCharging {
                                    Label("Nur während des Ladevorgangs", systemImage: "bolt.fill")
                                }
                                if city.parkingDisk {
                                    Label("Parkscheibe erforderlich", systemImage: "clock.fill")
                                }
                            }
                            .padding(.top, 10)

                            Button("Schließen") {
                                selectedInfo = nil
                            }
                            .padding(.top, 10)
                            .foregroundColor(.red)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding()
                }
                .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
                .transition(.opacity)
                .animation(.easeInOut, value: selectedInfo != nil)
            }
        }
    }

    func fetchLocations() {
        guard let url = URL(string: "https://parkfuchs.app/api/city") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                    let coordinates = welcome.compactMap { welcomeElement in
                        let city = welcomeElement.expand.city
                        if let latitude = Double(city.latitude),
                           let longitude = Double(city.longitude) {
                            return LocationPin(
                                id: UUID(),
                                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                information: welcomeElement.information,
                                website: welcomeElement.website,
                                cityName: city.name,
                                state: city.state,
                                freeParking: welcomeElement.freeParking,
                                withEMark: welcomeElement.withEMark,
                                whileCharging: welcomeElement.whileCharging,
                                parkingDisk: welcomeElement.parkingDisk
                            )
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        locations.append(contentsOf: coordinates)
                        updateRegion(coordinates: coordinates)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func updateRegion(coordinates: [LocationPin]) {
        if let minLat = coordinates.map({ $0.coordinate.latitude }).min(),
           let maxLat = coordinates.map({ $0.coordinate.latitude }).max(),
           let minLon = coordinates.map({ $0.coordinate.longitude }).min(),
           let maxLon = coordinates.map({ $0.coordinate.longitude }).max() {
            let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
            let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.2, longitudeDelta: (maxLon - minLon) * 1.2)
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center: center, span: span)
            }
        }
    }
}


struct LocationCityView_Previews: PreviewProvider {
    static var previews: some View {
        LocationCityView()
    }
}

struct LocationPin: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let information: String
    let website: String
    let cityName: String
    let state: String
    let freeParking: Bool
    let withEMark: Bool
    let whileCharging: Bool
    let parkingDisk: Bool
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct WelcomeElement: Codable {
    var expand: Expand
    var id: String
    var city: String
    var approved: Bool
    var information: String
    var website: String
    var freeParking: Bool
    var withEMark: Bool
    var whileCharging: Bool
    var parkingDisk: Bool
    // weitere Felder nach Bedarf
}

struct Expand: Codable {
    var city: CityDetails
}

struct CityDetails: Codable {
    var id: String
    var name: String
    var latitude: String
    var longitude: String
    var community: String
    var state: String
    var stateCode: String
}

typealias Welcome = [WelcomeElement]
