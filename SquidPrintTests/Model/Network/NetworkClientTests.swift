//
//  NetworkClientTests.swift
//  SquidPrintTests
//
//  Created by Duncan MacDonald on 7/1/20.
//

import XCTest

class NetworkClientTests: XCTestCase {
    fileprivate var session: MockNetworkSession!
    var config: ServerConfiguration!
    var client: NetworkClient!
    
    var endpoints: [Endpoint] = [.connection, .files]
    
    override func setUp() {
        let serverURL = URL(staticString: "example.com")
        config = ServerConfiguration(url: serverURL, apiKey: "APIKEY")
        session = MockNetworkSession(baseURL: serverURL)
        client = NetworkClient(with: config, using: session)
    }

    func testGeneratesURLsForEndpoints() {
        for endpoint in endpoints {
            let url = client.url(for: endpoint)
            var expectedURL: URL!
            
            switch endpoint {
            case .connection:
                expectedURL = URL(staticString: "example.com/api/connection")
            case .files:
                expectedURL = URL(staticString: "example.com/api/files")
            }
            
            XCTAssertEqual(url, expectedURL)
        }
    }
    
    func testLoadsDataForEndpoint() {
        for endpoint in endpoints {
            let loadExpectation = expectation(description: "Data is loaded")
            client.loadData(from: endpoint) { data, _, _ in
                guard let data = data else {
                    XCTFail("Expected response could not be loaded for endpoint: \(endpoint)")
                    loadExpectation.fulfill()
                    return
                }
                
                XCTAssertNotNil(String(data: data, encoding: .utf8), "Response should not be nil")
                
                XCTAssertEqual(String(data: data, encoding: .utf8),
                               self.client.url(for: endpoint).absoluteString,
                               "Response should be the full URL for the endpoint") // MockNetworkSession just returns the URL as Data
                
                loadExpectation.fulfill()
            }
            waitForExpectations(timeout: 1, handler: nil)
        }
    }
}
