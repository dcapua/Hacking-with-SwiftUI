protocol Building {
    var numRooms:Int {get}
    var cost:Int {get set}
    var nameRE: String {get set}
    
    func printSalesSummary()
}

struct House:Building {
    var numRooms: Int
    var cost: Int
    var nameRE: String
    
    func printSalesSummary() {
        print("Number of Rooms: \(numRooms)\nCost: \(cost)\nAgent: \(nameRE)")
    }
}

struct Office:Building{
    var numRooms: Int
    var cost: Int
    var nameRE: String
    
    func printSalesSummary() {
        print("Number of Rooms: \(numRooms)\nCost: \(cost)\nAgent: \(nameRE)")
    }
}

extension Office{
    init(numRooms:Int, nameRE:String){
        self.numRooms = numRooms
        self.cost = numRooms*10000
        self.nameRE = nameRE
    }
}

//test
var house = House(numRooms: 4, cost: 500000, nameRE: "Bill")
var office = Office(numRooms: 24, nameRE: "Susan") //uses initializer from extension rather than default memberwise initializer.
house.printSalesSummary()
office.printSalesSummary()