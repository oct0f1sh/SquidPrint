//
//  AddPrinterView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/13/20.
//

import Foundation
import SwiftUI

struct AddPrinterView: View {
    @State private var printerName: String = ""
    @State private var printerURL: String = ""
    @State private var printerAPIKey: String = ""
    
    var handler: (_ name: String, _ url: String, _ apiKey: String) -> Void
    
    var body: some View {
        Group {
            Text("New Printer").font(.title).padding(.top, 20)
            Form {
                Section {
                    HStack {
                        Text("Name: ")
                        TextField("Prusa i3 Mk3", text: $printerName)
                    }
                    HStack {
                        Text("URL: ")
                        TextField("octopi.local", text: $printerURL)
                    }
                    HStack {
                        Text("API Key: ")
                        TextField("API KEY", text: $printerAPIKey)
                    }
                }
            }
            
            Button(action: { handler(printerName, printerURL, printerAPIKey) }, label: {
                Text("Add printer")
            })
            .padding()
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
        }
    }
}
