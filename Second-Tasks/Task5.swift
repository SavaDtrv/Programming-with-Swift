protocol Visual {
    var text: String { get }
    func render()
}

protocol VisualComponent {
    //минимално покриващ правоъгълник
    var boundingBox: Rect { get }
    var parent: VisualComponent? { get }
    func draw()
}

protocol VisualGroup: VisualComponent {
    //броят деца
    var numChildren: Int { get }
    //списък от всички деца
    var children: [VisualComponent] { get }
    //добавяне на дете
    func add(child: VisualComponent)
    //премахване на дете
    func remove(child: VisualComponent)
    //премахване на дете от съответния индекс - 0 базиран
    func removeChild(at: Int)
}

struct Point {
    var x: Double
    var y: Double
}

struct Rect {
    //top-left
    var top:Point
    var width: Double
    var height: Double
    
    init(x: Double, y: Double, width: Double, height: Double) {
        top = Point(x: x, y: y)
        self.width = width
        self.height = height
    }
}

//add implementation details below
struct Triangle: VisualComponent, Visual {
    var boundingBox: Rect 
    
    var parent: VisualComponent?
    
    func draw() {
        //TODO:
    }

    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init(a: Point, b: Point, c: Point) {
        var width: Double = b.x - a.x

        var triangleArea: Double = abs((a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y))/2)
        var height: Double = (2 * triangleArea) / width

        boundingBox = Rect(x:a.x, y:c.y, width:width, height:height)
        parent = nil
    }
}

struct Rectangle: VisualComponent, Visual {
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        //TODO:
    }

    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init(x: Int, y: Int, width: Int, height: Int) {
       boundingBox = Rect(x:Double(x), y:Double(y), width:Double(width), height:Double(height))
       parent = nil
    }
}

struct Circle: VisualComponent, Visual {
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        //TODO:
    }

    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init(x: Int, y:Int, r: Double) {
        boundingBox = Rect(x:Double((Double(x) - r)), y:Double((Double(y) + r)), width:Double((2 * r)), height:Double((2 * r)))
        parent = nil
    }
}

struct Path: VisualComponent, Visual {
    var boundingBox: Rect
    
    var parent: VisualComponent?

    func draw() {
        //TODO:
    }
    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init(points: [Point]) {
        boundingBox = Rect(x:0.0,y:0.0,width:0.0,height:0.0) 
        parent = nil
    }
}

struct HGroup: VisualGroup, Visual {
    var numChildren: Int
    
    var children: [VisualComponent]
    
    func add(child: VisualComponent) {
        children.append(child)
        child.parent = self
        numChildren += 1   

        var i:Int = 0
        for child in children {
            
            if i == 0 {
                boundingBox = child.boundingBox
            } else {
                boundingBox = minBoundingBox(fstBoundingBox:boundingBox, sndBoundingBox:child.boundingBox)
            }

            i += 1
        }
    }
    
    func remove(child: VisualComponent) {
        if let index = children.index(of: child) {
            child.parent = nil
            removeChild(at: index)
        }
    }
    
    func removeChild(at: Int) {
        children.remove(at: at)
    }
    
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        //TODO:
    }

    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init() {
        numChildren = 0
        children = [VisualComponent]()
        boundingBox = Rect(0,0,0,0)
        parent = nil
    }
}

struct VGroup: VisualGroup, Visual {
    var numChildren: Int
    
    var children: [VisualComponent]
    
    func add(child: VisualComponent) {
        children.append(child)
        child.parent = self
        numChildren += 1 

        var i:Int = 0
        for child in children {
            
            if i == 0 {
                boundingBox = child.boundingBox
            } else {
                boundingBox = minBoundingBox(fstBoundingBox:boundingBox, sndBoundingBox:child.boundingBox)
            }

            i += 1
        }
    }

    func remove(child: VisualComponent) {
        if let index = children.index(of: child) {
            removeChild(at: index)
        }
    }
    
    func removeChild(at: Int) {
        children.remove(at: at)
    }
    
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        //TODO:
    }
    var text: String = ""
    
    func render() {
        //TODO:
    }
    
    init() {
        numChildren = 0
        children = [VisualComponent]()
        boundingBox = Rect(0,0,0,0)
        parent = nil
    }
}

func minBoundingBox(fstBoundingBox:Rect, sndBoundingBox:Rect) -> Rect {
    
    var fstBoundBoxArea:Double = fstBoundingBox.width * fstBoundingBox.height 
    var sndBoundBoxArea:Double = sndBoundingBox.width * sndBoundingBox.height

    if (fstBoundBoxArea > 0 && sndBoundBoxArea > 0) && fstBoundBoxArea < sndBoundBoxArea {
        return fstBoundingBox
    } else if (fstBoundBoxArea > 0 && sndBoundBoxArea > 0) && fstBoundBoxArea >= sndBoundBoxArea {
        return sndBoundingBox
    }
}

//implement the function
func read(from: String?) -> VisualComponent? {
    var buffer:String = ""

    if let _ = from {
        buffer:String = from
        return convertToHierarchy(from: buffer)
    } else {
        return nil
    }
}

func convertToHierarchy(from: inout String) -> VisualComponent? {
    var i:Int = 0

    if from[i] == "H" {
        var rootH:HGroup = HGroup()
        from.removeFirst(6)
        return convertToHGroup(from: from, root:rootH, position:i)

    } else if from[i] == "V" {
        var rootV:VGroup = VGroup()
        from.removeFirst(6)
        return convertToVGroup(from: from, root:rootV, position:i)
    }
}

func convertToTriangle(from: inout String, position: Int) -> VisualComponent? {
    from.removeFirst(8)
    
    var pointA:Point = makeAPoint(from: from, position: position)
    var pointB:Point = makeAPoint(from: from, position: position)
    var pointC:Point = makeAPoint(from: from, position: position)

    var trngl:Triangle = Triangle(a:pointA, b:pointB, c:pointC)
    return trngl
    
}

func makeAPoint(from: inout String, position: Int) -> Point {
    var tmp:Point
    var breakingBracker: Int = 0

    while from != "" {
        if from[position] == "(" {
            from.removeFirst(1)
            breakingBracker += 1

        } else {
            var numAsStr:String = ""
            while from[position] != "," || from[position] != ")" {
                numAsStr.append(String(from[position]))
                from.removeFirst(1)
            }
            
            if from[position] == "," {
                tmp.x = Double(numAsStr)
            } else {
                tmp.y = Double(numAsStr)
                breakingBracker -= 1
            }
            
            from.removeFirst(1)
        }

        if breakingBracker == 0  {
            break
        }
    }

    return tmp
}

func convertToRectangle(from: inout String, position: Int) -> VisualComponent? {
    from.removeFirst(9)
    
    var tmpX:Int = 0
    var tmpY:Int = 0
    var tmpWidth:Int = 0
    var tmpHeight:Int = 0

    var breakingBracker: Int = 0
    var countCommas:Int = 0

    while from != "" {
        if from[position] == "(" {
            from.removeFirst(1)
            breakingBracker += 1

        } else {
            var numAsStr:String = ""
            while from[position] != "," || from[position] != ")" {
                numAsStr.append(String(from[position]))
                from.removeFirst(1)
            }
            
            if from[position] == "," {
                countCommas += 1

                if countCommas == 1 {
                    tmpX = Int(numAsStr)
                } else if countCommas == 2 {
                    tmpY = Int(numAsStr)
                } else if countCommas == 3 {
                    tmpWidth = Int(numAsStr)
                } else {
                    tmpHeight = Int(numAsStr)
                }
            } else {
                breakingBracker -= 1
            }

            from.removeFirst(1)
        }

        if breakingBracker == 0  {
            break
        }
    }

    var rect:Rectangle = Rectangle(tmpX, tmpY, tmpWidth, tmpHeight)
    return rect
}

func convertToCircle(from: inout String, position: Int) -> VisualComponent? {
    from.removeFirst(6)
    
    var tmpX: Int = 0
    var tmpY: Int = 0
    var tmpR: Double = 0.0

    var breakingBracker: Int = 0
    var countCommas:Int = 0

    while from != "" {
        if from[position] == "(" {
            from.removeFirst(1)
            breakingBracker += 1

        } else {
            var numAsStr:String = ""
            while from[position] != "," || from[position] != ")" {
                numAsStr.append(String(from[position]))
                from.removeFirst(1)
            }
            
            if from[position] == "," {
                countCommas += 1

                if countCommas == 1 {
                    tmpX = Int(numAsStr)
                } else if countCommas == 2 {
                    tmpY = Int(numAsStr)
                } else {
                    tmpR = Double(numAsStr)
                }
            } else {
                breakingBracker -= 1
            }

            from.removeFirst(1)
        }

        if breakingBracker == 0  {
            break
        }
    }

    var crcl:Circle = Circle(tmpX, tmpY, tmpR)
    return crcl
}

func convertToPath(from: inout String, position: Int) -> VisualComponent? {
    //TODO:
}


func convertToHGroup(from: inout String, root: inout VisualComponent?, position: Int) -> VisualComponent? {
    var bracketBreaking: Int = 0

    while from != "" {
         if from[position] == "[" {
            from.remove(at: position)
            bracketBreaking += 1
        }

        if from[position] == "T" {
           root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "R" {
            root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "C" {
            root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "P" {
            root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "H" {
            var rootH:HGroup = HGroup()
            from.removeFirst(6)
            root.add(child: convertToHGroup(from: from, root:rootH, position:i))
        } else if from[position] == "V" {
            var rootV:VGroup = VGroup()
            from.removeFirst(6)
            root.add(child: convertToVGroup(from: from, root:rootV, position:i))
        }

        if from[position] == "]" {
            bracketBreaking -= 1
        }

        if bracketBreaking == 0 {
            break;
        }
    }

    return root
}

func convertToVGroup(from: inout String, root: inout VisualComponent?, position: Int) -> VisualComponent? {
    var bracketBreaking: Int = 0

    while from != "" {
        if from[position] == "[" {
            from.remove(at: position)
            bracketBreaking += 1
        }

        if from[position] == "T" {
           root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "R" {
            root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "C" {
            root.add(child: convertToTriangle(from:from, position: position))

        } else if from[position] == "P" {
            root.add(child: convertToTriangle(from:from, position: position))
        }

        if from[position] == "]" {
            bracketBreaking -= 1
        }

        if bracketBreaking == 0 {
            break;
        }
     }

     return root
}