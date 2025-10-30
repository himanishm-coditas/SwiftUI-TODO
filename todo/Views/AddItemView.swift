//  AddItemView.swift
//
//  Created by Himanish M. on 30/10/25.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    // Get the model context
    @Environment(\.modelContext) private var modelContext
    
    // Get the environment's "dismiss" action
    @Environment(\.dismiss) private var dismiss
    
    // State is now local to *this* view
    @State private var itemNameInput: String = ""
    @State private var itemContentInput: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $itemNameInput)
                    .padding(16)
                    // Add some styling to see the field
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("Description", text: $itemContentInput)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Spacer() // Pushes fields to the top
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
    
    // The addItem logic now lives here
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
