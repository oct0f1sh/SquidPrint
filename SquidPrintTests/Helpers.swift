//
//  Helpers.swift
//  SquidPrintTests
//
//  Created by Duncan MacDonald on 7/1/20.
//

import Foundation

extension Endpoint {
    static var allEndpoints: [Endpoint] {
        [.connection, .files]
    }
    
    func expectedURL(withHost baseURL: URL) -> URL {
        baseURL.appendingPathComponent(self.rawValue)
    }
    
    func expectedResponse(isSuccess: Bool = true) -> Data? {
        self.rawValue.data(using: .utf8)
    }
}
