
public class GameMover : GamePhase
{

private let NEEDED_PIECES_TO_FLY = 3

 public  init( gameBoard : Board , player1 : Player , player2 : Player)
{
   
    super.init(board : gameBoard, player1 : player1 , player2 : player2)

}


public func start()
{

     print("Moving phase started!")

  let board = getBoard()
  var currentPlayer = getFirstPlayer()
  var oponent = getSecondPlayer()

   board.printBoard()
       print("Current player  \(currentPlayer.info())") 
     print("Oponent  \(oponent.info())") 
     
  while(true)
  {
     print("Current player  \(currentPlayer.info())") 
     print("Oponent  \(oponent.info())") 
        let currentState = shouldGameEnd(firstPlayer:currentPlayer, secondPlayer : oponent, board : board)
        if( currentState != EndGameState.IN_PROGRESS)
        { 
            printWinner(winner : currentState)
            break;
        }


    print(IngameMessages.ENTER_INPUT_MOVE)
    print("\(currentPlayer.getColour()) turn")
    if let position = readLine() {

      do {
        
        try movePiece(position : position , currentPlayer : currentPlayer ,oponent : oponent , board : board)
          let tempPlayer = currentPlayer
       currentPlayer = oponent
      oponent = tempPlayer
       




      }
       catch NineMortisError.runtimeError(let errorMessage) {
                  print(errorMessage)
           }
           catch
           {
             print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
           }
       board.printBoard()
    }
    else
    {
      print(IngameMessages.ENTER_INPUT_AGAIN)
    }
    

  }


}





 public func movePiece(position : String , currentPlayer : Player , oponent : Player , board : Board) throws
{
        let canCurrentPlayerFily = canPlayerFly(player : currentPlayer)
        if(canCurrentPlayerFily)
        {
          print("Player with colour \(currentPlayer.getColour()) CAN FLY")
        }
        else
        {
           print("Player with colour \(currentPlayer.getColour()) CAN NOT FLY")
        }


         try MovementValidator.validateMovement(position : position , board : board , currentPlayer : currentPlayer , oponent : oponent , canFly : canCurrentPlayerFily)


        let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:2) , board : board)
       board.removeAtPosition(point : startPosition)
       try board.setSinglePosition(positionCordinates : position.substring(from:2) , currentPlayer :currentPlayer , oponent : oponent , isMovement : false )
      
       currentPlayer.removePiece(position : startPosition)

   

}

private func canPlayerFly(player : Player) -> Bool
{
  return player.getTotalPieces() == NEEDED_PIECES_TO_FLY
}


 private func shouldGameEnd(firstPlayer : Player , secondPlayer : Player , board : Board) -> EndGameState
{
  let firstEnd = canMovePieces(currentPlayer : firstPlayer , board : board) 
  let secondEnd = canMovePieces(currentPlayer : secondPlayer , board : board)

  print("First move \(firstEnd) , second : \(secondEnd) ")
  print("Player1 col \(firstPlayer.getColour()) , Player2 : \(secondPlayer.getColour()) ")


  if(!firstEnd)
  {
    return EndGameState.PLAYER2_WINNER
  }
  else if(!secondEnd)
  {
    return EndGameState.PLAYER1_WINNER
  }
  else
  {
    return EndGameState.IN_PROGRESS
  }
}

 private func canMovePieces(currentPlayer : Player , board : Board) -> Bool
{

  if(currentPlayer.getTotalPieces() <= 2)
  {
        print("Only 2 pieces for \(currentPlayer.getColour())")
        return false
  }


  var canCurrentPlayerMove = false



  let currentPlayerPieces = currentPlayer.getPieces()

  for piece in currentPlayerPieces
  {
    let offset = BoardOffsetFinder.getOffset(position : piece, board : board)
    let xOffset = offset.first
    let yOffset = offset.second
    print("xOffset : \(xOffset) yOffset : \(yOffset)")
    let isMovable = canPieceMove( position : piece , xOffset : xOffset , yOffset : yOffset , board : board)
    

    if(isMovable)
    {
        canCurrentPlayerMove = true
        break;
    }
  }

  return canCurrentPlayerMove
}


 private func canPieceMove(position : BoardPosition ,xOffset : Int ,yOffset : Int ,board : Board) -> Bool
{
  let startX = position.getX()
  let startY = position.getY()
 
  
  
  let topPosition  = BoardPosition(xCordinate : startX + xOffset ,yCordinate : startY)

  let bottomPosition  = BoardPosition(xCordinate : startX + xOffset ,yCordinate : startY)
   let leftPosition  = BoardPosition(xCordinate : startX  ,yCordinate : startY - yOffset)
 let rightPosition  = BoardPosition(xCordinate : startX  ,yCordinate : startY + yOffset)


 let canMove = board.isPositionEmpty(position : topPosition) || 
  board.isPositionEmpty(position : bottomPosition) || 
   board.isPositionEmpty(position : leftPosition) || 
    board.isPositionEmpty(position : rightPosition)

  return canMove
  
}


 public func printWinner(winner : EndGameState)
{
 if (winner == EndGameState.PLAYER1_WINNER)
  {
    print(IngameMessages.PLAYER1_WON)
  }
  else if (winner == EndGameState.PLAYER2_WINNER)
  {
    print(IngameMessages.PLAYER2_WON)
  }
  else
  {
    print(IngameMessages.UNDETERMINED_WINNER)
  }

}




}