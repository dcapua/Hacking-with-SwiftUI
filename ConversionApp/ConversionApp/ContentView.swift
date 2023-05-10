//
//  ContentView.swift
//  ConversionApp
//
//  Created by Danny Capua on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    let units = ["C", "F", "K"]
    @State private var selectedInputUnit = "K"
    @State private var selectedOutputUnit = "K"
    @State private var inputNumber: Double = 0
    
    @FocusState private var tempIsFocused: Bool
    
    var inputInKelvin: Double {
        if selectedInputUnit == "C" {
            return inputNumber + 273.15
        } else if selectedInputUnit == "F"{
            return (inputNumber-32)*(5/9)+273.15
        }
        
        return inputNumber
    }
    
    var outputTemp: Double {
        if selectedOutputUnit == "C"{
            return inputInKelvin - 273.15
        } else if selectedOutputUnit == "F" {
            return (inputInKelvin-273.15)*(9/5)+32
        }
        
        return inputInKelvin
    }
    
    
    var body: some View {
        Form {
            Section {
                TextField ("Input Temp", value: $inputNumber, format:
                        .number)
                .keyboardType(.decimalPad) // add numpad
                .focused($tempIsFocused)
                Picker ("Unit", selection: $selectedInputUnit){
                    ForEach(units, id: \.self){
                        Text($0)
                    }
                }
            } header : {
                Text("Input temperature")
            }
            
            Section {
                HStack {
                    Text("\(outputTemp.formatted())")
                    Picker ("", selection: $selectedOutputUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                }
            } header : {
                Text("Output temperature")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
