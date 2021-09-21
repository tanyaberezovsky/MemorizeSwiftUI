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
    static private var name: String!
    static private var type: ThemeType!
    var score: Int {
        model.score
    }
    var themeName: String {
        return EmojiMemoryGameViewModel.name
    }
    var themeColor: Color {
        switch EmojiMemoryGameViewModel.type {
        case .Bakery:
            return .black
        case .Desert:
            return .yellow
        case .Flowers:
            return .pink
        case .Fruites:
            return .red
        case .Halloween:
            return .orange
        case .Sport:
            return .blue
        case .Trees:
            return .green
        case .Vegetables:
            return .purple
        default:
            return .gray
        }
    }
    private static func creatMemoryGame(_ themes: GameThemesStringFabric = GameThemesStringFabric()) -> MemoryGameModel<String> {
        let theme = themes.randomTheme()
        type = theme.type
        name = theme.name
       // /Users/tanya/crow/projects/SwiftUIStanfordCourse/Memorize/Memorize/EmojiMemoryGameViewModel.swift:24:9: Instance member  cannot be used on type 'EmojiMemoryGameViewModel'
        let emojis: Array<String> = theme.emojis
        let numberOfPairs =  theme.numberOfPairs
        print("numberOfPairs = \(numberOfPairs)")
        return MemoryGameModel<String>(numberOfPairsOfCards: numberOfPairs) { i in
            return emojis[i]
        }
    }
    
    
    //MARK: - Access to the model
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    func newGame() {
        model = EmojiMemoryGameViewModel.creatMemoryGame()
//        var themes: Themes<String>
//        themes = Themes(themes: Array<Theme<String>>.ap)
        
    }
    //MARK: - Intent(s)
    func choose(card: MemoryGameModel<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    
}
