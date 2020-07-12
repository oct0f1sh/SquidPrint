//
//  NetworkClient.swift
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

class NetworkClient {
    var session: NetworkSession
    var serverConfig: ServerConfiguration
    
    init(with config: ServerConfiguration, using session: NetworkSession = URLSession.shared) {
        self.session = session
        self.serverConfig = config
    }
    
    func url(for endpoint: Endpoint) -> URL {
        return serverConfig.url.appendingPathComponent(endpoint.rawValue)
    }
    
    func publisher(from endpoint: Endpoint) -> URLSession.DataTaskPublisher {
        session.getPublisher(from: url(for: endpoint))
    }
    
    func loadData(from endpoint: Endpoint, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.loadData(from: url(for: endpoint), completion)
    }
}

internal extension NetworkClient {
    static var previewData: NetworkClient = {
        NetworkClient(with: ServerConfiguration(url: URL(staticString: "example.com"), apiKey: "XXXXXX"))
    }()
}
