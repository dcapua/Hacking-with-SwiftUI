let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
let sortedNumbers = luckyNumbers.sorted().filter{$0 % 2 != 0}.map{String("\($0) is a lucky number")}

for num in sortedNumbers{
    print(num)
}