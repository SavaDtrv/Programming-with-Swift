//import Foundation

//let tup:(Int, String) = (25, "Sava Dimitrov")

/* var test:String = "test"
var test1:String = ""
let index = test.index(test.startIndex, offsetBy: 0) //get the first char of the string test */

//print(test[index])


//test1 += String(test[index])
//test.remove(at: test.startIndex)

//let result1 = String(test.dropFirst())
//let result2 = String(str.dropLast()) 

//var asciiA = UInt8(ascii: UnicodeScalar(String(test[index])))
/* var char:String = String(test[index])
print("\(char)") */

//print(test1)
//print("\n\(test)")
//print("\n\(result1)")

/*
let c = Character(UnicodeScalar(65))
var test3 = Character("a").asciiValue
print(test3) */

/* var code = 26
var letter = "Z"

var asciiA = UInt8(ascii: "Z")
asciiA = asciiA + (UInt8(code))

if (asciiA < 65 || asciiA > 90) {
    asciiA = 65 + (asciiA - 90) - 1
}

print(asciiA)

let u = UnicodeScalar(asciiA)
// Convert UnicodeScalar to a Character.
let char = Character(u)

print(char) */

/*



//Task_1: Test stuff
/* 
//var decodeMsg:String = "cde" // abc
var decodeMsg:String = "abc" // yza
let decodeCode:Int = 28 // -> goes backwards
var decodedMsg:String = decode(in:decodeMsg, code:decodeCode)


var decodeMsg1:String = "XYZ" // ZAB
let decodeCode1:Int = -2 // -> goes forward
var decodedMsg1:String = decode(in:decodeMsg1, code:decodeCode1)
var decodeMsg1:String = "ABC" // CDE
var decodeMsg2:String = "AbCd EF" //CdEf GH
var decodeMsg3:String = "AbCd! EF!Zz" //CdEf! GH! Bb

var decodeMsg:String = "" //
var decodeMsg2:String = "WxYz UV" // UvWx ST
var decodeMsg3:String = "WxYz! UV!Aa" //UvWx! ST!Yy

var decodedMsg2:String = decode(in:decodeMsg2, code:decodeCode)
var decodedMsg3:String = decode(in:decodeMsg3, code:decodeCode)

print(decodedMsg)
print(decodedMsg1)
print(decodedMsg2)
print(decodedMsg3) 
*/

//Task_2: Test stuff
/*
// test.remove(at: test.startIndex) - remove the first character in a String, 
// also the same: let result1 = String(test.dropFirst())

STEP 1: Evaluate simple expression - 2 * 3 (+/-//)
STEP 2: Evaluate a more complicated expression - (2 * 3) - 2
STEP 3: Check if it works for an even more complic exprsn - (2 * 3) - (4 - 3)
STEP 4: Add the functionality for minus digit - -2 * (4 - 3) - " - " is 45 in the ASCII table
...
var asciiA = UInt8(ascii: "0")
var asciiA1 = UInt8(ascii: "5")
var asciiA2 = UInt8(ascii: "9")
var asciiA3 = UInt8(ascii: "4")
var asciiA4 = UInt8(ascii: ":")

print("\(isDigit(digitAsAscii:asciiA))")
print("\(isDigit(digitAsAscii:asciiA1))")
print("\(isDigit(digitAsAscii:asciiA2))")
print("\(isDigit(digitAsAscii:asciiA3))")
print("\(isDigit(digitAsAscii:asciiA4))")

//print("\(calculateExprsn(expressionInOut:"abcdef"))")

var numberString:String = "-3.235"
print("\(convertStringToNumber(stringToNumber:numberString))")

//Why does it require (CGFloat, CGFloat), (Float, Float), (Double, Double) and not (Int, Int) or (Double, Int)
var power:Double = 3.0
print("\(pow(power, 2.0))") 
//Also it requires "import Foundation" and abs() not. Why?


/*
var expression1:String = "(2 * 2)" //4 //-4 (-2)
var expression1_1:String = "(2 - 1)" //1
var expression1_2:String = "(2 + 1)"  //3
var expression1_3:String = "(2 / 2)"  //1
var expression1_4:String = "(3 ^ 2)" //9 
print("\(evaluate(expression:expression1))")
print("\(evaluate(expression:expression1_1))")
print("\(evaluate(expression:expression1_2))")
print("\(evaluate(expression:expression1_3))")
print("\(evaluate(expression:expression1_4))")

var expression2:String = "((23 + 7) - -2)" //60 //-60 (-2)
var expression3:String = "((-2) * (23 + 7) * (10 - 10))" //40 //-80 (-2) //((-2) * (23 + 7) - (10 + 10))
var expression4:String = "(11 - 10)" //1
var expression5:String = "((24 - 12) + (-2 * 3))" //18 //6 (-2) //-72 (+ -> *, -2)
var expression6:String = "(((24 - 12) * (-2)) - (5 * (-2.5 ^ 3)))" // -102.125 (-2) //-54.125 (2) //102.125 (-2.5)
print("\(evaluate(expression:expression2))")
print("\(evaluate(expression:expression3))")
print("\(evaluate(expression:expression4))")
print("\(evaluate(expression:expression5))") 
print("\(evaluate(expression:expression6))") 
*/
//var str:String = "(22*2"
//print("\(removeIntervals(stringWithSpaces:str))")
//print("\(convertStringToNumber(stringToNumber:&str))")
//print("\(evaluateSubExpression(evaluateSUBexpression:(4.5, "/", 2.0)))")

*/

Task_3: Test stuff

/* var labth:[[String]] = [ ["^", "0", "0", "0", "0", "0", "0", "1"],
                         ["0", "1", "1", "1", "1", "1", "0", "0"],
                         ["0", "0", "0", "0", "0", "1", "1", "0"],
                         ["0", "1", "1", "1", "0", "1", "0", "0"],
                         ["0", "1", "0", "1", "0", "0", "1", "0"],
                         ["0", "0", "0", "1", "0", "0", "0", "*"] ]

print("\(findPaths(in:labth))") */

/* var matrix:[[Int]] = Array(repeating: Array(repeating: 0, count: 5), count: 3) //[[Int]](repeating: 0, count:4)
print("\(matrix)") */
/* 
print("rows: \(matrix.count) , columns: \(matrix[0].count)")
 */

/* var cell:PointInMatrix = PointInMatrix() //= PointInMatrix(row:1, col:2)
cell.row = 1
cell.col = 2
print("\(cell)")

cell.row = 5
cell.col = 10

print("\(cell)") */

*/