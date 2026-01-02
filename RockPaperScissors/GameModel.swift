//
//  GameModel.swift
//  RockPaperScissors
//
//  Created by Eli J on 1/2/26.
//
import SwiftUI
import Combine

extension CaseIterable where AllCases: RandomAccessCollection {
    static func randomCase() -> Self {
        let cases = Array(allCases)
        return cases[Int.random(in: 0..<cases.count)]
    }
}

@MainActor
final class GameModel: ObservableObject {
    @Published private(set) var roundNumber = 1
    @Published private(set) var score = 0
    
    @Published private(set) var opponent: Move = .randomCase()
    @Published private(set) var objective: Objective = .randomCase()
    
    @Published var feedback: String? = nil
    @Published var gameOver = false
    
    let totalRounds = 10
    
    func submit(_ playerMove: Move) {
        guard !gameOver else { return }
        
        let result = outcome(player: playerMove, versus: opponent)
        let correct = (objective == .win && result == .win) || (objective == .lose && result == .lose)
        
        if correct {
            score += 1
            feedback = "Correct"
        } else {
            feedback = "Incorrect"
        }
        
        advanceRound()
    }
    
    func reset() {
        roundNumber = 1
        score = 0
        feedback = nil
        gameOver = false
        newPrompt()
    }
    
    private func advanceRound() {
        if roundNumber >= totalRounds {
            gameOver = true
        } else {
            roundNumber += 1
            newPrompt()
        }
    }
    
    private func newPrompt() {
        opponent = .randomCase()
        objective = .randomCase()
    }
}
