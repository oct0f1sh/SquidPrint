//
//  OctoPrintServer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/29/20.
//

import Foundation

struct OctoPrintServerConfig {
    let serverURL: URL
    let apiKey: String
}

class OctoPrintServer: ObservableObject {
    let networkManager: NetworkManager
    let config: OctoPrintServerConfig
    @Published var connection: Connection?
    
    init(using networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.config = networkManager.serverConfig
        self.loadConnection()
    }
    
    func loadConnection() {
//        self.networkManager.getConnection { connection in
//            self.connection = connection
//        }
    }
}
