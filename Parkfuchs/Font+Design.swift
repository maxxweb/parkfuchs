//
//  Font+Extensions.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import Foundation
import SwiftUI

extension Font {
    static func ladefuchsHeader() -> Font {
        return Font.custom("Roboto", size: 20).bold()
    }

    static func ladefuchsItalic() -> Font {
        return Font.custom("Bitter", size: 15).italic()
    }

}
