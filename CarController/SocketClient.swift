//
//  SocketClient.swift
//  CarController
//
//  Created by HG on 2020/04/26.
//  Copyright © 2020 HG. All rights reserved.
//

import Foundation
import SocketIO

class SocketClient: ObservableObject {
    @Published var connected = false
    private let manager: SocketManager
    private var socket: SocketIOClient

    init() {
        manager = SocketManager(socketURL: URL(string: "http://192.168.3.14:8080")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        setupSocket()
    }

    func setupSocket() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }

        socket.on(clientEvent: .disconnect) {data, ack in
            print("socket disconnected")
        }

        socket.connect()
    }

    func carMove(_ moveData: CarMove ) {
        socket.emit("move", moveData.left_r, moveData.left_d, moveData.right_d, moveData.right_r)
    }

}
