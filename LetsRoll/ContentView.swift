//
//  ContentView.swift
//  LetsRoll
//
//  Created by Alex Po on 21.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var results: [Int] = []
    
    @State private var numberOfDicesIdx: Int = 0
    
    var sides = [4, 6, 8, 10, 12]
    @State private var numberOfSides: Int = 6
    
    @State private var isPresentingRolls = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Picker("Number of dices", selection: $numberOfDicesIdx) {
                        ForEach(1..<5) { number in
                            Text("\(number)")
                        }
                    }
                    Section {
                        Picker("Number of sides", selection: $numberOfSides) {
                            ForEach(sides, id: \.self) { number in
                                Text("\(number) sides")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How many sides should each dice have?")
                    }
                    
                    Button("Roll") {
                        initResults()
                        isPresentingRolls.toggle()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Let's Roll")
            .sheet(isPresented: $isPresentingRolls) {
                RollingView(numberOfSides: numberOfSides, results: $results)
            }
        }
    }
    func initResults() {
        results.removeAll()
        for _ in 0...numberOfDicesIdx {
            results.append(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
