import Foundation
let DEFAULTFINALRESULT:Double = 0.0
let DEFAULSUBEXPRESSION:(Double,String,Double) = (0.0, "", 0.0)

//function that calculates an equation 
func evaluate(expression:String) -> Double {
    var expressionWithoutSpaces:String = removeIntervals(stringWithSpaces:expression)
    return calculateExprsn(expressionToEvaluate:&expressionWithoutSpaces)
}

func removeIntervals(stringWithSpaces:String) -> String {
    var stringWithoutSpaces:String = stringWithSpaces

    for elem in stringWithoutSpaces {
        if elem == " " {
            if let index = stringWithoutSpaces.index(of: elem) {
                stringWithoutSpaces.remove(at: index)
            }
        }
    }

    //adding a space in the end because when i run it, it sees expression:String as empty string
    stringWithoutSpaces = stringWithoutSpaces + " "
    return stringWithoutSpaces
}

func calculateExprsn(expressionToEvaluate:inout String) -> Double {
    var result:Double = DEFAULTFINALRESULT
    var subExpressionResult:Double = DEFAULTFINALRESULT
    var operands = [Double]()
    var operators = [String]()
    var subExpression:(Double, String, Double) = DEFAULSUBEXPRESSION
    var lastSavedOperand:Double? = nil
    var openingBracket:String = ""

    exprsnLoop: while expressionToEvaluate != "" {
        var index = expressionToEvaluate.index(expressionToEvaluate.startIndex, offsetBy: 0) 
        var symbol = String(expressionToEvaluate[index])
        if !(isDigit(digitAsString:symbol)) && !(isMinusOperator(minusOperator:symbol)) {
            expressionToEvaluate.remove(at: expressionToEvaluate.startIndex)    
        }
            
        if symbol == ")" {
            if subExpression.1 != "" {
                if !(operands.isEmpty) {
                    subExpressionResult = evaluateSubExpression(evaluateSUBexpression:subExpression)
                    subExpression = DEFAULSUBEXPRESSION
                    subExpression.2 = subExpressionResult
                    while !(operands.isEmpty) {
                        if let firstOperand = operands.last {
                            subExpression.0 = firstOperand
                        }
                        operands.removeLast()
                        if let opertr = operators.last {
                            subExpression.1 = opertr
                        }
                        operators.removeLast()
                        result = evaluateSubExpression(evaluateSUBexpression:subExpression)
                        subExpression.2 = result
                    }
                } else {
                    result = evaluateSubExpression(evaluateSUBexpression:subExpression)
                }
                subExpression = DEFAULSUBEXPRESSION
                subExpression.0 = result
                lastSavedOperand = result
            }
        } else if isAnOperator(symbol:symbol) && subExpression.1 == "" && openingBracket == "" {
            if isMinusOperator(minusOperator:symbol) {
                expressionToEvaluate.remove(at: expressionToEvaluate.startIndex)
            }
            subExpression.1 = symbol

            index = expressionToEvaluate.index(expressionToEvaluate.startIndex, offsetBy: 0) 
            symbol = String(expressionToEvaluate[index])
            //handles the cases for expression: _ <operator> (_ <operator> _) OR <operator> (_ <operator> (_ <operator> _))
            if symbol == "(" {
                if checkForOperatorInSubStr(subString:expressionToEvaluate) == 1 {
                    continue exprsnLoop
                } else if checkForOperatorInSubStr(subString:expressionToEvaluate) == 2 {
                    operands.append(subExpression.0)
                    operators.append(subExpression.1)
                    lastSavedOperand = nil
                    subExpression = DEFAULSUBEXPRESSION
                }
            }
        } else if isDigit(digitAsString:symbol) || isMinusOperator(minusOperator:symbol) {
            openingBracket = ""
            let number:Double = convertStringToNumber(stringToNumber:&expressionToEvaluate)
            
            if let checkIfNil = lastSavedOperand {
                if checkIfNil == subExpression.0 {
                    subExpression.2 = number
                    lastSavedOperand = nil
                }
            } else {
                subExpression.0 = number
                lastSavedOperand = number
            }
        } else if symbol == "(" {
            openingBracket = symbol
        }
    }

    if result == 0 {
        return 0.0
    }
    
    return result
}

func isDigit(digitAsString:String) -> Bool {
   switch digitAsString {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
        return true
    default:
        return false
    }
}

func checkForOperatorInSubStr(subString:String) -> Int {
    var tempStr:String = subString

    var opCount:Int = 0
    var minusinfrontNum:Int = 0
    var bracketCount:Int = 0 // goes to 1
    var i:Int = 0

    var index = tempStr.index(tempStr.startIndex, offsetBy: 0)
    var symbol = String(tempStr[index])

    loop: while symbol != ")" {

        if symbol == ")" {
            bracketCount -= 1
        } else if symbol == "(" {
            bracketCount += 1            
        }
        
        if bracketCount == 0 {
            break loop
        }

        if isAnOperator(symbol:symbol) {
            opCount += 1
        }
        if opCount >= 2 {
            return 2
        }

        if isMinusOperator(minusOperator:symbol) && i == 1 { //goes to 0
            minusinfrontNum += 1
        }

        tempStr.remove(at: tempStr.startIndex)
        i += 1

        index = tempStr.index(tempStr.startIndex, offsetBy: 0)
        symbol = String(tempStr[index])
    }

    if opCount == 1 && minusinfrontNum == 1 {
        return 1
    }
    return 2
}

func evaluateSubExpression(evaluateSUBexpression:(Double, String, Double)) -> Double {
    if evaluateSUBexpression.1 == "*" {
        return evaluateSUBexpression.0 * evaluateSUBexpression.2
    } else if evaluateSUBexpression.1 == "/" {
        return evaluateSUBexpression.0 / evaluateSUBexpression.2
    } else if evaluateSUBexpression.1 == "-" {
        return evaluateSUBexpression.0 - evaluateSUBexpression.2
    } else if evaluateSUBexpression.1 == "^" {
        return pow(evaluateSUBexpression.0, evaluateSUBexpression.2)
    }
    return evaluateSUBexpression.0 + evaluateSUBexpression.2
}

func isAnOperator(symbol:String) -> Bool {
    switch symbol {
    case "+", "-", "*", "/", "^":
        return true
    default:
        return false
    }
}

func convertStringToNumber(stringToNumber:inout String) -> Double {
    if let convertedNumber = Double(getNumberAsString(expressionToStrNumber:&stringToNumber)) {
        return convertedNumber
    }
    return 0.0
}

func getNumberAsString(expressionToStrNumber:inout String) -> String {
    var numberAsString:String = ""

    numberAsStringLoop: while true {
        let index = expressionToStrNumber.index(expressionToStrNumber.startIndex, offsetBy: 0) 
        let digitOrOperator = String(expressionToStrNumber[index])

        if !(numberAsString.isEmpty) && isMinusOperator(minusOperator:digitOrOperator) {
            break numberAsStringLoop
        } else if isMinusOperator(minusOperator:digitOrOperator) || isDotSeparator(dotSeparator:digitOrOperator) || isDigit(digitAsString:digitOrOperator) {
            numberAsString += digitOrOperator
        } else {
            break numberAsStringLoop
        }
        expressionToStrNumber.remove(at: expressionToStrNumber.startIndex)
    }
    
    return numberAsString
}

func isMinusOperator(minusOperator:String) -> Bool {
    return (minusOperator == "-")
}

func isDotSeparator(dotSeparator:String) -> Bool {
    return (dotSeparator == ".")
}