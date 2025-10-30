//
//  ContentView.swift
//  todo
//
//  Created by Himanish M. on 27/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order: .reverse) private var items: [Item]
    @State private var showAddItemSheet: Bool = false

    var body: some View {
            NavigationStack {
                if !items.isEmpty {
                    List {
                        ForEach(items) { item in
                                HStack {
                                    Button {
                                        item.isComplete.toggle()
                                    } label: {
                                        Image(systemName: item.isComplete ? "checkmark.circle.fill" : "circle")
                                            .font(.title3)
                                    }
                                    .buttonStyle(.plain)
                                    .foregroundStyle(item.isComplete ? .green : .gray)
                                    NavigationLink {
                                        ItemDetailView(item: item)
                                    } label: {
                                        Text(item.itemName)
                                            .strikethrough(item.isComplete)
                                    }
                                }
                                .foregroundStyle(item.isComplete ? .secondary : .primary)
                           
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("Todo List")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: { showAddItemSheet = true }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "No Tasks Yet",
                        systemImage: "checklist",
                        description: Text("Tap the + button to add your first todo.")
                    )
                    .navigationTitle("Todo List")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: { showAddItemSheet = true }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddItemSheet) {
                AddItemView()
            }
        }
        
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
