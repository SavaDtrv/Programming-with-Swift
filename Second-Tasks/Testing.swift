struct TestAny {
    var a:Int
    var b:Int
}

struct Cat {
    var numOfLegs:Int
    var hasTail:Bool
}

var test:TestAny = TestAny(a:1, b:2)
var test1:Cat = Cat(numOfLegs:4, hasTail:true)
var test_1:Cat = Cat(numOfLegs:4, hasTail:false)

print(String(describing:type(of: test)))
print(String(describing:type(of: test1)) == String(describing:type(of: test_1)))