//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 21/11/2020.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
        }
    }
}
