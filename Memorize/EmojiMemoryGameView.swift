//
//  ContentView.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 21/11/2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
     @ObservedObject var viewModel: EmojiMemoryGameViewModel
 
     var body: some View {
        VStack(content: {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.newGame()
                }
                
            }, label: {
                Text("New Game")
            })
            Spacer()
            Text(viewModel.themeName)
                .bold()
                .foregroundColor(viewModel.themeColor)
            Spacer()
            Text("Score: \(viewModel.score)")
            GridView()
        })
    }
    
    private func GridView() -> some View {
        return Grid (viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration: 0.5)) {
                    viewModel.choose(card: card)
                }
                
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(viewModel.themeColor)
    }
    
}

struct CardView: View {
    var card: MemoryGameModel<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })
    }
    
    @State private var animatedBonusRemainning: Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemainning = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)) {
            animatedBonusRemainning = 0
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemainning*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                        
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                     }
                }
                .padding(5).opacity(0.2)
                .transition(/*@START_MENU_TOKEN@*/.identity/*@END_MENU_TOKEN@*/)
                
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 180 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .font(Font.system(size: fontSize(size)))
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
          
        }
    }
    
    func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * DravingConstants.fontScaleFactor
    }
    
    private struct DravingConstants {
        static let fontScaleFactor: CGFloat = 0.75
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            let game = EmojiMemoryGameViewModel()
            game.choose(card: game.cards[0])
            return EmojiMemoryGameView(viewModel: game)
    }
}
