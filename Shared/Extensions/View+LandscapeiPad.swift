//
//  View+LandscapeiPad.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import Foundation
import SwiftUI

extension View {
    func layoutLandscapeiPad() -> some View {
        self
            .previewLayout(.fixed(width: 1024.0, height: 768.0))
            .previewDevice("iPad (7th generation)")
    }
}
