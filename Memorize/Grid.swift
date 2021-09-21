//
//  Grid.swift
//  Memorize
//
//  Created by Tanya Berezovsky on 23/01/2021.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    private var items: [Item]
    private var viewForItem:  (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geomerty in
            self.createBody(for: GridLayout(itemCount: items.count, in: geomerty.size))
        }
    }
    
    private func createBody(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item) //else { return View() } //self.index(of: item)
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
        
    }
}
