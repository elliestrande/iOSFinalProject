//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ellie Strande on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenseStore : ExpenseStore = ExpenseStore(expenses: expenseData)
    var income = "6000"
    var income1 = 6000.00
    
    // computed property to calculate total amount
    var totalAmount: Double {
        expenseStore.expenses.map { Double($0.amount) ?? 0 }.reduce(0, +)
    }
    
    var leftOverMoney: Double {
        income1 - totalAmount
    }
    var formattedLeftOverMoney: String {
        String(format: "%.2f", leftOverMoney)
    }
    
    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    
                    Spacer()
                    Spacer()
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color(hex: "#7ed957"))
                            .frame(width: 360, height: 175)
                        VStack{
                            Text("Monthly Income: $" + income)
                                .foregroundColor(.white)
                                .font(.title)
                                .padding()
                            HStack{
                                VStack {
                                    Text("Income After")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 40)
                                    Text("Expeses:")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 50)
                                }
                                
                                Text("$\(formattedLeftOverMoney)")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 30)
                            }
                        }
                    }
                    
                    
                    LazyVStack(spacing: 10) {
                        ForEach (expenseStore.expenses) { expense in ListCell(expense: expense)
                        }
                        .onDelete(perform: deleteItem)
                        .onMove(perform: moveItem)
                    }
                    .padding()
                }
                // adding a title at the top of the list to the navigation bar
                .navigationTitle(Text("Expense Home"))
                
                // implementing add & edit buttons to a navigation bar
                .navigationBarItems(leading: NavigationLink(destination: AddNewExpense(expenseStore: self.expenseStore, name: "Enter Expense Name", description: "Enter Expense Description", amount: "Enter Expense Amount", imageName: "", logoName: "")) {
                    Text("Add")
                        .foregroundColor(Color(hex: "#7ed957"))
                        .bold()
                }, trailing: EditButton()
                    .foregroundColor(Color(hex: "#7ed957")))
                .bold()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // see totals tab
            NavigationView {
                SeeTotals().environmentObject(expenseStore)
            }
            .tabItem {
                Label("See Totals", systemImage: "dollarsign.circle.fill")
            }
        }
    }
    
    // function method to be used by Edit button to delete an item from the list
    func deleteItem(at offsets: IndexSet) {
        expenseStore.expenses.remove(atOffsets: offsets)
    }
    
    // function method to be used by Edit button to move an item's position in the list
    func moveItem(from source: IndexSet, to destination: Int) {
        expenseStore.expenses.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// ListCell Subview that displays ExpenseDetail
struct ListCell: View {
    var expense: Expense
    var body: some View {
        NavigationLink (destination: ExpenseDetail(selectedExpense: expense)) {
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "#f1f0f0"))
                    .frame(width: 360, height: 75)
                
                HStack {
                    Image(expense.logoName)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                        .cornerRadius(10)
                    Text(expense.name)
                        .foregroundColor(.primary)
                        .font(.title3)
                    Spacer()
                    Text("$" + expense.amount)
                        .foregroundColor(.red)
                        .font(.title3)
                        .bold()
                        .padding()
                        .padding()
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
