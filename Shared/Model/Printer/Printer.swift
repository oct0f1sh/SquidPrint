//
//  Printer.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 7/6/20.
//

import Foundation
import Combine

struct PrinterProfile: Codable, Equatable {
    let id: String
    let name: String
}

class Printer: Identifiable, ObservableObject {
    @Published var name: String
    var uuid: UUID = UUID()
    let networkClient: NetworkClient
    
    private var cancellable: AnyCancellable?
    
    var id: String {
        get { name }
    }
    
    @Published var connectionController: ConnectionController
    var connection: Connection? {
        get { connectionController.connection }
        set { connectionController.connection = newValue }
    }
    
    init(_ name: String, using networkClient: NetworkClient) {
        self.name = name
        self.networkClient = networkClient
        self.connectionController = ConnectionController(using: RemoteConnectionDataSource(using: networkClient))
        
        update()
    }
    
    init(_ name: String, with connectionController: ConnectionController, using networkClient: NetworkClient) {
        self.name = name
        self.connectionController = connectionController
        self.networkClient = networkClient
    }
    
    init(from persistedData: PersistedPrinter, networkSession: NetworkSession = URLSession.localSession) {
        self.name = persistedData.name
        self.uuid = persistedData.uuid
        
        let config = ServerConfiguration(url: persistedData.url, apiKey: persistedData.apiKey)
        self.networkClient = NetworkClient(with: config, using: networkSession)
        
        self.connectionController = ConnectionController(using: RemoteConnectionDataSource(using: networkClient))
        
        update()
    }
    
    func update() {
        self.cancellable = connectionController.dataSource.getPublisher()
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .assign(to: \.connection, on: connectionController)
    }
}
