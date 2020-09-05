
//Task 1
var list: List<Int> = List<Int>(1,2,3)
//print(list.head!.value)

print(list.length)
print("\n")
print(list[2]!)

list.reverse()

print(list.length)
print("\n")
print(list[2]!)

//Task 2

//old version of the new function
  
		/* var newLength: Int = self.length
	   
		var node: Node<T>? = head

		var firstLoopIterator: Int = 0
		var secondLoopIterator: Int = 1


		while let next_1 = node!.next {
			var node_2: Node<T>? = next_1

			while let next_2 = node_2!.next {
				
				if node!.value == node_2!.value {
					let nodeToReconnect: Node<T>? = getNodeByIndex(index: secondLoopIterator - 1)
					nodeToReconnect!.next = node_2!.next
					
					let tmpNode: Node<T>? = node_2
					tmpNode!.next = nil
					
					node_2 = nodeToReconnect!.next
					newLength -= 1
				} else {
					node_2 = next_2
					secondLoopIterator += 1
				}
			}

			node = next_1
			firstLoopIterator = firstLoopIterator + 1
			secondLoopIterator = firstLoopIterator + 1
		} */

var list: List<Int> = List<Int>(1,1,2,2,1,2,3,3,1)
print(list.length)
print("\n")

for index in 0...(list.length - 1) {
	print(list[index]!)
}

print("\n")

list.toSet()
print("\n")
print(list.length)
print("\n")

for index in 0...(list.length - 1) {
	print(list[index]!)
}

//Task 3
var tmpList: List<Int> = List<Int>(2, 2)
var list: List<List<Int>> = List<List<Int>>(tmpList) //, 21, List<Any>(3, List<Int>(5, 8))
//list = list.flatten()

for index in 0...(list.head!.value.length - 1) {
	print(list.head!.value[index]!)
}

//Task 4
//коректен пример
var l = List<Int>()
var l2 = try? l.parse("1, 2, 3")

print(l2!.head!.value)
print("\n")


/* for index in 0...(l2!.length - 1) {
    print(l2![index]!)
} */
//коректен пример
var l3 = List<Int>()
var l4 = try? l3.parse("1, 2, a")



/* var str: String = "123"
var number: Int = getNumberFromString(str: &str)
print(number) */
