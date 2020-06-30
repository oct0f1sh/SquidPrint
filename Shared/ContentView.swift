//
//  ContentView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct ContentView: View {
    // @ObservedObject var store: PrinterStore
    
    var body: some View {
        NavigationView {
            Sidebar()
            LandingPage(title: "Welcome")
        }
    }
}

struct LandingPage: View {
    var title: String
    
    var body: some View {
        VStack {
            Text("🦑").font(.largeTitle)
            Text(title).font(.title2).fontWeight(.bold)
        }
    }
}

struct Control: View {
    var title: String
    
    var body: some View {
        NavigationLink(destination: LandingPage(title: title)) {
            Label {
                Text(title)
            } icon: {
                Image(systemName: "wand.and.rays")
            }.labelStyle(TitleOnlyLabelStyle())
        }
    }
}

struct Controls: View {
    var body: some View {
        List ( 1..<5 ) { i in
            Control(title: "Control \(i)")
        }
    }
}

struct Sidebar: View {
    let pages: [String] = ["Connection", "Files", "Settings"]
    
    var body: some View {
        List(pages, id: \.self) { page in
            NavigationLink(destination: LandingPage(title: page)) {
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
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPad (7th generation)")
    }
}
