//
//  CircleView.swift
//  Circle Menu
//
//  Created by Oncu Can on 21.07.2024.
//

import SwiftUI

struct CircleView: View {
    
    var distance: CGFloat = 120.0
    var buttonHeight: CGFloat = 55.0
    
    @Binding var items: [ItemModel]
    
    var body: some View {
        Rectangle()
            .fill(.purple)
            .frame(
                width: distance*2+buttonHeight,
                height: distance*2+buttonHeight)
            .overlay {
                ZStack {
                    plusView()
                    ForEach(items) { item in
                        itemView(item)
                    }
                }
            }
    }
}

extension CircleView {
    @ViewBuilder
    private func plusView() -> some View {
        Button {
            print("plus did tap")
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: buttonHeight, height: buttonHeight)
                .clipShape(.rect(cornerRadius: buttonHeight/2))
                .foregroundStyle(.black)
        }
    }
}

extension CircleView {
    @ViewBuilder
    private func itemView(_ item: ItemModel) -> some View {
        RoundedRectangle(cornerRadius: buttonHeight/2)
            .foregroundColor(.red)
            .frame(width: buttonHeight, height: buttonHeight)
            .offset(x: -distance)
            .rotationEffect(.degrees(item.angle))
    }}

#Preview {
    ContentView()
}
