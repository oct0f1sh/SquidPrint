//
//  AddPrinterView.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/13/20.
//

import Foundation
import SwiftUI
#if os(iOS)
import CodeScanner
#endif

struct AddPrinterView: View {
    @State private var printerName: String = ""
    @State private var printerURL: String = ""
    @State private var printerAPIKey: String = ""
    
    @State private var isPresentingQRScanner: Bool = false
    
    var handler: (_ name: String, _ url: String, _ apiKey: String) -> Void
    
    var body: some View {
        VStack {
            Text("New Printer").font(.title).padding(.top, 20)
            Form {
                Section(footer:
                            HStack {
                                Spacer()
                                Button(action: { handler(printerName, printerURL, printerAPIKey) }, label: {
                                    Text("Add printer")
                                })
                                .padding()
                                .frame(minWidth: 100)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                Spacer()
                            }.padding(.top, 10)
                ) {
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
                        #if os(iOS)
                        Button(action: {
                            isPresentingQRScanner = true
                        }, label: {
                            Image(systemName: "qrcode.viewfinder").font(.title)
                        })
                        #endif
                    }
                }
            }
        }.sheet(isPresented: $isPresentingQRScanner) {
            #if os(iOS)
            CodeScannerView(codeTypes: [.qr], completion: handleQRScan(result:))
            #endif
        }
    }
    
    #if os(iOS)
    func handleQRScan(result: Result<String, CodeScannerView.ScanError>) {
        isPresentingQRScanner = false
        
        switch result {
        case .success(let code):
            print(code)
            printerAPIKey = code
        case .failure(let error):
            print(error)
            printerAPIKey = "error scanning..."
        }
    }
    #endif
}

struct AddPrinterView_Previews: PreviewProvider {
    static var previews: some View {
        AddPrinterView { _, _, _ in
            ()
        }
    }
}
