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
func cover(root: VisualComponent?) -> Rect {
    
    var minBoundBox:Rect
    var i:Int = 0
    minBoundBox = minCover(root:root, minBoundBox:&minBoundBox, itrtor:&i)
    return minBoundBox
}


func minCover(root: VisualComponent?, minBoundBox:inout Rect, itrtor:inout Int) -> Rect {
    if !isNode(root:root) {
        return 0
    }

    if itrtor == 0 && (String(describing:type(of: root)) == "HGroup" || String(describing:type(of: root)) == "VGroup") {
        return minCover(root:root, minBoundBox:root.boundingBox, itrtor:itrtor += 1)
    }
    
    if itrtor == 0 && (String(describing:type(of: root)) != "HGroup" || String(describing:type(of: root)) != "VGroup") {
        return root.boundingBox
    }

    for child in root.children {
        
        if itrtor != 0 && (String(describing:type(of: child)) == "HGroup" || String(describing:type(of: child)) == "VGroup") {
            var tmpBoundBox:Rect = minBoundingBox(minBoundBox, child.boundingBox)
            return minCover(root: child, minBoundBox:tmpBoundBox, itrtor:itrtor += 1)
        } else {
            return minCover(root: child, minBoundBox:minBoundBox, itrtor:itrtor)
        }
    }

    return minBoundBox
}


func isNode(root:VisualComponent?) -> Bool {
    if let _:VisualComponent = root {
        return true
    }

    return false
}