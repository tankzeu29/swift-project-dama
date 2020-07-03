

class  GamePhase
{
    var board : Board 
 
    var startPieceColour : PieceColour
    var player1 : Player
    var player2 : Player
  init(board : Board , player1 : Player , player2 : Player)
  {
    self.board = board

    self.startPieceColour = PieceColour.WHITE
    self.player1 = player1
    self.player2 = player2
    print("In move constructor \(player1.info()) , \(player2.info()) ")
  }

  func getFirstPlayer() -> Player
  {
    return player1
  }

  func getSecondPlayer()  -> Player
  {
    return player2
  }

  func setFirstPlayer(firstPlayer : Player)
  {
    player1 = firstPlayer
  }
  func setSecondPlayer(secondPlayer : Player)
  {
    player2 = secondPlayer
  }

  
  func getBoard() -> Board
  {
    return board
  }



  func setStartPieceColour ( colour : PieceColour)
  {
    startPieceColour = colour
  }

  func getStartPieceColour() -> PieceColour
  {
    return startPieceColour
  }
}