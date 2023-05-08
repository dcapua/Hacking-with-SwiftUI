//
//  ContentView.swift
//  WeSplit
//
//  Created by Danny Capua on 05/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    private var checkTotal:Double {
        checkAmount + Double(tipPercentage)/100 * checkAmount
    }
    
    //let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson:Double {
        //calculate total per person here
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipSelection/100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
//
//    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency { FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
//    } // this wasn't working...
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad) // add numpad
                    .focused($amountIsFocused)
                
                Picker("Number of People", selection: $numberOfPeople){
                    ForEach(2..<100){ // we count starting from 2.
                        Text("\($0) people")
                    }
                }
            }
            
            Section {
                Picker("Tip Percentage", selection: $tipPercentage) {
                    ForEach(0...100, id: \.self){
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.wheel) // picker adopts segmented styling
            } header : {
                Text("How much tip?")
            }
            
            Section {
                Text("$\(checkTotal, specifier: "%.2f")")
            } header : {
                Text("Check Total")
            }
            
            Section {
                Text(totalPerPerson, format:
                        .currency(code: Locale.current.currency?.identifier ?? "USD"))
            } header : {
                Text("Amount per person")
            }
        }
        .navigationTitle("WeSplit")
        .toolbar { //lets us specify toolbar items for a view
            ToolbarItemGroup(placement: .keyboard){ // only keep space when keyboard is visible
                Spacer()
                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
