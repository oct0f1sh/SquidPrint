//
//  ContentView.swift
//  Shared
//
//  Created by Duncan MacDonald on 6/26/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar()
            Dashboard()
        }
    }
}

struct Dashboard: View {
    var body: some View {
        VStack {
            Text("Dashboard").font(.largeTitle).fontWeight(.bold)
            Spacer()
            HStack {
                Spacer()
                Controls()
                Spacer()
            }
            Spacer()
            Spacer()
        }
    }
}

struct Control: View {
    var title: String
    
    var body: some View {
        NavigationLink(destination: Text("Good job")) {
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
        List (1..<5 ) { i in
            Control(title: "Control \(i)")
        }
    }
}

struct Sidebar: View {
    var body: some View {
        List( 1..<100 ) { i in
            HStack {
                Image(systemName: "flame.fill")
            }
            Text("Row \(i)")
        }
        .navigationTitle("SquidPrint")
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
