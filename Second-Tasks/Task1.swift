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
    mutating func add(child: VisualComponent)
    //премахване на дете
    mutating func remove(child: VisualComponent)
    //премахване на дете от съответния индекс - 0 базиран
    mutating func removeChild(at: Int)
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
        boundingBox = Rect(x:Double((Double(x) - r)), y:Double((Double(y) + r)), width:(2 * r), height:(2 * r))
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
    }
}

struct HGroup: VisualGroup, Visual {
    var numChildren: Int
    
    var children: [VisualComponent]
    
    mutating func add(child: VisualComponent) {
        self.children.append(child)
        self.numChildren += 1   

        var i:Int = 0
        for child in self.children {
            
            if i == 0 {
                self.boundingBox = child.boundingBox
            } else {
                self.boundingBox = minBoundingBox(fstBoundingBox:boundingBox, sndBoundingBox:child.boundingBox)
            }

            i += 1
        }
    }
    
    mutating func remove(child: VisualComponent) {
        if let index = self.children.index(of: child) {
            removeChild(at: index)
        }
    }
    
    mutating func removeChild(at: Int) {
        self.children.remove(at: at)
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
        self.numChildren = 0
        self.children = [VisualComponent]()
        self.boundingBox = Rect(x:0.0,y:0.0,width:0.0,height:0.0)
    }
}

struct VGroup: VisualGroup, Visual {
    var numChildren: Int
    
    var children: [VisualComponent]
    
    mutating func add(child: VisualComponent) {
        self.children.append(child)
        self.numChildren += 1 

        var i:Int = 0
        for child in self.children {
            
            if i == 0 {
                self.boundingBox = child.boundingBox
            } else {
                self.boundingBox = minBoundingBox(fstBoundingBox:boundingBox, sndBoundingBox:child.boundingBox)
            }

            i += 1
        }
    }

    mutating func remove(child: VisualComponent) {
        if let index = self.children.index(of: child) {
            removeChild(at: index)
        }
    }
    
    mutating func removeChild(at: Int) {
        self.children.remove(at: at)
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
        self.numChildren = 0
        self.children = [VisualComponent]()
        self.boundingBox = Rect(x:0.0,y:0.0,width:0.0,height:0.0)
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