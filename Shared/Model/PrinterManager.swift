//
//  PrinterManager.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/29/20.
//

import Foundation

struct OctoPrintAPIConfig {
    let serverURL: URL
    let apiKey: String
    
    init(serverURL: URL, apiKey: String) {
        self.serverURL = serverURL
        self.apiKey = apiKey
    }
    
    init(serverURL: StaticString, apiKey: String) {
        self.init(serverURL: URL(staticString: serverURL), apiKey: apiKey)
    }
}

class PrinterManager: ObservableObject {
    let networkManager: NetworkManager
    let config: OctoPrintAPIConfig
    @Published var connection: Connection?
    
    init(using networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.config = networkManager.serverConfig
    }
    
    func update(_ completion: ((Result<Any?, Error>) -> Void)? = nil) {
        networkManager.loadData(from: .connection) { [weak self] data, _, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            if let data = data, let connection = try? JSONDecoder().decode(Connection.self, from: data) {
                self?.connection = connection
                completion?(.success(self?.connection))
            }
        }
    }
}
