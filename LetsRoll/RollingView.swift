//
//  RollingView.swift
//  LetsRoll
//
//  Created by Alex Po on 22.06.2022.
//

import SwiftUI


struct RollingView: View {
    let numberOfSides: Int
    @Binding var results: [Int]
    @State private var total = 0
    
//    init(numberOfSides: Int, results: Binding<[Int]>) {
//        self.numberOfSides = numberOfSides
//        _results = results
//
//    }
    
    var body: some View {
        VStack {
            ForEach(0..<results.count, id: \.self) { number in
                DiceView(numberOfSides: numberOfSides, result: $results[number])
                
            }
            .onChange(of: results) { newValue in
                for i in 0..<newValue.count {
                    total += newValue[i]
                }
            }
            Text("Total: \(total)")
        }
    }
}

struct RollingView_Previews: PreviewProvider {
    @State static var results = [0,0]
    static var previews: some View {
        RollingView(numberOfSides: 6, results: $results)
    }
}
