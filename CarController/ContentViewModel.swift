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
    // Controller status
    @Published var connected = false
    @Published var venderName: String?

    // 4 Face buttons
    @Published var buttonA = GCControllerButtonInput() // Cross Button
    @Published var buttonB = GCControllerButtonInput() // Circle Button
    @Published var buttonX = GCControllerButtonInput() // Square Button
    @Published var buttonY = GCControllerButtonInput() // Triangle Button

    // Two Shoulders
    @Published var leftShoulder = GCControllerButtonInput() // L1
    @Published var rightShoulder = GCControllerButtonInput() // R1

    // Two Triggers
    @Published var leftTrigger = GCControllerButtonInput() // L2
    @Published var rightTrigger = GCControllerButtonInput() // R2

    // 2 Thumbstick buttons
    @Published var leftThumbstickButton: GCControllerButtonInput? // L3
    @Published var rightThumbstickButton: GCControllerButtonInput? // R3

    // Directional Pad and 2 Thumbsticks
    @Published var dpad = GCControllerDirectionPad()
    @Published var leftThumbstick = GCControllerDirectionPad()
    @Published var rightThumbstick = GCControllerDirectionPad()

    // Button for all pads and thumbsticks
    @Published var left = GCControllerButtonInput()
    @Published var right = GCControllerButtonInput()
    @Published var up = GCControllerButtonInput()
    @Published var down = GCControllerButtonInput()

    // Axis for all pads and thumbsticks
    @Published var xAxis = GCControllerAxisInput()
    @Published var yAxis = GCControllerAxisInput()

    private var disposables = Set<AnyCancellable>()

    init() {
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
                self.connected = true
                self.venderName = controller.vendorName
                if let exGamepad = controller.extendedGamepad {
                    self.handleControllerValueChange(exGamepad)
                }
            })
            .store(in: &disposables)
        NotificationCenter.default
            .publisher(for: Notification.Name.GCControllerDidDisconnect)
            .map( { ($0.object as! GCController) } )
            .sink(receiveValue: { controller in
                self.connected = false
                self.venderName = controller.vendorName
                if let exGamepad = controller.extendedGamepad {
                    self.handleControllerValueChange(exGamepad)
                }
            })
            .store(in: &disposables)
    }

    func handleControllerValueChange(_ exGamepad: GCExtendedGamepad) {
        exGamepad.valueChangedHandler = {
            (gamepad: GCExtendedGamepad, element:GCControllerElement) in
            // 4 Face buttons
            if (gamepad.buttonA == element) {
                self.buttonA = gamepad.buttonA
            }
            if (gamepad.buttonB == element) {
                self.buttonB = gamepad.buttonB
            }
            if (gamepad.buttonX == element) {
                self.buttonX = gamepad.buttonX
            }
            if (gamepad.buttonY == element) {
                self.buttonY = gamepad.buttonY
            }
            // Two Shoulders
            if (gamepad.leftShoulder == element) {
                self.leftShoulder = gamepad.leftShoulder
            }
            if (gamepad.rightShoulder == element) {
                self.rightShoulder = gamepad.rightShoulder
            }
            // Two Triggers
            if (gamepad.leftTrigger == element) {
                self.leftTrigger = gamepad.leftTrigger
            }
            if (gamepad.rightTrigger == element) {
                self.rightTrigger = gamepad.rightTrigger
            }
            // 2 Thumbstick buttons
            if (gamepad.leftThumbstickButton == element) {
                self.leftThumbstickButton = gamepad.leftThumbstickButton
            }
            if (gamepad.rightThumbstickButton == element) {
                self.rightThumbstickButton = gamepad.rightThumbstickButton
            }
            // Directional Pad
            if (gamepad.dpad == element) {
                self.dpad = gamepad.dpad
                self.updateDirection(gamepad.dpad)
            }
            // 2 Thumbsticks
            if (gamepad.leftThumbstick == element) {
                self.leftThumbstick = gamepad.leftThumbstick
                self.updateDirection(gamepad.leftThumbstick)
            }
            if (gamepad.rightThumbstick == element) {
                self.rightThumbstick = gamepad.rightThumbstick
                self.updateDirection(gamepad.rightThumbstick)
            }
        }
    }

    func updateDirection(_ pad: GCControllerDirectionPad) {
        self.left = pad.left
        self.right = pad.right
        self.up = pad.up
        self.down = pad.down
        self.xAxis = pad.xAxis
        self.yAxis = pad.yAxis
    }
}
