//
//  URL+StaticString.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/1/20.
//

import Foundation

// Copied from https://www.swiftbysundell.com/articles/constructing-urls-in-swift/
// Allows for initializing non-optional URLs using a String
extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
