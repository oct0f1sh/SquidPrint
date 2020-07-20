//
//  ConnectionController.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation
import Combine

protocol ConnectionDataSource: AnyObject {
    func update(_ completion: @escaping (Connection?) -> Void)
    func getPublisher() -> AnyPublisher<Connection?, Error>
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
    private let networkClient: NetworkClient
    private var cancellable: AnyCancellable? = nil
    
    init(using networkClient: NetworkClient) {
        self.networkClient = networkClient
        
//        cancellable = networkClient.publisher(from: .connection)
//            .map { $0.data }
//            .sink { error in
//                print("AHHHHHH \(error)")
//            } receiveValue: { data in
//                print("HEY IT's \(String(data: data, encoding: .utf8))")
//            }
    }
    
    func getPublisher() -> AnyPublisher<Connection?, Error> {
        networkClient.publisher(from: .connection)
            .map { $0.data }
            .decode(type: Connection?.self, decoder: JSONDecoder())
            .print()
            .eraseToAnyPublisher()
    }
    
    func update(_ completion: @escaping (Connection?) -> Void) {
        networkClient.loadData(from: .connection) { data, _, error in
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
