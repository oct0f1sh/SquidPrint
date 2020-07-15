//
//  MockNetworkSession.swift
//  SquidPrintTests
//
//  Created by Duncan MacDonald on 7/14/20.
//

import Foundation

class MockNetworkSession: NetworkSession {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getPublisher(from url: URL) -> URLSession.DataTaskPublisher {
        URLSession.shared.dataTaskPublisher(for: url)
    }
    
    func loadData(from url: URL, _ response: @escaping (Data?, URLResponse?, Error?) -> Void) {
        response(url.absoluteString.data(using: .utf8), nil, nil)
    }
}
