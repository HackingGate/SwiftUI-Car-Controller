//
//  CarDriver.swift
//  CarController
//
//  Created by HG on 2020/04/26.
//  Copyright © 2020 HG. All rights reserved.
//

import Foundation

struct CarMove {
    var left_r: Bool
    var left_d: Bool
    var right_d: Bool
    var right_r: Bool
}

struct CarDriver {
    static func getCarMove(xAxisValue: Float, yAxisValue: Float ) -> CarMove {
        var moveData = CarMove(left_r: false, left_d: false, right_d: false, right_r: false)
        if (yAxisValue > 0.5) {
            // forward
            moveData.left_r = false
            moveData.left_d = true
            moveData.right_d = true
            moveData.right_r = false
            if (xAxisValue < -0.5) {
                // left
                moveData.left_d = false
            } else if (xAxisValue > 0.5) {
                // right
                moveData.right_d = false
            }
        } else if (yAxisValue < -0.5) {
            // backward
            moveData.left_r = true
            moveData.left_d = false
            moveData.right_d = false
            moveData.right_r = true
            if (xAxisValue < -0.5) {
                // left
                moveData.left_r = false
            } else if (xAxisValue > 0.5) {
                // right
                moveData.right_r = false
            }
        } else {
            if (xAxisValue < -0.5 ) {
                moveData.left_r = true
                moveData.left_d = false
                moveData.right_d = true
                moveData.right_r = false
            } else if (xAxisValue > 0.5) {
                moveData.left_r = false
                moveData.left_d = true
                moveData.right_d = false
                moveData.right_r = true
            }
        }
        return moveData
    }
}
