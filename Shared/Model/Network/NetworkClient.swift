//
//  NetworkClient.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/1/20.
//

import Foundation

protocol NetworkSession {
    func getPublisher(from url: URL) -> URLSession.DataTaskPublisher
    func loadData(with urlRequest: URLRequest, _ response: @escaping (Data?, URLResponse?, Error?) -> Void)
}

enum Endpoint: String {
    case connection = "api/connection"
    case files = "api/files"
}

class NetworkClient {
    var session: NetworkSession
    var serverConfig: ServerConfiguration
    
    init(with config: ServerConfiguration, using session: NetworkSession = URLSession.localSession) {
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
        var urlRequest = URLRequest(url: url(for: endpoint))
        urlRequest.addValue(serverConfig.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        session.loadData(with: urlRequest, completion)
    }
}

internal extension NetworkClient {
    static var previewData: NetworkClient = {
        NetworkClient(with: ServerConfiguration(url: URL(staticString: "example.com"), apiKey: "XXXXXX"))
    }()
}
