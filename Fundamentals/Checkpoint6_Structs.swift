struct Car {
    let model:String
    let seatCount: Int
    private(set) var currentGear: Int

    mutating func shiftUp(){
        if currentGear + 1 > 10{
            print("At highest gear.")
        }
        else {
            currentGear += 1
        }
    }

    mutating func shiftDown(){
        if currentGear - 1 < 0{
            print("At lowest gear.")
        }
        else {
            currentGear -= 1
        }
    }
}

//test
var Ferrari = Car(model: "F 150", seatCount: 4, currentGear: 8)
Ferrari.shiftUp()
Ferrari.shiftUp()
print(Ferrari.currentGear)
Ferrari.shiftUp() // should result in error
Ferrari.shiftDown()
print(Ferrari.currentGear)