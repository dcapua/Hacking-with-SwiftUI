enum errors: Error {
    case OutOfBounds, NoRoot
}

func squareRoot(_ input: Int) throws -> Int{
    if input < 1 || input > 10000{
        throw errors.OutOfBounds
    }
    for n in 1...10000 {
        if n*n == input {
            return n
        }
    }
    throw errors.NoRoot
}

for num in -1...10001{
    do {
        let sqrt = try squareRoot(num)
        print("Square root of \(num) is \(sqrt)")
    }
    catch errors.NoRoot{
        print("No root for \(num)")
    }
    catch errors.OutOfBounds{
        print("Out of bounds!")
    }
}