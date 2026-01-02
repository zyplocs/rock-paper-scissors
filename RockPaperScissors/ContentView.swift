//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Eli J on 1/2/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = GameModel()
    @State private var showFinal = false
    
    var body: some View {
        VStack(spacing: 18) {
            Spacer()
            HStack{
                Text("🪨")
                Text("- 📄 -")
                Text("✂️")
            }
            .font(.largeTitle.weight(.semibold))
            Spacer()
            Text("Round \(model.roundNumber) of \(model.totalRounds)")
                .font(.headline)
            
            VStack(spacing: 8) {
                Text("Opponent plays")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(model.opponent.label)
                    .font(.system(size: 44, weight: .bold))
            }
            
            VStack(spacing: 6) {
                Text("Your goal")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(model.objective.label)
                    .font(.title2.weight(.bold))
            }
            
            HStack(spacing: 14) {
                ForEach(Move.allCases) { move in
                    Button {
                        model.submit(move)
                        if model.gameOver { showFinal = true }
                    } label: {
                        Text(move.label)
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 52)
                    }
                    .buttonStyle(.glass)
                }
            }
            
            if let feedback = model.feedback {
                Text(feedback)
                    .font(.headline)
            }
            Spacer()
            Spacer()
            Text("Score: \(model.score) / \(model.totalRounds)")
                .font(.title3.weight(.semibold))
            
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $showFinal) {
            Button("Play again") { model.reset() }
            Button("OK", role: .cancel) { }
        } message: {
            Text("You scored a \(model.score) out of \(model.totalRounds).")
        }
    }
}

#Preview {
    ContentView()
}
