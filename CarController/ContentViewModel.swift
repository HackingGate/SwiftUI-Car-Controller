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
    private var cancellables: [AnyCancellable] = []

    init(controller: GCController?) {
        self.controller = controller
        self.subscribe()
    }

    deinit {
        for sub in self.cancellables {
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
            })
            .store(in: &cancellables)
    }
}
