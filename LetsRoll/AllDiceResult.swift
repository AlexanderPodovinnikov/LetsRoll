//
//  RollAllResult.swift
//  LetsRoll
//
//  Created by Alex Po on 25.06.2022.
//

import Foundation

struct AllDiceResult {
    var sides: Int
    var number: Int
    var results = [Int]()
    
    init(type sides: Int, number:  Int) {
        self.sides = sides
        self.number = number
        
        for _ in 0..<number {
            if sides != 0 {
                let result = Int.random(in: 1...sides)
                results.append(result)
            } else {
                results.append(0)
            }
        }
    }
}
