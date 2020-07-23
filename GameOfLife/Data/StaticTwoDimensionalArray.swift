import Foundation

extension IndexPath {

    /// Initialize for use with `StaticTwoDimensionalArray`
    public init(row: Int, column: Int) {
        self.init(item: row, section: column)
    }

    /// The item of this index path, when used with `StaticTwoDimensionalArray`.
    public var column: Int {
        return self.section
    }
}

struct StaticTwoDimensionalArray<T> {
    let numberOfRows: Int
    let numberOfColumns: Int
    private var container: [T] = []
    
    typealias OnDefaultValue = () -> T
    
    init(numberOfRows: Int, numberOfColumns: Int, defaultValue: @autoclosure OnDefaultValue) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        
        for _ in 0 ..< numberOfRows {
            for _ in 0 ..< numberOfColumns {
                self.container.append(defaultValue())
            }
        }
    }
    
    subscript(indexPath: IndexPath) -> T {
        get {
            assert(indexPath.row < self.numberOfRows)
            assert(indexPath.column < self.numberOfColumns)
        
            return self.container[indexPath.row * self.numberOfColumns + indexPath.column]
        }
        
        set {
            assert(indexPath.row < self.numberOfRows)
            assert(indexPath.column < self.numberOfColumns)
        
            self.container[indexPath.row * self.numberOfColumns + indexPath.column] = newValue
        }
    }
    
    typealias OnEnumerate = (IndexPath, T) -> Void
    
    func enumerate(_ onEnumerate: OnEnumerate) {
        for row in 0 ..< self.numberOfRows {
            for column in 0 ..< self.numberOfColumns {
                let indexPath = IndexPath(row: row, column: column)
                let element = self[indexPath]
                
                onEnumerate(indexPath, element)
            }
        }
    }
}
