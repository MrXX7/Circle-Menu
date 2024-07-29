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
    
    var startAngle: Double = 0.0
    var endAngle: Double = 120.0
    
    @Binding var items: [ItemModel]
    
    @State private var plusDegrees: Double = 0.0
    @State private var plusOpacity: Double = 1.0
    @State private var plusScale: Double = 1.0
    
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
            .onAppear {
                updateItems()
            }
    }
    
    fileprivate func updateItems() {
        let step = getStep()
        
        for i in 0..<items.count {
            let angle: Double = startAngle + Double(i) * step
            
            items[i].id = i
            items[i].angle = angle
        }
    }
    
    fileprivate func getStep() -> Double {
        var length = endAngle - startAngle
        var count = items.count
        
        if length < endAngle {
            count -= 1
        } 
    else if length > endAngle {
            length = endAngle
        }
        return length / Double(count)
    }
}

extension CircleView {
    @ViewBuilder
    private func plusView() -> some View {
        Button {
            print("plus did tap")
            plusDidTap()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: buttonHeight, height: buttonHeight)
                .clipShape(.rect(cornerRadius: buttonHeight/2))
                .foregroundStyle(.black)
        }
        .rotationEffect(.degrees(plusDegrees))
        .opacity(plusOpacity)
    }
    fileprivate func plusDidTap() {
        withAnimation(.linear) {
            plusDegrees = plusDegrees == 45 ? 0 : 45
            plusOpacity = plusDegrees == 45 ? 0.4 : 1
        } completion: {
        }
    }
}

extension CircleView {
    @ViewBuilder
    private func itemView(_ item: ItemModel) -> some View {
        RoundedRectangle(cornerRadius: buttonHeight/2)
            .fill(.clear)
            .foregroundColor(.red)
            .frame(width: buttonHeight, height: buttonHeight)
            .overlay {
                Button {
                    print(item.id)
                } label: {
                    Image(systemName: item.icon)
                        .frame(width: buttonHeight, height: buttonHeight)
                        .tint(.white)
                        .background(item.color)
                        .clipShape(.rect(cornerRadius: buttonHeight/2))
                }
                .rotationEffect(.degrees(-item.angle))
            }
            .offset(x: -distance)
            .rotationEffect(.degrees(item.angle))
    }}

#Preview {
    ContentView()
}
