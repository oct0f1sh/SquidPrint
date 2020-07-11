//
//  PageHost.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/11/20.
//

import SwiftUI

enum Page: String, Identifiable {
    case landing
    case home
    case connection
    case files
    
    var id: String {
        get { rawValue }
    }
    
    var thumbnail: String {
        switch self {
        case .landing:
            return ""
        case .home:
            return "house"
        case .connection:
            return "wifi"
        case .files:
            return "folder"
        }
    }
}

struct PageHost: View {
    @State var page: Page
    @State var printer: Printer?
    
    var body: some View {
        if let printer = printer {
            switch page {
            case .connection:
                ConnectionPage(connectionController: printer.connectionController)
            default:
                LandingPage(title: page.rawValue)
            }
        } else {
            LandingPage(title: "Welcome to SquidPrint")
        }
    }
}

struct PageHost_Previews: PreviewProvider {
    static var previews: some View {
        PageHost(page: .home, printer: Printer("Yeet", with: ConnectionController(using: FakeConnectionDataSource())))
            .layoutLandscapeiPad()
    }
}
