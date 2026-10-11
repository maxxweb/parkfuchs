//
//  DuoLayout.swift
//  Parkfuchs
//
//  Adaptive layout helpers for iPhone Duo (outer/inner display, fold poses).
//

import SwiftUI
import Darwin

enum IPhoneDuo {
    /// Hardware / Simulator check for iPhone Duo (`iPhone19,4`).
    static var isCurrent: Bool {
        if let name = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"],
           name.localizedCaseInsensitiveContains("Duo") {
            return true
        }

        let identifier = modelIdentifier
        return identifier == "iPhone19,4"
    }

    private static var modelIdentifier: String {
        if let simulator = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulator
        }

        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
    }
}

extension View {
    /// Prefer trailing sheet placement so iPhone Duo can use the vertical bar.
    @ViewBuilder
    func duoSheetPresentation() -> some View {
        if IPhoneDuo.isCurrent, #available(iOS 27.0, *) {
            self.presentationPlacement(.trailing)
        } else {
            self
        }
    }

    /// Centers content and caps width on large canvases (inner Duo display).
    @ViewBuilder
    func readableContentWidth(_ maxWidth: CGFloat = 720) -> some View {
        if IPhoneDuo.isCurrent {
            self
                .frame(maxWidth: maxWidth)
                .frame(maxWidth: .infinity)
        } else {
            self
        }
    }
}
