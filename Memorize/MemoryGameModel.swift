//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 03/01/2021.
//

import Foundation
struct GameScore {
    var score: Int = 0
    
    mutating func matched() {
        score += 2
    }
    mutating func mismatch(_ isMismatched: Bool) {
        if isMismatched {
            score -= 1
        }
    }
}
//model
struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> //setting is private reading is public
    private var gameScore = GameScore()
    var score: Int {
        return gameScore.score
    }
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0 ..< numberOfPairsOfCards {
            let cardContent = cardContentFactory(i)
            cards.append(Card(content: cardContent, id: i * 2))
            cards.append(Card(content: cardContent, id: i * 2 + 1))
        }
        cards.shuffle()
    }
    
   
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            cards[chosenIndex].flips += 1
            if let potentialMachIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMachIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMachIndex].isMatched = true
                    gameScore.matched()
                } else {
                    gameScore.mismatch(cards[chosenIndex].isMismatched)
                    gameScore.mismatch(cards[potentialMachIndex].isMismatched)
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
//                for index in cards.indices {
//                    cards[index].isFaceUp = false
//                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            //self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        }
    }
        
//    struct Card: Identifiable {
//        var isFaceUp: Bool = false
//        var isMatched: Bool = false
//        var isMismatched: Bool {
//            flips > 1 ? true : false
//        }
//        var flips: Int = 0
//        var content: CardContent
//        var id: Int
//
//    }
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
                var isMismatched: Bool {
                    flips > 1 ? true : false
                }
                var flips: Int = 0
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

