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
            ItemModel(icon: "heart.fill", color: .yellow),
            ItemModel(icon: "cloud.fill", color: .red),
            ItemModel(icon: "folder.fill", color: .cyan)
        ]
    }()
    var body: some View {
        CircleView(items: $items)
    }
}
#Preview {
    ContentView()
}
