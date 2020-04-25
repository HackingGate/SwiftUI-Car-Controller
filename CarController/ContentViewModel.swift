//
//  ContentViewModel.swift
//  CarController
//
//  Created by HG on 2020/04/25.
//  Copyright © 2020 HG. All rights reserved.
//
//
import Foundation
import GameController
import Combine

class ContentViewModel: ObservableObject {
    @Published var controller: GCController?
    @Published var venderName: String?
    @Published var exGamepad: GCExtendedGamepad?

    // Button
    @Published var left = GCControllerButtonInput()
    @Published var right = GCControllerButtonInput()
    @Published var up = GCControllerButtonInput()
    @Published var down = GCControllerButtonInput()
    
    // Axis
    @Published var xAxis = GCControllerAxisInput()
    @Published var yAxis = GCControllerAxisInput()

    private var disposables = Set<AnyCancellable>()

    init(controller: GCController?) {
        self.controller = controller
        self.subscribe()
    }

    deinit {
        for sub in self.disposables {
            sub.cancel()
        }
    }

    func subscribe() {
        NotificationCenter.default
            .publisher(for: Notification.Name.GCControllerDidConnect)
            .map( { ($0.object as! GCController) } )
            .sink(receiveValue: { controller in
                print(controller)
                self.controller = controller
                self.venderName = controller.vendorName
                self.exGamepad = controller.extendedGamepad
                if let exGamepad = controller.extendedGamepad {
                    self.handleControllerValueChange(exGamepad)
                }
            })
            .store(in: &disposables)
    }

    func handleControllerValueChange(_ exGamepad: GCExtendedGamepad) {
        exGamepad.valueChangedHandler = {
            (gamepad: GCExtendedGamepad, element:GCControllerElement) in
            if (gamepad.leftThumbstick == element) {
                self.updateDirection(gamepad.leftThumbstick)
                self.updateAxis(gamepad.leftThumbstick)
            }
            if (gamepad.rightThumbstick == element) {
                self.updateDirection(gamepad.rightThumbstick)
                self.updateAxis(gamepad.rightThumbstick)
            }
            if (gamepad.dpad == element) {
                self.updateDirection(gamepad.dpad)
                self.updateAxis(gamepad.dpad)
            }
        }
    }

    func updateDirection(_ pad: GCControllerDirectionPad) {
        self.left = pad.left
        self.right = pad.right
        self.up = pad.up
        self.down = pad.down
    }
    
    func updateAxis(_ pad: GCControllerDirectionPad) {
        self.xAxis = pad.xAxis
        self.yAxis = pad.yAxis
    }
}
