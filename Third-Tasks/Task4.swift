 class Node<T> {
	var value: T
	var next: Node<T>?

	init(value: Any) {
		self.value = value as! T
	}
}

 class List<T> {
	
	var head: Node<T>?
	var tail: Node<T>? {
		guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
	}

	var _length: Int

  	init(_ items: Any...) {
		_length = Int(items.count)
		
		for item in items {
			let newNode = Node<T>(value: item)

			if let tailNode = tail {
				tailNode.next = newNode
			} else {
				head = newNode
			}
		}
    }
    
    public func append(value: T) {
        let newNode = Node<T>(value: value)

        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
    }
 }

 extension List {
 	subscript(index: Int) -> T? {
		assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater than 0")
		
		if index == 0 {
            return head!.value
        } else {
            var node = head!.next
			var iterator: Int = index - 1

			while iterator != 0 {
                node = node?.next
				iterator -= 1
			}
            
            assert(node != nil, "index is out of bounds.")
            return node!.value
        }
 	}
 }
 
 extension List {
 	var length: Int {
        get {
	    	return self._length
	    }
	    set (newLength) {
	    	self._length = newLength
	    }
 	}
 }
 
 extension List {
 	func reverse() {
		var newList: List<T> = List<T>()
		var iterator = self._length - 1

		while iterator >= 0 {
			newList.append(value: self[iterator]!)
			iterator -= 1
		}
		
		self.head = newList.head
 	} 
}

//от символен низ инициализира списък с цели чила.
extension List {
    
    enum StringError:Error {
        case wrongValueType(str: String)
    }

    
    func isASeparator(str: String) -> Bool {
        return str == " " || str == ","
    }
    
    
    func isSymbolDigit(str:String) -> Bool {
        switch str {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                return true
            default:
                return false
            }
    }
    
    func getNumberFromString(str: inout String) throws -> Int {
        var numberAsString: String = ""

        var index = str.index(str.startIndex, offsetBy: 0)
        var symbol = String(str[index])

        while isASeparator(str: symbol) {
            str.remove(at: str.startIndex)
            index = str.index(str.startIndex, offsetBy: 0)
            symbol = String(str[index])
        }

        while symbol != "," && symbol != " " {

            if isSymbolDigit(str:symbol) {
                numberAsString = numberAsString + symbol
            } else if isASeparator(str: symbol) {
                break
            } else {
                throw StringError.wrongValueType(str:"The type of the values is wrong")
            }

            str.remove(at: str.startIndex)
            index = str.index(str.startIndex, offsetBy: 0)
            symbol = String(str[index])
        }

        let constructedNumber: Int = Int(numberAsString)!
        return constructedNumber
    }
    

 	func parse(_ x:String) throws -> List<Int> {

        var list: List<Int> = List<Int>()

        var tmpStr: String = x + " "
        var numberFromString: Int = 0

        var index = tmpStr.index(tmpStr.startIndex, offsetBy: 0)
        var symbol: String // = String(tmpStr[index])

        while tmpStr != "" {
            
            symbol = String(tmpStr[index])
            
            if isASeparator(str: symbol) || isSymbolDigit(str: symbol) {    
                numberFromString = try! getNumberFromString(str: &tmpStr)
                list.append(value:numberFromString)
            } else {
                throw StringError.wrongValueType(str:"The type of the values is wrong")
            }

            if tmpStr == " " {
                tmpStr.remove(at: tmpStr.startIndex)
            }

            index = tmpStr.index(tmpStr.startIndex, offsetBy: 0)
        }

        return list
 	}
}