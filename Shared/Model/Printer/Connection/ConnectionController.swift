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

class RemoteConnectionController: ConnectionController {
    let networkManager: NetworkManager
    
    var connection: Connection?
    
    // TODO: better parameter labeling?
    init(networkManager: NetworkManager, _ connection: Connection? = nil) {
        self.networkManager = networkManager
        self.connection = connection
    }
    
    func update() {
        // TODO: figure out how to use publisher
        networkManager.loadData(from: .connection) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            self?.connection = try? JSONDecoder().decode(Connection.self, from: data)
        }
    }
}
