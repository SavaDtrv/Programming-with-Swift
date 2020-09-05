struct PointInMatrix {
    var row:Int = -1
    var col:Int = -1
}

//function that find the different paths in a maze
func findPaths(in labyrinth: [[String]]) -> Int {
    var startingPoint:PointInMatrix = entryPoint(labyrinth:labyrinth)    
    if startingPoint.row == -1 && startingPoint.col == -1 {
        return 0
    }
    //fill the arrayForVisitedCells with "n"-s, which represents a not visited cell and visited: "v"
    var arrayForVisitedCells:[[String]] = Array(repeating: Array(repeating: "n", count: labyrinth[0].count), count: labyrinth.count)
    var count:Int = 0

    allPossiblePaths(labyrinth:labyrinth, currentCell:&startingPoint, visitedCells:&arrayForVisitedCells, paths:&count)
    return count
}

func entryPoint(labyrinth:[[String]]) -> PointInMatrix {
    var startPoint:PointInMatrix = PointInMatrix()
    for (i, row) in labyrinth.enumerated() {
        for (j,cell) in row.enumerated(){
            if cell == "^" {
                startPoint.row = i
                startPoint.col = j
                return startPoint
            }
        }
    }
    return startPoint
}

func allPossiblePaths(labyrinth:[[String]], currentCell:inout PointInMatrix, visitedCells:inout [[String]], paths:inout Int) -> () {
    if labyrinth[currentCell.row][currentCell.col] == "*" {
        paths += 1
        return
    }

    visitedCells[currentCell.row][currentCell.col] = "v"

    if cellNotOutOfIndexBounds(currentCell:currentCell, labyrinth:labyrinth) && 
        (labyrinth[currentCell.row][currentCell.col] == "0" || labyrinth[currentCell.row][currentCell.col] == "^") {
        
        if currentCell.row + 1 < labyrinth.count && visitedCells[currentCell.row + 1][currentCell.col] == "n" {
            var nextCell:PointInMatrix = PointInMatrix(row:currentCell.row + 1, col:currentCell.col)
            allPossiblePaths(labyrinth:labyrinth, currentCell:&nextCell, visitedCells:&visitedCells, paths:&paths)
        }
        if currentCell.row - 1 >= 0 && visitedCells[currentCell.row - 1][currentCell.col] == "n" {
            var nextCell:PointInMatrix = PointInMatrix(row:currentCell.row - 1, col:currentCell.col)
            allPossiblePaths(labyrinth:labyrinth, currentCell:&nextCell, visitedCells:&visitedCells, paths:&paths)
        }
        if currentCell.col + 1 < labyrinth[0].count && visitedCells[currentCell.row][currentCell.col + 1] == "n" {
            var nextCell:PointInMatrix = PointInMatrix(row:currentCell.row, col:currentCell.col + 1)
            allPossiblePaths(labyrinth:labyrinth, currentCell:&nextCell, visitedCells:&visitedCells, paths:&paths)
        }
        if currentCell.col - 1 >= 0 && visitedCells[currentCell.row][currentCell.col - 1] == "n" {
            var nextCell:PointInMatrix = PointInMatrix(row:currentCell.row, col:currentCell.col - 1)
            allPossiblePaths(labyrinth:labyrinth, currentCell:&nextCell, visitedCells:&visitedCells, paths:&paths)
        }
    }

    visitedCells[currentCell.row][currentCell.col] = "n"
}

func cellNotOutOfIndexBounds(currentCell:PointInMatrix, labyrinth:[[String]]) -> Bool {
    if (currentCell.row >= 0 && currentCell.row <= (labyrinth.count - 1)) && (currentCell.col >= 0 && currentCell.col <= (labyrinth[0].count - 1)) {
        return true
    }
    return false
}