//
//  ContentView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct ContentView: View {
    var printer: Printer
    
    var body: some View {
        NavigationView {
            Sidebar()
            LandingPage(title: "Welcome")
        }
    }
}

//struct Control: View {
//    var title: String
//
//    var body: some View {
//        NavigationLink(destination: LandingPage(title: title)) {
//            Label {
//                Text(title)
//            } icon: {
//                Image(systemName: "wand.and.rays")
//            }.labelStyle(TitleOnlyLabelStyle())
//        }
//    }
//}
//
//struct Controls: View {
//    var body: some View {
//        List ( 1..<5 ) { i in
//            Control(title: "Control \(i)")
//        }
//    }
//}

struct Sidebar: View {
    let pages: [String] = ["Connection", "Files", "Settings"]
    
    var body: some View {
        List(pages, id: \.self) { page in
            HStack {
                Image(systemName: "flame.fill")
                Text(page)
            }
        }
        .navigationTitle("SquidPrint")
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let apiConfig = OctoPrintAPIConfig(serverURL: "example.com", apiKey: "A KEY")
        
        return ContentView(printer: Printer(using: NetworkManager(with: apiConfig)))
            .preferredColorScheme(.dark)
            .previewDevice("iPad (7th generation)")
    }
}
