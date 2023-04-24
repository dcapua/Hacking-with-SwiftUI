class Animal {
    let numLegs: Int
    
    init(numLegs:Int){
        self.numLegs=numLegs
    }
}

class Dog: Animal {

    func speak(){
        print("BarkBark")
    }
}

class Cat:Animal {
    var isTame:Bool

    init(numLegs: Int, isTame:Bool){
        self.isTame = isTame
        super.init(numLegs: numLegs)
    }

    func speak(){
        print("MeowMeow")
    }
}

class Corgi:Dog{

    override func speak(){
        print("WoofWoof")
    }
}

class Poodle:Dog{

    override func speak(){
        print("YipYip")
    }
}

class Persian:Cat{

    override func speak(){
        print("HissHiss")
    }
}

class Lion:Cat{

    override func speak(){
        print("BooBoo")
    }
}

//test

let corgi = Corgi(numLegs: 4)
let poodle = Poodle(numLegs: 4)
let persian = Persian(numLegs: 4, isTame: true)
let lion = Lion(numLegs: 4, isTame: false)

corgi.speak()
poodle.speak()
persian.speak()
lion.speak()