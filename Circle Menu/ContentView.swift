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
            ItemModel(icon: "folder.fill", color: .cyan),
//            
//            ItemModel(icon: "paperplane.fill", color: .blue),
//            ItemModel(icon: "square.and.arrow.up.fill", color: .green),
//            ItemModel(icon: "eraser.fill", color: .orange),
//            ItemModel(icon: "trash.fill", color: .indigo),
//            ItemModel(icon: "folder.fill", color: .pink)
        ]
    }()
    
    let colors: [AnyGradient] = [
        Color.red.gradient,
        Color.green.gradient,
        Color.blue.gradient,
        Color.pink.gradient,
        Color.purple.gradient,
        Color.orange.gradient,
        Color.yellow.gradient,
        Color.indigo.gradient,
        Color.mint.gradient,
        Color.teal.gradient
    ]
    @State private var path = NavigationPath()
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            let itemWidth = (size.width - 60) / 2
            let itemHeight = itemWidth * 1.5
            
            NavigationStack(path: $path) {
                ZStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20.0), count: 2), spacing: 20.0,
                                  content: {
                            ForEach(colors, id: \.self) { color in
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(color)
                                    .frame(width: itemWidth, height: itemHeight)
                            }
                        })
                        .padding([.leading, .trailing], 20.0)
                    }
                    CircleView(items: $items) { item in
                        print("Complete", item.id)
                        path.append(item)
                    }
                    .position(
                        x: size.width - 70,
                        y: size.height - 40)
                    .navigationDestination(for: ItemModel.self) { item in
                        ZStack {
                            Rectangle()
                                .fill(item.color)
                                .ignoresSafeArea()
                            
                            Image(systemName: item.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .tint(.white)
        }
        }
}
#Preview {
    ContentView()
}
