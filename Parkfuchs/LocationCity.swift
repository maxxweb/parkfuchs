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

struct LocationCityView: View {
    @State private var locations: [LocationPin] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @Environment(\.presentationMode) var presentationMode

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
                Image("parkfuchspin") // Replace "pin_image" with the name of your image asset
                    .resizable()
                    .frame(width: 29, height: 29) // Adjust the size of the image as needed
                    //.clipShape(Circle())
                    //.overlay(Circle().stroke(Color.red, lineWidth: 2))
                    //.shadow(radius: 4)
                    .offset(x: 0, y: -9) // Adjust the offset to align the image correctly
                    .onTapGesture {
                        // Handle tap on the image if needed
                    }
            }
        }
        .onAppear {
            fetchLocations()
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
                        if let latitude = Double(welcomeElement.cityRef.latitude),
                           let longitude = Double(welcomeElement.cityRef.longitude) {
                            return LocationPin(id: UUID(), coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
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
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    var cityRef: CityRef
    var id, city: String
    var approved, useBusLane, untilMaxMarkingHour, freeParking: Bool
    var withEMark: Bool
    var information: String
    var website: String
    var parkingDisk, nonePrivileges: Bool
    var parkingHours: Double
    var whileCharging: Bool
    var websiteExtras: WebsiteExtras
    var updated: String
}

// MARK: - CityRef
struct CityRef: Codable {
    var id, name: String
    var postcodes: [String]
    var community, state, stateCode, latitude: String
    var longitude: String
}

enum WebsiteExtras: Codable {
    case string(String)
    case websiteExtraArray([WebsiteExtra])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([WebsiteExtra].self) {
            self = .websiteExtraArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(WebsiteExtras.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WebsiteExtras"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .websiteExtraArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - WebsiteExtra
struct WebsiteExtra: Codable {
    var label: String?
    var url: String
}

typealias Welcome = [WelcomeElement]

