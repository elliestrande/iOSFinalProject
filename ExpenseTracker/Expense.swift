//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Ellie Strande on 5/15/24.
//

import Foundation
import SwiftUI

struct Expense: Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var amount: String
    var imageName: String
    var logoName: String
}
