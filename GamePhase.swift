

public class  GamePhase
{
    var board : Board 
 
    var startPieceColour : String
    var player1 : Player
    var player2 : Player
  public init(board : Board , player1 : Player , player2 : Player)
  {
    self.board = board

    self.startPieceColour = BoardBoundElements.WHITE_FIGURE
    self.player1 = player1
    self.player2 = player2
    print("In move constructor \(player1.info()) , \(player2.info()) ")
  }

 public  func getFirstPlayer() -> Player
  {
    return player1
  }

public   func getSecondPlayer()  -> Player
  {
    return player2
  }

 public  func setFirstPlayer(firstPlayer : Player)
  {
    player1 = firstPlayer
  }
public   func setSecondPlayer(secondPlayer : Player)
  {
    player2 = secondPlayer
  }

  
  public func getBoard() -> Board
  {
    return board
  }



 public  func setStartPieceColour ( colour : String)
  {
    startPieceColour = colour
  }

 public  func getStartPieceColour() -> String
  {
    return startPieceColour
  }
}