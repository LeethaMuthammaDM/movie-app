//
//  NetworkMonitor.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import Foundation
import Network
import Combine

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
