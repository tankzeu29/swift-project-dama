
class GameMover : GamePhase
{

 var winner = PieceColour.EMPTY

  init( gameBoard : Board , player1 : Player , player2 : Player)
{
   
    super.init(board : gameBoard, player1 : player1 , player2 : player2)

}


func start()
{

  print("GAME_MOVER_STARTED")

  let board = getBoard()
  var currentPlayer = getFirstPlayer()
  var oponent = getSecondPlayer()

   board.printBoard()
       print("Current player  \(currentPlayer.info())") 
     print("Oponent  \(oponent.info())") 
  while(true)
  {

        let currentState = shouldGameEnd(firstPlayer:currentPlayer, secondPlayer : oponent, board : board)
        if( currentState != EndGameState.IN_PROGRESS)
        { 
            printWinner(winner : currentState)
            break;
        }


    print("Enter move \(currentPlayer.getColour())")
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
             print("Very bad lol")
           }
       board.printBoard()
    }
    else
    {
      print("Enter legal move")
    }
    

  }


}





 func movePiece(position : String , currentPlayer : Player , oponent : Player , board : Board) throws
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
         try ParametersValidator.validateMovement(position : position , board : board , currentPlayer : currentPlayer , oponent : oponent , canFly : canCurrentPlayerFily)


        let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:2) , board : board)

       try board.setSinglePosition(positionCordinates : position.substring(from:2) , currentPlayer :currentPlayer , oponent : oponent , isMovement : false )
       board.removeAtPosition(point : startPosition)
       currentPlayer.removePiece(position : startPosition)

   

}

func canPlayerFly(player : Player) -> Bool
{
  return player.getTotalPieces() == 3
}


 func shouldGameEnd(firstPlayer : Player , secondPlayer : Player , board : Board) -> EndGameState
{
  let firstEnd = canMovePieces(currentPlayer : firstPlayer , board : board) 
  let secondEnd = canMovePieces(currentPlayer : secondPlayer , board : board)

  print("First move \(firstEnd) , second : \(secondEnd) ")
  if(!firstEnd && !secondEnd)
  {
    return EndGameState.DRAW
  }

  if(!firstEnd)
  {
    return EndGameState.PLAYER1_WINNER
  }
  else if(!secondEnd)
  {
    return EndGameState.PLAYER2_WINNER
  }
  else
  {
    return EndGameState.IN_PROGRESS
  }
}

 func canMovePieces(currentPlayer : Player , board : Board) -> Bool
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
    let offset = PositionParser.getOffset(position : piece, board : board)
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
  if(canCurrentPlayerMove == false)
  {
    print("ENDGAME cuz player with colour cant move -  \(currentPlayer.getColour())")
  }
  return canCurrentPlayerMove
}


 func canPieceMove(position : BoardPosition ,xOffset : Int ,yOffset : Int ,board : Board) -> Bool
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
    if(canMove == false)
    {
      print( )
    }
  return canMove
  
}


 func printWinner(winner : EndGameState)
{
  if(winner == EndGameState.DRAW)
  {
    print("no one won")
  }
  else if (winner == EndGameState.PLAYER1_WINNER)
  {
    print("Player 1 won")
  }
  else if (winner == EndGameState.PLAYER2_WINNER)
  {
    print("Player 2 won")
  }
  else
  {
    print("I cant determine who won LMAO")
  }

}




}