//
//  PrinterTests.swift
//  SquidPrintTests
//
//  Created by Duncan MacDonald on 7/14/20.
//

import XCTest

class PrinterTests: XCTestCase {
    var serverConfig: ServerConfiguration!
    var networkSession: MockNetworkSession!
    var networkClient: NetworkClient!
    var printer: Printer!
    
    override func setUp() {
        serverConfig = ServerConfiguration(url: URL(staticString: "url.com"), apiKey: "something")
        networkSession = MockNetworkSession(baseURL: URL(staticString: "url.com"))
        networkClient = NetworkClient(with: serverConfig, using: networkSession)
    }

    func testInitWithNetworkClient() throws {
        printer = Printer("Prusa i3 Mk4", using: networkClient)
        
        XCTAssertNotNil(printer)
        XCTAssertEqual(printer.name, "Prusa i3 Mk4", "Printer has expected name")
        XCTAssertEqual(printer.networkClient.serverConfig, serverConfig, "Printer has expected server config")
        XCTAssertNotNil(printer.connectionController, "Printer created a connection controller")
    }
    
    func testInitWithConnectionController() throws {
        let connectionController = ConnectionController(using: FakeConnectionDataSource())
        printer = Printer("Ender 420", with: connectionController, using: networkClient)
        
        XCTAssertNotNil(printer)
        XCTAssertEqual(printer.name, "Ender 420", "Printer has expected name")
        XCTAssertEqual(printer.networkClient.serverConfig, serverConfig, "Printer has expected server config")
        XCTAssertEqual(printer.connectionController.connection, connectionController.connection, "Printer connection controller has expected connection")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
