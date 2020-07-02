//
//  SquidPrintTests.swift
//  SquidPrintTests
//
//  Created by Duncan MacDonald on 7/1/20.
//

import XCTest

fileprivate class MockNetworkSession: NetworkSession {
    func getPublisher(from url: URL) -> URLSession.DataTaskPublisher {
        URLSession.shared.dataTaskPublisher(for: url)
    }
    
    func loadData(from url: URL, _ response: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // url.path gives us the path of the URL without the URL host. Ex: "dunc.info/api/connection" -> "/api/connection"
        let path = url.path
        
        guard let endpoint = Endpoint(rawValue: String(path.dropFirst())) else {
            response(nil, nil, nil)
            return
        }
        response(endpoint.expectedResponse(), nil, nil)
    }
}

class NetworkManagerTests: XCTestCase {
    var config: OctoPrintServerConfig!
    fileprivate var session: MockNetworkSession!
    var networkManager: NetworkManager!
    let serverURL: URL = URL(staticString: "http://dunc.info")
    
    override func setUp() {
        config = OctoPrintServerConfig(serverURL: serverURL, apiKey: "")
        session = MockNetworkSession()
        networkManager = NetworkManager(with: config, using: session)
    }

    func testGeneratesURLsForEndpoints() {
        // Make sure that we have endpoints to iterate over
        XCTAssertTrue(!Endpoint.allEndpoints.isEmpty)
        
        for endpoint in Endpoint.allEndpoints {
            let url = networkManager.url(for: endpoint)
            let expectedURL = endpoint.expectedURL(withHost: serverURL)
            
            XCTAssertEqual(url, expectedURL)
        }
    }
    
    func testLoadsDataForEndpoint() {
        for endpoint in Endpoint.allEndpoints {
            let loadExpectation = expectation(description: "Data is loaded")
            networkManager.loadData(from: endpoint) { data, _, _ in
                guard let data = data else {
                    XCTFail("Expected response could not be loaded for endpoint: \(endpoint)")
                    loadExpectation.fulfill()
                    return
                }
                // Right now expectedResponse is just giving the enum RawValue as a response
                XCTAssertEqual(String(data: data, encoding: .utf8), endpoint.rawValue)
                loadExpectation.fulfill()
            }
            waitForExpectations(timeout: 1, handler: nil)
        }
    }
}
