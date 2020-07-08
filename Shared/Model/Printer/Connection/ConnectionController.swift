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
    lazy var connection: Connection = {
        Connection(options: Connection.Options(baudrates: [100, 200],
                                               ports: ["fake_port/1", "fake_port/2"],
                                               printerProfiles: [PrinterProfile(id: "some id", name: "3D Printer")]),
                   baudrate: 100,
                   port: "fake_port/1",
                   printerProfileID: "some id",
                   state: "doing something")
    }()
    
    func update(_ completion: @escaping (Connection?) -> Void) {
        completion(connection)
    }
}

//protocol ConnectionController: AnyObject {
//    var connection: Connection? { get }
//    func update()
//}
//
//class RemoteConnectionController: ConnectionController, ObservableObject {
//    private let networkManager: NetworkManager
//
//    @Published var connection: Connection?
//
//    init(using networkManager: NetworkManager) {
//        self.networkManager = networkManager
//    }
//
//    func update() {
//        // TODO: figure out how to use publisher
//        networkManager.loadData(from: .connection) { [weak self] data, _, error in
//            guard let data = data, error == nil else { return }
//
//            self?.connection = try? JSONDecoder().decode(Connection.self, from: data)
//        }
//    }
//}

// TODO: LocalConnectionController
