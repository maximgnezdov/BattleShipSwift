//
//  Game.swift
//  GraWStatki
//
//  Created by Max on 10/06/2021.
//

import Foundation


class initGame {
    
    private var playerBoard = Board(randomPosition: true)
    private var opponentBoard = Board(randomPosition: true)
    //private var opponentBoardForPlayer = Board(randomize: true)
    
    private func readSoloInt() -> Int {
        var optional: Int? = nil
        repeat {
            print("Enter number: ")
            optional = Int(readLine()!)
        }while optional == nil;
        return optional!
    }
    
    public func printGame() {
        print("", terminator: Array(repeating: "\n", count: 100).joined())
        //SHOOTING AND DIFFICULTY
        
        var level: String
        print("1 - EASY\n")
        print("2 - MEDIUM\n")
        print("3 - HARD\n")
        print("SET DIFFICULTY: ")
        level = readLine()!
        
        switch level {
        case "1":
            while(true) {
                
                opponentBoard.ShootOpBoards(board: opponentBoard)
                if(opponentBoard.isGameOver(board: opponentBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
                
                playerBoard.ShootMeEasy(board: playerBoard)
                if(playerBoard.isGameOver(board: playerBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
            }
        case "2":
            while(true) {
                
                opponentBoard.ShootOpBoards(board: opponentBoard)
                if(opponentBoard.isGameOver(board: opponentBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
                
                playerBoard.ShootMe(board: playerBoard)
                if(playerBoard.isGameOver(board: playerBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
            }
        case "3":
            while(true) {
                
                opponentBoard.ShootOpBoards(board: opponentBoard)
                if(opponentBoard.isGameOver(board: opponentBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
                
                playerBoard.ShootMeHard(board: playerBoard)
                if(playerBoard.isGameOver(board: playerBoard) == true ) {break}
                print("", terminator: Array(repeating: "\n", count: 100).joined())
            }
        default:
            print{"Wrong Input"}
        }
    }
}
