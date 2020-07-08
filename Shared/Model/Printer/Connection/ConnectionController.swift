//
//  ConnectionController.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

protocol ConnectionDataSource: AnyObject {
    func update(_ completion: @escaping (Connection?) -> Void)
}

class ConnectionController: ObservableObject {
    let dataSource: ConnectionDataSource
    
    @Published var connection: Connection?
    
    init(using dataSource: ConnectionDataSource) {
        self.dataSource = dataSource
        
        // Inject fake dataSource connection on init for easy SwiftUI fake data
        if let dataSource = dataSource as? FakeConnectionDataSource {
            self.connection = dataSource.connection
        }
    }
    
    // TODO: Use publishers
    func update() {
        dataSource.update { [weak self] connection in
            self?.connection = connection
        }
    }
}

class RemoteConnectionDataSource: ConnectionDataSource {
    private let networkManager: NetworkManager
    
    init(using networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func update(_ completion: @escaping (Connection?) -> Void) {
        networkManager.loadData(from: .connection) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let connection = try? JSONDecoder().decode(Connection.self, from: data) {
                completion(connection)
            } else {
                completion(nil)
            }
        }
    }
}

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
}
