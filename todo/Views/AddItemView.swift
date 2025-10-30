//  AddItemView.swift
//
//  Created by Himanish M. on 30/10/25.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var itemNameInput: String = ""
    @State private var itemContentInput: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $itemNameInput)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("Description", text: $itemContentInput)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done",systemImage: "checkmark") {
                        addItem()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(itemNameInput.isEmpty)
                }
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(
                _timestamp: Date(),
                _itemName: itemNameInput,
                _itemContent: itemContentInput
            )
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    AddItemView()
        .modelContainer(for: Item.self, inMemory: true)
}
