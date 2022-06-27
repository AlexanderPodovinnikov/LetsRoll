//
//  ContentView.swift
//  LetsRoll
//
//  Created by Alex Po on 21.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfDice: Int = 1
    var sides = [4, 6, 8, 10, 12]
    @State private var numberOfSides: Int = 6
    @State private var currentRoll = AllDiceResult(type: 0, number: 0)
    
    let columns: [GridItem] = [
        .init(.adaptive(minimum: 30))
    ]
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var stoppedDice = 0
    @State private var rollCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type of dice", selection: $numberOfSides) {
                        ForEach(sides, id: \.self) {
                            Text("\($0) sides")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Stepper("Number of dice: \(numberOfDice)", value: $numberOfDice, in: 1...10)
                    HStack {
                        Spacer()
                        Button("Roll!", action: rollDice)
                        Spacer()
                    }
                } footer: {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<currentRoll.results.count, id: \.self) { diceNumber in
                            Image(systemName: "\(currentRoll.results[diceNumber]).square")
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .font(.title)
                                .padding(5)
                        }
                    }
                }
                .disabled(stoppedDice < currentRoll.results.count)
            }
            .navigationTitle("Let'em Roll")
            .onReceive(timer) { date in
                updateDice()
            }
        }
    }
    func rollDice() {
        stoppedDice = 0
        rollCount = 0
        currentRoll = AllDiceResult(type: numberOfSides, number: numberOfDice)
    }
    func updateDice() {
        guard stoppedDice < currentRoll.results.count else { return }
        for i in stoppedDice..<numberOfDice {
            currentRoll.results[i] = Int.random(in: 1...numberOfSides)
        }
        rollCount += 1
        if rollCount > 9 {
            stoppedDice += 1
            rollCount = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
