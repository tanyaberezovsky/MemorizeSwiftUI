//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 03/01/2021.
//

import Foundation

//model
struct MemoryGameModel<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMachIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMachIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMachIndex].isMatched = true
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
        
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0 ..< numberOfPairsOfCards {
            let cardContent = cardContentFactory(i)
            cards.append(Card(content: cardContent, id: i * 2))
            cards.append(Card(content: cardContent, id: i * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
    }
}

