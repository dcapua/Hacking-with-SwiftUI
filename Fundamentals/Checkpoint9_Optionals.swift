func randomOptional(_ arr: [Int]?) -> Int{
    arr?.randomElement() ?? Int.random(in: 1...100)
}

//test
print(randomOptional([128, 256, 512, 1024, 2048]))
print(randomOptional([]))
