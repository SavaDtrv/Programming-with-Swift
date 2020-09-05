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
    
    func append(value: T) {
        let newNode = Node<T>(value: value)

        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }

		self._length += 1
    }

	func getNodeByIndex(index: Int) -> Node<T>? {
		assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater than 0")
		
		if index == 0 {
            return head
        } else {
            var node = head!.next
			var iterator: Int = index - 1

			while iterator != 0 {
                node = node?.next
				iterator -= 1
			}
            
            assert(node != nil, "index is out of bounds.")
            return node
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
		self._length = newList.length
 	} 
}

extension List where T: Comparable {
    func toSet() {
		var newLength: Int = self.length

		var currentNode = head
		var previousNode:Node<T>? = nil

		var s = Array<T>()

		while currentNode != nil {

			let nodeData: T = currentNode!.value

			if s.contains(nodeData) {
				if currentNode?.next != nil {
					previousNode?.next = currentNode?.next!
				}else{
					previousNode?.next = nil
				}

				newLength -= 1
			}else{
				s.append(nodeData)
				previousNode = currentNode
			}

			currentNode = currentNode?.next
		}
		self._length = newLength
    }
}