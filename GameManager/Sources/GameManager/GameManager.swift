

/*
 Initializes all game modules and
 starts the game
 */

import CoreGame

public class GameManager{
    
    var board : Board
    
    public  init()
    {
        
        self.board = Board()
        
    }
    
    
    //starts the whole game
    public func startGame()
    {
        let player1 = Player()
        let player2 = Player()
        
        
        
        let gameInitializer = GameInitializer(gameBoard : board  , player1 : player1 , player2: player2)
        gameInitializer.start()
        
        
        let gameMover = GameMover(gameBoard: board , player1 : gameInitializer.getFirstPlayer() , player2: gameInitializer.getSecondPlayer())
        gameMover.setStartPieceColour(colour :  gameInitializer.getFirstPlayer().getColour())
        gameMover.start()
    }
    
    
    
    
    
}
