//
//  Cardify.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 04/03/2021.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    
    //MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgelineWidth: CGFloat = 3

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View{
        ZStack{
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgelineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (0,1,0)
        )
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
