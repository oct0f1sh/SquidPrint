//
//  DesignConnectionDataSources.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/19/20.
//

import Foundation
import Combine

class FakeConnectionDataSource: ConnectionDataSource {
    
    var connection = Connection(options: Connection.Options(baudrates: [100, 200],
                                                                   ports: ["fake_port/1", "fake_port/2"],
                                                                   printerProfiles: [PrinterProfile(id: "some id", name: "3D Printer")]),
                                       baudrate: 100,
                                       port: "fake_port/1",
                                       printerProfileID: "some id",
                                       state: "doing something")
    
    func update(_ completion: @escaping (Connection?) -> Void) {
        completion(connection)
    }
    
    func getPublisher() -> AnyPublisher<Connection?, Error> {
        Just(connection)
            .mapError { _ -> Error in }
            .eraseToAnyPublisher()
    }
}

class NilConnectionDataSource: ConnectionDataSource {
    func update(_ completion: @escaping (Connection?) -> Void) {
        completion(nil)
    }
    
    func getPublisher() -> AnyPublisher<Connection?, Error> {
        Just(nil)
            .mapError { _ -> Error in }
            .eraseToAnyPublisher()
    }
}
