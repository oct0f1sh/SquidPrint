//
//  URLSession+NetworkSession.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/1/20.
//

import Foundation

extension URLSession: NetworkSession {
    func getPublisher(from url: URL) -> DataTaskPublisher {
        dataTaskPublisher(for: url)
    }
    
    func loadData(with urlRequest: URLRequest, _ response: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: urlRequest, completionHandler: response).resume()
    }
    
    static var localSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
//        config.timeoutIntervalForResource = 60
        
        return URLSession(configuration: config)
    }()
}
