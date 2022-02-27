    //
    //  ContentView.swift
    //  iExpense
    //
    //  Created by Olga Trofimova on 11.08.2021.
    //

import SwiftUI

struct ContentView: View {

    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        if item.amount <= 10 {
                            Text("$\(item.amount)")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        } else if item.amount > 11 && item.amount <= 100 {
                            Text("$\(item.amount)")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        } else {
                            Text("$\(item.amount)")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .toolbar { EditButton() }
            .navigationBarItems(leading:
                Button(action: {
                    self.showingAddExpense = true
                    
            }) {
                Image(systemName: "plus")
                }
            )
            
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
           
        }
    }
        func removeItems(at offsets: IndexSet) {
            expenses.items.remove(atOffsets: offsets)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
