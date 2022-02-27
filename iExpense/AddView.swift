//
//  AddView.swift
//  iExpense
//
//  Created by Olga Trofimova on 13.08.2021.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var emptyAmount = false
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    static let types = ["Business", "Personal"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if amount.isEmpty || name.isEmpty {
                    emptyAmount = true
                } else if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    if !name.isEmpty {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
     
            })
            .alert(isPresented: $emptyAmount){
                Alert(title: Text("Wrong"), message: Text("Field is empty"), dismissButton: .default(Text("Continue")) {
                })
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
