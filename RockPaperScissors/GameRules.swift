//
//  GameRules.swift
//  RockPaperScissors
//
//  Created by Eli J on 1/2/26.
//

import SwiftUI

enum Move: String, CaseIterable, Identifiable {
    case rock, paper, scissors
    var id: String { rawValue }
    
    var label: String {
        switch self {
        case .rock: "Rock"
        case .paper: "Paper"
        case .scissors: "Scissors"
        }
    }
    
    /// The move this move defeats
    var beats: Move {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }
    
    /// The move that defeats this move
    var losesTo: Move {
        switch self {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }
}

enum Objective: String, CaseIterable {
    case win, lose
    
    var label: String {
        switch self {
        case .win: "WIN"
        case .lose: "LOSE"
        }
    }
}

enum Outcome { case win, lose, tie }

func outcome(player: Move, versus opponent: Move) -> Outcome {
    if player == opponent { return .tie }
    if player.beats == opponent { return .win }
    return .lose
}
