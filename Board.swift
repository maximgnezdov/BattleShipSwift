//
//  Board.swift
//  GraWStatki
//
//  Created by Max on 10/06/2021.
//

import Foundation


class Board {
    private enum CellContentType {
        case Empty, Ship, HitEmpty, HitShip
    }
    private enum Orientation {
        case Horizontal, Vertical
    }
    let mapSize = 10
    private var map: [[CellContentType]]
    
    private let shipSizes = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]//[2,1]//
    
    public init(randomPosition: Bool = false) {
        map = Array(repeating: Array(repeating: .Empty, count: mapSize), count: mapSize)
        var shipSize = 0
        
        while shipSize < shipSizes.count {
            let size = shipSizes[shipSize]
            var row: Int
            var col: Int
            var ori: Orientation
            
            while(true) {
                if randomPosition {
                    row = Int.random(in: 0..<mapSize)
                    col = Int.random(in: 0..<mapSize)
                    if Int.random(in: 0...1)==0 {
                        ori = .Horizontal
                    }
                    else {
                        ori = .Vertical
                    }
                } else {
                    print("Ship \(size)")
                    row = readInt(desc: "Row", from: 0, to: mapSize-1) - 1
                    col = readInt(desc: "Column", from: 0, to: mapSize-1) - 1
                    let orientationInt = readInt(desc: "Orientation (0-Hirizontal, 1-Vertical)", from: 0, to: 1)
                    if orientationInt==0 {
                        ori = .Horizontal
                    }
                    else {
                        ori = .Vertical
                    }
                }
                
                if(self.placeShip(size, row, col, ori)) {
                    shipSize += 1
                    if !randomPosition {
                        printBoard()
                    }
                    break
                }
            }
        }
    }
    private func readInt(desc: String, from: Int, to: Int) -> Int {
        var optional: Int? = nil
        repeat {
            print(desc + ": ")
            optional = Int(readLine()!)
        }while optional == nil || optional! < from || optional! > to;
        
        return optional!
    }
    private func placeShip(_ size: Int, _ row: Int, _ col: Int, _ orientation: Orientation) -> Bool {
        var shipFieldList: [(row:Int, col:Int)] = Array()
        //GENERATE POSITION OF TH SHIP
        if orientation == .Vertical {
            for i in 0..<size {
                shipFieldList.append((row:row+i, col: col))
            }
        }
        else if orientation == .Horizontal {
            for i in 0..<size {
                shipFieldList.append((row:row, col: col+i))
            }
        }
        //CHECKING THE CORRECTNESS OF THE ARRANGEMENT
        for f in shipFieldList {
            //CHECK IF THE SHIP ON THE BOARD AND DOESNT COLLIDE WITH OTHERS
            if f.row>=mapSize || f.col>=mapSize || map[f.row][f.col] != .Empty {
                print("Ship placed out of the map or on the other ship!")
                self.printBoard()
                return false
            }
            //CHECKING IF THE SURROUNDING ARE EMPTY
            else {
                for rr in (f.row-1)...(f.row+1) {
                    for cc in (f.col-1)...(f.col+1) {
                        if rr>=0 && cc>=0 && rr<mapSize && cc<mapSize && map[rr][cc] != .Empty {
                            print("Ship was places too close to another one!")
                            self.printBoard()
                            return false
                        }
                    }
                }
            }
        }
        //PLACING THE SHIP
        for f in shipFieldList {
            map[f.row][f.col] = .Ship
        }
        return true
    }
    
    private func readSoloInt() -> Int {
        var optional: Int? = nil
        repeat {
            print("Enter number: ")
            optional = Int(readLine()!)
        }while optional == nil;
        return optional!
    }
    
    public func printBoard() {
        var boardString = ""
        print("▶️", terminator:"")
        for i in 0..<mapSize {
            switch i {
            case 0: print("1️⃣", terminator:"")
            case 1: print("2️⃣", terminator:"")
            case 2: print("3️⃣", terminator:"")
            case 3: print("4️⃣", terminator:"")
            case 4: print("5️⃣", terminator:"")
            case 5: print("6️⃣", terminator:"")
            case 6: print("7️⃣", terminator:"")
            case 7: print("8️⃣", terminator:"")
            case 8: print("9️⃣", terminator:"")
            case 9: print("🔟", terminator:"")
            default:
                print(i, terminator:"")
            }
            
        }
        
        for row in 0..<mapSize {
            boardString += "\n"
            
            switch row {
            case 0: boardString += "1️⃣"
            case 1: boardString += "2️⃣"
            case 2: boardString += "3️⃣"
            case 3: boardString += "4️⃣"
            case 4: boardString += "5️⃣"
            case 5: boardString += "6️⃣"
            case 6: boardString += "7️⃣"
            case 7: boardString += "8️⃣"
            case 8: boardString += "9️⃣"
            case 9: boardString += "🔟"
            default:
                print("Default")
            }
            for col in 0..<mapSize {
                switch map[row][col] {
                case .Empty:
                    boardString += "🟦"
                case .Ship:
                    boardString += "⬛️"
                case .HitEmpty:
                    boardString += "🔘"
                case .HitShip:
                    boardString += "🔥"
                }
            }
            //boardString += "|\n"
        }
        boardString += "\n"
        print(boardString)
    }
    
    public func printOpBoard() {
        var boardString = ""
        print("▶️", terminator:"")
        for i in 0..<mapSize {
            switch i {
            case 0: print("1️⃣", terminator:"")
            case 1: print("2️⃣", terminator:"")
            case 2: print("3️⃣", terminator:"")
            case 3: print("4️⃣", terminator:"")
            case 4: print("5️⃣", terminator:"")
            case 5: print("6️⃣", terminator:"")
            case 6: print("7️⃣", terminator:"")
            case 7: print("8️⃣", terminator:"")
            case 8: print("9️⃣", terminator:"")
            case 9: print("🔟", terminator:"")
            default:
                print(i, terminator:"")
            }
        }
        
        for row in 0..<mapSize {
            boardString += "\n"
            
            switch row {
            case 0: boardString += "1️⃣"
            case 1: boardString += "2️⃣"
            case 2: boardString += "3️⃣"
            case 3: boardString += "4️⃣"
            case 4: boardString += "5️⃣"
            case 5: boardString += "6️⃣"
            case 6: boardString += "7️⃣"
            case 7: boardString += "8️⃣"
            case 8: boardString += "9️⃣"
            case 9: boardString += "🔟"
            default:
                print("Default")
            }
            for col in 0..<mapSize {
                switch map[row][col] {
                case .Empty:
                    boardString += "🟦"
                case .Ship:
                    boardString += "🟦"
                case .HitEmpty:
                    boardString += "🔘"
                case .HitShip:
                    boardString += "🔥"
                }
            }
            //boardString += "|\n"
        }
        boardString += "\n"
        print(boardString)
    }
    

    //STRZELANIE UZYTKOWNIKA
    func ShootOpBoards(board: Board) {
        print("====== Opponent Board =====")
        board.printOpBoard()
        var r: Int
        var c: Int
        r = readSoloInt() - 1
        c = readSoloInt() - 1
        if board.map[r][c] == .Empty {
            board.map[r][c] = .HitEmpty
            board.printOpBoard()
            print("----💩You Missed💩----")
            print("PRESS ENTER TO CONTINUE: ")
            let Enter = readLine()
            if ((Enter?.isEmpty) != nil) {print("")}
        } else if board.map[r][c] == .Ship {
            board.map[r][c] = .HitShip
            print("---Hit!!!---")
            if(board.isGameOver(board: board) == true ) {
                board.printBoard()
                print("Congratulations You Won!!")
            }
            else {
                ShootOpBoards(board: board)
            }
        }
    }
    
    //DIFFICULTY HARD
    func ShootMeHard(board: Board) {
        var row: Int
        var col: Int
        var i: Int = 0
        var itr: Int = 0
        
        while true {
            row = Int.random(in: 0..<mapSize)
            col = Int.random(in: 0..<mapSize)
            if ( board.map[row][col] == .Empty && itr == 3){
                print("", terminator: Array(repeating: "\n", count: 100).joined())
                print("====== Player Board ======")
                board.map[row][col] = .HitEmpty
                board.printBoard()
                print("---Opponent Mised!!!---")
                print("PRESS ENTER TO CONTINUE: ")
                let Enter = readLine()
                if ((Enter?.isEmpty) != nil) {print("")}
                break
            } else if board.map[row][col] == .Ship {
                while true {
                    if board.map[row][col] == .Ship {
                        print("---Ship is on Fire!!!---")
                        board.map[row][col] = .HitShip
                        board.printBoard()
                        print("PRESS ENTER TO CONTINUE: ")
                        let Enter = readLine()
                        if ((Enter?.isEmpty) != nil) {print("")}
                    }
                    if(board.isGameOver(board: board) == true ) {
                        board.printBoard()
                        print("-----☠️YOU LOST☠️-----")
                        break
                    }
                    row = Int.random(in: 0..<mapSize)
                    col = Int.random(in: 0..<mapSize)
                    if (board.map[row][col] == .Empty && i == 3){
                        print("", terminator: Array(repeating: "\n", count: 100).joined())
                        print("====== Player Board ======")
                        board.map[row][col] = .HitEmpty
                        board.printBoard()
                        print("---Opponent Mised!!!---")
                        print("PRESS ENTER TO CONTINUE: ")
                        let Enter = readLine()
                        if ((Enter?.isEmpty) != nil) {print("")}
                        break
                    }
                    i += 1
                }
                break
            }
            itr += 1
        }
        
    }
    
    //DIFFICULTY EASY
    func ShootMeEasy(board: Board) {
        var row: Int
        var col: Int
        row = Int.random(in: 0..<mapSize)
        col = Int.random(in: 0..<mapSize)
        if board.map[row][col] == .Empty {
            print("", terminator: Array(repeating: "\n", count: 100).joined())
            print("====== Player Board ======")
            board.map[row][col] = .HitEmpty
            board.printBoard()
            print("---Opponent Mised!!!---")
            print("PRESS ENTER TO CONTINUE: ")
            let Enter = readLine()
            if ((Enter?.isEmpty) != nil) {print("")}
        } else if board.map[row][col] == .Ship {
            while true {
                print("---Ship is on Fire!!!---")
                board.map[row][col] = .HitShip
                board.printBoard()
                print("PRESS ENTER TO CONTINUE: ")
                let Enter = readLine()
                if ((Enter?.isEmpty) != nil) {print("")}
                if(board.isGameOver(board: board) == true ) {
                    board.printBoard()
                    print("-----☠️YOU LOST☠️-----")
                    break
                }
                row = Int.random(in: 0..<mapSize)
                col = Int.random(in: 0..<mapSize)
                if board.map[row][col] == .Empty {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.map[row][col] = .HitEmpty
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
                else if board.map[row][col] == .HitEmpty {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
                else if board.map[row][col] == .HitShip {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
            }
        }
    }
    
    
    //DIFFICULTY MEDIUM
    func ShootMe(board: Board) {
        //board.printBoard()
        var row: Int
        var col: Int
        row = Int.random(in: 0..<mapSize)
        col = Int.random(in: 0..<mapSize)
        if board.map[row][col] == .Empty {
            print("", terminator: Array(repeating: "\n", count: 100).joined())
            print("====== Player Board ======")
            board.map[row][col] = .HitEmpty
            board.printBoard()
            print("---Opponent Mised!!!---")
            print("PRESS ENTER TO CONTINUE: ")
            let Enter = readLine()
            if ((Enter?.isEmpty) != nil) {print("")}
        } else if board.map[row][col] == .Ship {
            while true {
                print("---Ship is on Fire!!!---")
                board.map[row][col] = .HitShip
                board.printBoard()
                print("PRESS ENTER TO CONTINUE: ")
                let Enter = readLine()
                if ((Enter?.isEmpty) != nil) {print("")}
                if(board.isGameOver(board: board) == true ) {
                    board.printBoard()
                    print("-----☠️YOU LOST☠️-----")
                    break
                }
                if (row == 0) {row = Int.random(in: row..<row+1)}
                else if (row == 9) {row = Int.random(in: row-1..<row)}
                else {row = Int.random(in: row-1..<row+1)}
                if (col == 0) {col = Int.random(in: col..<col+1)}
                else if (col == 9) {col = Int.random(in: col-1..<col)}
                else {col = Int.random(in: col-1..<col+1)}
                if board.map[row][col] == .Empty {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.map[row][col] = .HitEmpty
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
                else if board.map[row][col] == .HitEmpty {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
                else if board.map[row][col] == .HitShip {
                    print("", terminator: Array(repeating: "\n", count: 100).joined())
                    print("====== Player Board ======")
                    board.printBoard()
                    print("---Opponent Mised!!!---")
                    print("PRESS ENTER TO CONTINUE: ")
                    let Enter = readLine()
                    if ((Enter?.isEmpty) != nil) {print("")}
                    break
                }
            }
        }
    }
    

    func isGameOver(board: Board) -> Bool {
        for row in 0..<board.mapSize {
            for col in 0..<board.mapSize {
                if board.map[row][col] == .Ship {
                    return false
                }
            }
        }
        return true
    }

    /*
    public func prepareBoard(board: Board) {
        for row in 0..<board.mapSize {
            for col in 0..<board.mapSize {
                if board.map[row][col] == .Ship {
                    map[row][col] = .Empty
                }
            }
        }
    }
    */
    
}
