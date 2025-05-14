//
//  Texts.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import Foundation

// TODO: Localize
public struct Texts {
    static let loadingAlertTitle = "Daten werden geladen"
    static let loadingAlertMessage = "Bitte warten einen Moment während der kleine Fuchs durch den Wald läuft und Nüsse, ich meine Preise, einsammelt..."
    static let pullToRefreshChargingPrices = "Kleiner Fuchs lauf, hol' neue Daten!"
    static let chargingPriceCellPriceNotAvailable = ""
    static let onboardingStep0Description = "Wähle den Anbieter der Ladesäule, an der Du stehst."
    static let onboardingStep1Description = "Die günstigsten Ladekarten findest Du oben in der Liste."
    static let onboardingStep2Description = "Hier kannst Du Deine persönlichen Ladetarife und weitere Ladesäulen-Betreiber hinzufügen."

    enum Accessibility {
        static let settingsButton = "Einstellungen"
        static let pickerHeader = "An welcher Säule stehst du?"
        static let prefixAC = "AC"
        static let prefixDC = "DC"
        static let prefixTwitter = "Twitter"
        static let prefixEmail = "E-Mail"
        static let closeButton = "Schließen"
        static let notAvailable = "nicht verfügbar"
    }
}
