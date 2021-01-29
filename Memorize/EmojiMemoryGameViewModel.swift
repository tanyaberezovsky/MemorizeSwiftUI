//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 03/01/2021.
//

import SwiftUI

//func cardContentFactory: (Int) -> String {
//    return ""
//}creatMemoryGame()

//view model
class EmojiMemoryGameViewModel: ObservableObject {
    @Published private(set) var model: MemoryGameModel<String> = EmojiMemoryGameViewModel.creatMemoryGame()
    
    static func creatMemoryGame() -> MemoryGameModel<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        let numberOfPairs =  Int.random(in: 2..<emojis.count+1)
        print("numberOfPairs = \(numberOfPairs)")
        return MemoryGameModel<String>(numberOfPairsOfCards: numberOfPairs) { i in
            return emojis[i]
        }
    }
    //MARK: - Access to the model
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGameModel<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}
