//
//  ContentView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var server: PrinterManager
    
    var body: some View {
        NavigationView {
            Sidebar(server: server)
            LandingPage(server: server, title: "Welcome")
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
    @ObservedObject var server: PrinterManager
    let pages: [String] = ["Connection", "Files", "Settings"]
    
    var body: some View {
        List(pages, id: \.self) { page in
            NavigationLink(destination: LandingPage(server: server, title: page)) {
                HStack {
                    Image(systemName: "flame.fill")
                    Text(page)
                }
            }
        }
        .navigationTitle("SquidPrint")
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let server = PrinterManager(using: .previewData)
        
        return ContentView(server: server)
            .preferredColorScheme(.dark)
            .previewDevice("iPad (7th generation)")
    }
}
