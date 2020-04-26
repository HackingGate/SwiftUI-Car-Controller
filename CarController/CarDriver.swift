//
//  CarDriver.swift
//  CarController
//
//  Created by HG on 2020/04/26.
//  Copyright © 2020 HG. All rights reserved.
//

import Foundation

struct CarMove {
    var l: Int
    var r: Int
}

struct CarDriver {
    static func getCarMove(xAxisValue: Float, yAxisValue: Float ) -> CarMove {
        var moveData = CarMove(l: 0, r: 0)
        if (yAxisValue > 0.5) {
            moveData.l = 1
            moveData.r = 1
        } else if (yAxisValue < -0.5) {
            moveData.l = -1
            moveData.r = -1
        }
        return moveData
    }
}
