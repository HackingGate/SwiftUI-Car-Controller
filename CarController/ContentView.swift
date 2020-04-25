//
//  ContentView.swift
//  CarController
//
//  Created by HG on 2020/02/24.
//  Copyright © 2020 HG. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel(controller: nil)
    var body: some View {
        VStack {
            Text("\(viewModel.venderName ?? "No Controller Connected")")
            Text("Left: \(viewModel.left.isPressed ? "Pressed" : "No")")
            Text("Right: \(viewModel.right.isPressed ? "Pressed" : "No")")
            Text("Up: \(viewModel.up.isPressed ? "Pressed" : "No")")
            Text("Down: \(viewModel.down.isPressed ? "Pressed" : "No")")
            Text("xAxis: \(viewModel.xAxis.value)")
            Text("yAxis: \(viewModel.yAxis.value)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
