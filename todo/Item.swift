//
//  Item.swift
//  todo
//
//  Created by Himanish M. on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var itemName: String
    var itemContent: String
    var isComplete: Bool
    
    init(_timestamp: Date, _itemName: String, _itemContent: String) {
        self.timestamp = _timestamp
        self.itemName = _itemName
        self.itemContent = _itemContent
        self.isComplete = false
    }
}
