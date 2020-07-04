



public class GameManager{

  var board : Board

 public  init( board : Board)
  {
    self.board = board

  }

  func getBoard() -> Board
  {
    return board 
  }
  func startGame()
  {
    let player1 = Player()
    let player2 = Player()
  
   
  let gameInitializer = GameInitializer(gameBoard : board , player1 : player1 , player2: player2)
  gameInitializer.start()


    print("PHASE 2 to begin")

    let gameMover = GameMover(gameBoard: board , player1 : gameInitializer.getFirstPlayer() , player2: gameInitializer.getSecondPlayer())
    gameMover.setStartPieceColour(colour :  gameInitializer.getFirstPlayer().getColour())
    gameMover.start()
  }



 

}