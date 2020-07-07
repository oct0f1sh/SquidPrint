//
//  LandingPage.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import SwiftUI

struct LandingPage: View {
    var title: String
    
    var body: some View {
        VStack {
            Text("🦑").font(.largeTitle)
            Text(title).font(.title2).fontWeight(.bold)
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage(title: "Preview")
    }
}
