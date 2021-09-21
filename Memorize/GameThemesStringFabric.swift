//
//  GameThemesStringFabric.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 30/01/2021.
//

import Foundation

struct GameThemesStringFabric {
    typealias CardContent = String
    var themes: Array<GameTheme<CardContent>>

    init() {
// when CardContent is generic - GameThemesStringFabric<CardContent>   I'm getting error    Cannot assign value of type 'Array<GameTheme<CardContent>>' to type 'Array<GameTheme<String>>'
//        let themeError = GameTheme<CardContent>(type: ThemeType.Halloween, emojis: ["👻", "🎃", "🕷"])
        let themeHalloween = GameTheme<CardContent>(type: ThemeType.Halloween, emojis: ["👻", "🎃", "🕷"])
        let themeFlovers = GameTheme<CardContent>(type: ThemeType.Flowers, emojis: ["🌷", "🌸", "🌹", "🌺", "🌻", "🌼"], isNumberOfPairsRandom: true)
        let themeTrees = GameTheme<CardContent>(type: ThemeType.Trees, emojis: ["🌲", "🌳", "🎄", "🌴"])
        let themeSport = GameTheme<CardContent>(type: ThemeType.Sport, emojis: ["🏈", "🏉", "🥊"])
        let themeDesert = GameTheme<CardContent>(type: ThemeType.Desert, emojis: ["🌵", "🦂", "🏜", "🐫"])
        let themeVegetables = GameTheme<CardContent>(type: ThemeType.Vegetables, emojis: ["🌶", "🌽", "🥑", "🫑", "🥬"], isNumberOfPairsRandom: true)
        let themeFruites = GameTheme<CardContent>(type: ThemeType.Fruites, emojis: [ "🥭", "🥝", "🍑", "🍒", "🍓", "🍎"], isNumberOfPairsRandom: true)
        let themeBakery = GameTheme<CardContent>(type: ThemeType.Bakery, emojis: ["🥨", "🍪", "🥧", "🍩"])
        themes = [themeHalloween, themeFlovers, themeTrees, themeSport, themeDesert, themeVegetables, themeFruites, themeBakery]
    }
    init(themes: Array<GameTheme<CardContent>>) {
        self.themes = themes
    }
    mutating func add(theme: GameTheme<CardContent>) {
        themes.append(theme)
    }
    func randomTheme() -> GameTheme<CardContent> {
        return themes.randomElement()!
    }
}

enum ThemeType: String {
    case Halloween
    case Flowers
    case Trees
    case Sport
    case Desert
    case Vegetables
    case Bakery
    case Fruites
}

struct GameTheme<CardContent> where CardContent: Equatable {
    var type: ThemeType
    var name: String {
        return type.rawValue.uppercased()
    }
    var emojis: Array<CardContent>
    var isNumberOfPairsRandom: Bool = false
    var numberOfPairs: Int {
        isNumberOfPairsRandom ? Int.random(in: 1..<emojis.count+1) : emojis.count
    }
}
