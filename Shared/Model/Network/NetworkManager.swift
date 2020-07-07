//
//  NetworkManager.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/1/20.
//

import Foundation

protocol NetworkSession {
    func getPublisher(from url: URL) -> URLSession.DataTaskPublisher
    func loadData(from url: URL, _ response: @escaping (Data?, URLResponse?, Error?) -> Void)
}

enum Endpoint: String {
    case connection = "api/connection"
    case files = "api/files"
}

class NetworkManager {
    var session: NetworkSession
    var serverConfig: OctoPrintAPIConfig
    
    init(with config: OctoPrintAPIConfig, using session: NetworkSession = URLSession.shared) {
        self.session = session
        self.serverConfig = config
    }
    
    func url(for endpoint: Endpoint) -> URL {
        return serverConfig.serverURL.appendingPathComponent(endpoint.rawValue)
    }
    
    func publisher(from endpoint: Endpoint) -> URLSession.DataTaskPublisher {
        session.getPublisher(from: url(for: endpoint))
    }
    
    func loadData(from endpoint: Endpoint, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.loadData(from: url(for: endpoint), completion)
    }
}

internal extension NetworkManager {
    static var previewData: NetworkManager = {
        NetworkManager(with: OctoPrintAPIConfig(serverURL: "example.com", apiKey: "XXXXXX"))
    }()
}
