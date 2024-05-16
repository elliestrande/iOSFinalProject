//
//  ExpenseData.swift
//  ExpenseTracker
//
//  Created by Ellie Strande on 5/15/24.
//

import Foundation
import UIKit
import SwiftUI

var expenseData: [Expense] = loadJson("expenseData.json")

// function to load in the productData.json file & translate the product entires into an array of Product objects
func loadJson<T: Decodable>(_ filename: String) -> T {

    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    
    else {
        fatalError("\(filename) not found.")
    }
    // read json file
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }
}
