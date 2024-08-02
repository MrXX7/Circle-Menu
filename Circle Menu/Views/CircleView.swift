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
    @State private var plusScale: Bool = false
    @State private var isBounceAnimating: Bool = false
    @State private var setDistance: Double = 0.0
    @State private var cirStrokeTo: Double = 0.0
    @State private var cirAngle: Double = 0.0
    @State private var cirStrokeScale: Double = 0.0
    
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
                    strokeView()
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
            guard !isBounceAnimating else {
                return
            }
            isBounceAnimating = true
            
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
        .zIndex(5)
        .rotationEffect(.degrees(plusDegrees))
        .scaleEffect(plusScale ? 0.9 : 1)
        .opacity(plusOpacity)
    }
    fileprivate func plusDidTap() {
        plusScale.toggle()
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            plusDegrees = plusDegrees == 45 ? 0 : 45
            plusOpacity = plusDegrees == 45 ? 0.4 : 1
            
            plusScale.toggle()
            
            setDistance = plusDegrees == 45 ? distance : 0.0
            
        } completion: {
            isBounceAnimating = false
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
                    
                    cirAngle = item.angle
                    withAnimation(.easeInOut(duration: 2.0)) {
                        cirStrokeTo = 1.0
                    } completion: {
                        cirStrokeTo = 0.0
                    }
                } label: {
                    Image(systemName: item.icon)
                        .frame(width: buttonHeight, height: buttonHeight)
                        .tint(.white)
                        .background(item.color)
                        .clipShape(.rect(cornerRadius: buttonHeight/2))
                }
                .rotationEffect(.degrees(-item.angle))
            }
        zIndex(2.0)
            .offset(x: -setDistance)
            .rotationEffect(.degrees(item.angle))
            .scaleEffect(setDistance == 0 ? 0.0 : 1.0)
            .opacity(setDistance == 0 ? 0.0 : 1.0)
    }}

extension CircleView {
    @ViewBuilder
    private func strokeView() -> some View {
        Rectangle()
            .fill(.orange)
            .overlay {
                Circle()
                    .trim(from: 0.0, to: cirStrokeTo)
                    .stroke(
                        Color.blue,
                        style: StrokeStyle(
                            lineWidth: buttonHeight,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .scaleEffect(x: cirStrokeScale, y: cirStrokeScale)
                    .frame(width: setDistance*2, height: setDistance*2)
            }
            .rotationEffect(.degrees(-180+cirAngle))
    }
}

#Preview {
    ContentView()
}
