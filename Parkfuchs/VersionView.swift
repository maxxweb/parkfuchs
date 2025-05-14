//
//  VersionView.swift
//  Parkfuchs
//
//  Created by maxxweb on 04.11.23.
//

import SwiftUI

struct VersionView: View {
    var versionString: String {
        guard let infoDict = Bundle.main.infoDictionary else { return "?" }
        let bundleVersion = (infoDict["CFBundleVersion"] as? String) ?? "?"
        let shortVersionString = (infoDict["CFBundleShortVersionString"] as? String) ?? "???"
        return "\(shortVersionString) (\(bundleVersion))"
    }
    
    var body: some View {
        HStack(spacing: 8.0){
            Text("Parkfuchs Version \(versionString)").font(Font.ladefuchsItalic())
            Spacer()
        }
    }
}

#Preview {
    VersionView()
}
