//
//  ContentView.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 21/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        HStack {
            ForEach (0..<4) { _ in
                CardView(isFaceUp: false)
            }
        }
            
            
        .padding()
        .foregroundColor(.orange)
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke()
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()        
    }
}
