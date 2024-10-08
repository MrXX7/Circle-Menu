//
//  ItemModel.swift
//  Circle Menu
//
//  Created by Oncu Can on 22.07.2024.
//

import SwiftUI

struct ItemModel: Identifiable, Hashable {
    
    var id: Int = 0
    var angle: Double = 0.0
    let icon: String
    let color: Color
    var zIndex: Double = 1.0
}
