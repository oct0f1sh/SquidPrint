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
    
    func loadData(from url: URL, _ response: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: url, completionHandler: response)
    }
}
