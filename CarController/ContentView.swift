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
            Text("\(viewModel.controller?.vendorName ?? "No Controller Connected")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
