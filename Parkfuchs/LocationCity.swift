//
//  LocationCity.swift
//  Parkfuchs
//
//  Created by maxxweb on 22.09.23.
//

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
    @Environment(\.dismiss) private var dismiss
    @State private var selectedInfo: IdentifiableString?

    var body: some View {
        Group {
            if IPhoneDuo.isCurrent {
                duoBody
            } else {
                standardBody
            }
        }
        .onAppear {
            fetchLocations()
        }
    }

    private let logoHeight: CGFloat = 50

    /// Classic iPhone header with inline close button.
    private var standardBody: some View {
        VStack(spacing: 0) {
            mapHeader(showsCloseButton: true)
            mapWithDetailOverlay
        }
    }

    /// iPhone Duo: system toolbar for close (vertical bar) + compact header.
    private var duoBody: some View {
        NavigationStack {
            VStack(spacing: 0) {
                mapHeader(showsCloseButton: false)
                mapWithDetailOverlay
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Schließen", systemImage: "xmark")
                    }
                    .accessibilityLabel("Schließen")
                }
            }
        }
    }

    /// Header height matches the logo bottom edge (same as MainHeaderView).
    private func mapHeader(showsCloseButton: Bool) -> some View {
        ZStack {
            Color.accentColor

            HStack(spacing: 8) {
                Image("parkfuchs")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: logoHeight)
                    .accessibilityLabel("Parkfuchs")

                Text("Hier kannst Du schlau parken.")
                    .font(Font.ladefuchsItalic())
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)

                Spacer(minLength: 0)

                if showsCloseButton {
                    Button {
                        dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                            .padding(4)
                            .background(Color.ladefuchsDarkGrayBackground)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Schließen")
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: logoHeight)
        .frame(maxWidth: .infinity)
    }

    private var mapWithDetailOverlay: some View {
        GeometryReader { proxy in
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: locations
            ) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Image("parkfuchspin")
                        .resizable()
                        .frame(width: 29, height: 29)
                        .offset(x: 0, y: -9)
                        .onTapGesture {
                            selectedInfo = IdentifiableString(
                                value: location.information,
                                locationId: location.id.uuidString
                            )
                        }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay {
                if let infoWrapper = selectedInfo {
                    ZStack {
                        Color.black.opacity(0.2)
                            .ignoresSafeArea()
                            .onTapGesture {
                                selectedInfo = nil
                            }

                        locationDetailCard(
                            for: infoWrapper,
                            maxHeight: proxy.size.height * 0.9,
                            maxWidth: min(proxy.size.width - 32, 520)
                        )
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: selectedInfo != nil)
                }
            }
        }
    }

    @ViewBuilder
    private func locationDetailCard(
        for infoWrapper: IdentifiableString,
        maxHeight: CGFloat,
        maxWidth: CGFloat
    ) -> some View {
        let content = locationDetailContent(for: infoWrapper)

        ViewThatFits(in: .vertical) {
            content
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .fixedSize(horizontal: false, vertical: true)

            ScrollView {
                content
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxHeight: maxHeight)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .frame(maxWidth: maxWidth)
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.height > 50 {
                        selectedInfo = nil
                    }
                }
        )
    }

    @ViewBuilder
    private func locationDetailContent(for infoWrapper: IdentifiableString) -> some View {
        VStack(spacing: 16) {
            if let city = locations.first(where: { $0.id.uuidString == infoWrapper.locationId }) {
                Capsule()
                    .fill(Color.secondary.opacity(0.5))
                    .frame(width: 40, height: 5)
                    .padding(.top, 10)

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
                        .multilineTextAlignment(.center)
                } else {
                    Text(city.information)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity)
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
        .frame(maxWidth: .infinity)
    }

    func fetchLocations() {
        guard let url = URL(string: "https://parkfuchs.app/api/city") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                    let coordinates = welcome.compactMap { welcomeElement -> LocationPin? in
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
