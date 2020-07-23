import Foundation

struct Cell {
    enum State {
        case dead
        case alive
    }
    
    var state: State
}
