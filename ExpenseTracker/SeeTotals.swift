//
//  SeeTotals.swift
//  ExpenseTracker
//
//  Created by Ellie Strande on 5/15/24.
//

import SwiftUI

struct SeeTotals: View {
    
    @EnvironmentObject var expenseStore: ExpenseStore
    
    // computed property to get all amounts
    var allAmounts: [String] {
        expenseStore.expenses.map { $0.amount }
    }
    
    // computed property to calculate total amount
    var totalAmount: Double {
        expenseStore.expenses.map { Double($0.amount) ?? 0 }.reduce(0, +)
    }
    
    // Computed property to format total amount to two decimal places
    var formattedTotalAmount: String {
        String(format: "%.2f", totalAmount)
    }
    
    var totalYearlyAmount: Double {
        totalAmount * 12
    }
    
    // Computed property to format total amount to two decimal places
    var formattedYearlyTotalAmount: String {
        String(format: "%.2f", totalYearlyAmount)
    }
    
    var income: Double = 6000.00
    
    var leftOverMoney: Double {
        income - totalAmount
    }
    var formattedLeftOverMoney: String {
        String(format: "%.2f", leftOverMoney)
    }

    var body: some View {
        VStack {
            Text("Expense Totals")
                .font(.title)
                .padding(.top, 30)
                .padding(10)
                .bold()
                .foregroundColor(Color(hex: "#7ed957"))
            
            Text("Expenses")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ScrollView{
                ZStack {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(Color(hex: "#f1f0f0"))
                        .frame(width: 360, height: 300)
                    LazyVStack(spacing: 10) {
                        ForEach (expenseStore.expenses) { expense in
                            ListCell1(expense: expense)
                        }
                    }
                }
            }
            .padding()
            
            Text("Totals")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "#f1f0f0"))
                    .frame(width: 360, height: 100)
                
                VStack {
                    Text("Total Monthly")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    Text("Expenses:")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                }
                    
                Text("-$\(formattedTotalAmount)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                    .foregroundColor(.red)
                    .font(.title3)
                    .bold()
            }
            .padding(5)
            
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "#f1f0f0"))
                    .frame(width: 360, height: 100)
                VStack{
                    
                    Text("Total Yearly")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .font(.title3)
                        .bold()
                    Text("Expenses:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .font(.title3)
                        .bold()
                }
                
                Text("-$\(formattedYearlyTotalAmount)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                    .font(.title3)
                    .foregroundColor(.red)
                    .bold()
            }
            .padding(5)
            
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "#f1f0f0"))
                    .frame(width: 360, height: 100)
                VStack{
                    Text("Monthly Income")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .font(.title3)
                        .bold()
                    Text("After Expenses:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .font(.title3)
                        .bold()
                }
                
                Text("$\(formattedLeftOverMoney)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                    .font(.title3)
                    .foregroundColor(.green)
                    .bold()
            }
            .padding(5)
        }
     }
}

struct SeeTotals_Previews: PreviewProvider {
    static var previews: some View {
      SeeTotals()
          .environmentObject(ExpenseStore(expenses: expenseData)) // Provide a mock ExpenseStore
    }
}

// ListCell Subview that displays ExpenseDetail
struct ListCell1: View {
    var expense: Expense
    var body: some View {
        NavigationLink (destination: ExpenseDetail(selectedExpense: expense)) {
            ZStack {
                HStack {
                    Image(expense.logoName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                        .cornerRadius(10)
                        .padding(.leading, 10)
                    Text(expense.name)
                        .foregroundColor(.primary)
                        .font(.title3)
                    Spacer()
                    Text("-$" + expense.amount)
                        .foregroundColor(.red)
                        .font(.body)
                        .padding(.trailing, 30)
                        .bold()
                }
            }
        }
    }
}
