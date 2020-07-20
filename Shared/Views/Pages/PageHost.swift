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
    @ObservedObject var printer: Printer
    
    var body: some View {
        switch page {
        case .home:
            HomePage(connectionController: printer.connectionController)
        case .connection:
            ConnectionPage(connectionController: printer.connectionController)
        default:
            LandingPage(title: page.rawValue)
        }
    }
}

struct PageHost_Previews: PreviewProvider {
    @StateObject static var printerStore = PrinterStore(mockData: true)
    
    static var previews: some View {
        PageHost(page: .home, printer: printerStore.printers[0])
            .layoutLandscapeiPad()
    }
}
