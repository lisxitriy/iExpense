//
//  Model.swift
//  iExpense
//
//  Created by Olga Trofimova on 27.02.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
