//
//  Connection.swift
//  SquidPrint
//
//  Created by Duncan MacDonald on 6/29/20.
//

import Foundation

struct Connection: Codable {
    struct Options: Codable {
        let baudrates: [Int]
        let ports: [String]
        let printerProfiles: [PrinterProfile]
    }
    
    private enum RootCodingKeys: String, CodingKey {
        case current
        case options
    }
    
    private enum CurrentConnectionCodingKeys: String, CodingKey {
        case baudrate
        case port
        case printerProfileID = "printerProfile"
        case state
    }
    
    let options: Options
    let baudrate: Int
    let port: String
    let printerProfileID: String
    let state: String // TODO: Could be enum
    
    init(options: Connection.Options, baudrate: Int, port: String, printerProfileID: String, state: String) {
        self.options = options
        self.baudrate = baudrate
        self.port = port
        self.printerProfileID = printerProfileID
        self.state = state
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let currentConnection = try rootContainer.nestedContainer(keyedBy: CurrentConnectionCodingKeys.self, forKey: .current)
        
        options = try rootContainer.decode(Options.self, forKey: .options)
        baudrate = try currentConnection.decode(Int.self, forKey: .baudrate)
        port = try currentConnection.decode(String.self, forKey: .port)
        printerProfileID = try currentConnection.decode(String.self, forKey: .printerProfileID)
        state = try currentConnection.decode(String.self, forKey: .state)
    }
    
    // TODO: func encode(to encoder: Encoder) throws {
}

