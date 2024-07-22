//
//  ContentView.swift
//  Circle Menu
//
//  Created by Oncu Can on 21.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var items: [ItemModel] = {
        return [
        ItemModel(),
        ItemModel(),
        ItemModel()
        ]
    }()
    var body: some View {
        CircleView(items: $items)
    }
}
#Preview {
    ContentView()
}
