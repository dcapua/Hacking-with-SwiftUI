//
//  ContentView.swift
//  BetterRest
//
//  Created by Danny Capua on 6/11/23.
//
// predicts when you should go to bed using ML (based on desired wake up time, amount of sleep, daily coffee intake)

import CoreML // alphabetical import
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7 //7am
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationView {
            
            Form {
                
                //                Section{ // section version
                //                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents:
                //                        .hourAndMinute)
                //                        .labelsHidden()
                //                } header: {
                //                    Text("When do you want to wake up?")
                //                        .font(.headline).textCase(nil)
                //                }

                VStack (alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents:
                            .hourAndMinute)
                    .labelsHidden()

                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                HStack{
                    Text("Daily coffee intake")
                        .font(.headline)
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in:  1...20) // stepper version
                    Picker("", selection: $coffeeAmount){
                        ForEach(1..<21){
                            $0 == 1 ? Text("\($0) cup") : Text("\($0) cups")
                        }
                    }
                }
                
                Spacer()
                
                VStack{
                    Text("Your recommended bedtime is:").bold()
                    HStack {
                        Spacer()
                        Text("\(calculateBedTime())").font(.largeTitle).bold()
                        Spacer()
                    }
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
            .alert("Error", isPresented: $showingAlert){
                Button("OK"){}
            } message: {
                Text("\(calculateBedTime())")
            }
        }
    }
    
//    func calculateBedTime(){
//        do {
//            let config = MLModelConfiguration() // this handles more obscure options for advanced ML folk
//            let model = try SleepCalculator(configuration: config)
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60 // 0 = midnight
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//
//
//        } catch {
//            //something went wrong
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//
//        showingAlert = true
//    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration() // this handles more obscure options for advanced ML folk
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // 0 = midnight
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)


        } catch {
            //something went wrong
            showingAlert = true
            return "Error, try again"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
