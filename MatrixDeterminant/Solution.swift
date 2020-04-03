//
//  Solution.swift
//  MatrixDeterminant
//
//  Created by Valery Garaev on 4/3/20.
//  Copyright © 2020 Valery Garaev. All rights reserved.
//

import Foundation

struct Solution {
    
    func generateMatrix(ofSize size: Int) -> [[Int]] {
        var matrix = [[Int]]()
        for _ in 0..<size {
            var tempArray = [Int]()
            for _ in 0..<size {
                let number = Int.random(in: 0...size)
                tempArray.append(number)
            }
            matrix.append(tempArray)
        }
        return matrix
    }
    
    func calculateDeterminant(ofMatrix matrix: [[Int]], size: Int) -> Int {
        var determinant = 0
        
        switch size {
        case 1:
            determinant = matrix[0][0]
        case 2:
            let a = matrix[0][0] * matrix[1][1]
            let b = matrix[1][0] * matrix[0][1]
            determinant = a - b
        default:
            var subMatrix = Array(repeating: Array(repeating: 0, count: size - 1), count: size - 1)
            for x in 0..<size {
                var subY = 0
                for y in 1..<size {
                    var subZ = 0
                    for z in 0..<size {
                        if z == x { continue }
                        subMatrix[subY][subZ] = matrix[y][z]
                        subZ += 1
                    }
                    subY += 1
                }
                determinant = determinant + (Int(pow(-1.0, Double(x))) * matrix[0][x] * calculateDeterminant(ofMatrix: subMatrix, size: size - 1))
            }
        }
        return determinant
    }
    
}
