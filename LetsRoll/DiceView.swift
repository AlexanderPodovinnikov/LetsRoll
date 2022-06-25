//
//  DiceView.swift
//  LetsRoll
//
//  Created by Alex Po on 21.06.2022.
//

import SwiftUI

struct DiceView: View {
    let numberOfSides: Int
    @Binding var result: Int
        
    var body: some View {
        
            Image(systemName: "\(result).square")
                .font(.largeTitle)
                .onAppear(perform: rollDice)
    }
    
    func rollDice() {
        result = Int.random(in: 1...numberOfSides)
    }
}

struct DiceView_Previews: PreviewProvider {
    @State static var result = 5
    static var previews: some View {
        DiceView(numberOfSides: 6, result: $result)
    }
}
