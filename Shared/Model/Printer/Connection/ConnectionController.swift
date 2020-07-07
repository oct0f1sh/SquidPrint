//
//  ConnectionController.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation

protocol ConnectionController: AnyObject {
    var connection: Connection? { get }
    func update()
}

class RemoteConnectionController: ConnectionController, ObservableObject {
    private let networkManager: NetworkManager
    
    @Published var connection: Connection?
    
    init(using networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func update() {
        // TODO: figure out how to use publisher
        networkManager.loadData(from: .connection) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            self?.connection = try? JSONDecoder().decode(Connection.self, from: data)
        }
    }
}

// TODO: LocalConnectionController
