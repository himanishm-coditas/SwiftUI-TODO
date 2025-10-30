//
//  ItemDetailView.swift
//  todo
//
//  Created by Himanish M. on 30/10/25.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.itemName)
                .font(.title2)
                .bold()
            
            Text(item.itemContent)
                .font(.body)
                .padding(.top, 8)
            
            Text("Created: \(item.timestamp, format: .dateTime)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Task Details")
    }
}
