//
//  ContentView.swift
//  CarController
//
//  Created by HG on 2020/02/24.
//  Copyright © 2020 HG. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    var body: some View {
        VStack {
            VStack {
                if (viewModel.venderName != nil) {
                    Text("\(viewModel.venderName!)")
                }
                Text("\(viewModel.connected ? "Connected" : "Not Connected")")
            }
            .padding()
            HStack {
                VStack {
                    Text("L1: \(viewModel.leftShoulder.isPressed ? "Pressed" : "No")")
                    Text("L2: \(viewModel.leftTrigger.value)")
                    if (viewModel.leftThumbstickButton != nil) {
                        Text("L3: \(viewModel.leftThumbstickButton!.isPressed ? "Pressed" : "No")")
                    } else {
                        Text("L3: Not Activated")
                    }
                }
                .padding()
                Spacer()
                VStack {
                    Text("R1: \(viewModel.rightShoulder.isPressed ? "Pressed" : "No")")
                    Text("R2: \(viewModel.rightTrigger.value)")
                    if (viewModel.rightThumbstickButton != nil) {
                        Text("R3: \(viewModel.rightThumbstickButton!.isPressed ? "Pressed" : "No")")
                    } else {
                        Text("R3: Not Activated")
                    }
                }
                .padding()
            }
            Spacer()
            HStack {
                VStack {
                    Text("Left: \(viewModel.dpad.left.isPressed ? "Pressed" : "No")")
                    Text("Right: \(viewModel.dpad.right.isPressed ? "Pressed" : "No")")
                    Text("Up: \(viewModel.dpad.up.isPressed ? "Pressed" : "No")")
                    Text("Down: \(viewModel.dpad.down.isPressed ? "Pressed" : "No")")
//                    Text("xAxis: \(viewModel.dpad.xAxis.value)")
//                    Text("yAxis: \(viewModel.dpad.yAxis.value)")
                }
                .padding()
                Spacer()
                VStack {
                    Text("A: \(viewModel.buttonA.isPressed ? "Pressed" : "No")")
                    Text("B: \(viewModel.buttonB.isPressed ? "Pressed" : "No")")
                    Text("X: \(viewModel.buttonX.isPressed ? "Pressed" : "No")")
                    Text("Y: \(viewModel.buttonY.isPressed ? "Pressed" : "No")")
                }
                .padding()
            }
            Spacer()
            HStack {
                VStack {
                    Text("Left: \(viewModel.leftThumbstick.left.isPressed ? "Pressed" : "No")")
                    Text("Right: \(viewModel.leftThumbstick.right.isPressed ? "Pressed" : "No")")
                    Text("Up: \(viewModel.leftThumbstick.up.isPressed ? "Pressed" : "No")")
                    Text("Down: \(viewModel.leftThumbstick.down.isPressed ? "Pressed" : "No")")
                    Text("xAxis: \(viewModel.leftThumbstick.xAxis.value)")
                    Text("yAxis: \(viewModel.leftThumbstick.yAxis.value)")
                }
                .padding()
                Spacer()
                VStack {
                    Text("Left: \(viewModel.rightThumbstick.left.isPressed ? "Pressed" : "No")")
                    Text("Right: \(viewModel.rightThumbstick.right.isPressed ? "Pressed" : "No")")
                    Text("Up: \(viewModel.rightThumbstick.up.isPressed ? "Pressed" : "No")")
                    Text("Down: \(viewModel.rightThumbstick.down.isPressed ? "Pressed" : "No")")
                    Text("xAxis: \(viewModel.rightThumbstick.xAxis.value)")
                    Text("yAxis: \(viewModel.rightThumbstick.yAxis.value)")
                }
                .padding()
            }
//            Spacer()
//            VStack {
//                Text("Left: \(viewModel.left.isPressed ? "Pressed" : "No")")
//                Text("Right: \(viewModel.right.isPressed ? "Pressed" : "No")")
//                Text("Up: \(viewModel.up.isPressed ? "Pressed" : "No")")
//                Text("Down: \(viewModel.down.isPressed ? "Pressed" : "No")")
//                Text("xAxis: \(viewModel.xAxis.value)")
//                Text("yAxis: \(viewModel.yAxis.value)")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
