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

class NetworkManager {
    var session: URLSession
    var serverConfig: OctoPrintServerConfig
    
    enum Resource: String {
        case connection
        case files
    }
    
    init(with config: OctoPrintServerConfig, using session: URLSession = .shared) {
        self.session = session
        self.serverConfig = config
    }
    
    func url(for resource: Resource) -> URL {
        return serverConfig.serverURL.appendingPathComponent(resource.rawValue, isDirectory: true)
    }
    
    func getConnection(receivedValue: @escaping (Connection) -> Void) {
        let publisher = session.dataTaskPublisher(for: serverConfig.serverURL)
            .map(\.data)
            .decode(type: Connection.self, decoder: JSONDecoder())
        
        let _ = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error getting connection: \(error.localizedDescription)")
                case .finished:
                    print("Finished getting connection")
                }
            },
            receiveValue: { value in
                receivedValue(value)
            })
    }
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
        self.networkManager.getConnection { connection in
            self.connection = connection
        }
    }
}
