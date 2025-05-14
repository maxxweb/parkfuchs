//
//  maps.swift
//  Parkfuchs
//
//  Created by maxxweb on 14.09.23.
//

import SwiftUI
import MapKit

struct LocationData: Codable {
    let latitude: Double
    let longitude: Double
}

struct mapsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dragOffset: CGSize = .zero
    @State private var locations: [LocationData] = [] // Array für die Standortdaten

    // Standardregion für die Karte
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.1494, longitude: 10.4732), // Standard-Koordinaten, falls keine Daten verfügbar sind
        span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 9.0)
    )

    var body: some View {
        // ... Der restliche Code bleibt gleich ...

        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations) { location in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .blue)
        }
        .onAppear {
            // Hier rufen Sie die Standortdaten aus der JSON-Datei ab
            fetchLocationsFromJSON()
        }
    }

    // Rest des Codes bleibt gleich

    // Funktion zum Abrufen und Dekodieren von Standortdaten aus der JSON-Datei
    func fetchLocationsFromJSON() {
        if let url = Bundle.main.url(forResource: "Locations", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                locations = try decoder.decode([LocationData].self, from: data)
            } catch {
                print("Fehler beim Dekodieren der Standortdaten aus JSON: \(error.localizedDescription)")
            }
        }
    }
}


struct mapsView_Previews: PreviewProvider {
    static var previews: some View {
        mapsView()
    }
}
