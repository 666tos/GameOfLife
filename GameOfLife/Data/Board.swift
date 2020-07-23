import Foundation

struct Board {
    private var cells: StaticTwoDimensionalArray<Cell>
    
    init(numberOfRows: Int, numberOfColumns: Int) {
        self.cells = StaticTwoDimensionalArray(numberOfRows: numberOfRows, numberOfColumns: numberOfColumns, defaultValue: Cell(state: .dead))
    }
    
    var numberOfRows: Int {
        return self.cells.numberOfRows
    }

    var numberOfColumns: Int {
        return self.cells.numberOfColumns
    }
    
    subscript(indexPath: IndexPath) -> Cell {
        get {
            return self.cells[indexPath]
        }
        
        set {
            self.cells[indexPath] = newValue
        }
    }
    
    func enumerate(_ onEnumerate: StaticTwoDimensionalArray<Cell>.OnEnumerate) {
        self.cells.enumerate(onEnumerate)
    }
}
