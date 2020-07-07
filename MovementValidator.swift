

public class MovementValidator
{

private static let allowedLetters: [Character] = ("A"..."G").characters
 private static let allowedNumbers  : [Character] = ("1"..."7").characters
   private static let MOVEMENT_ARGUMENTS = 4 
     private static let MOVEMENT_MIDDLE_POSITION = 2




   public static func validateMovement(position : String , board : Board , currentPlayer : Player, oponent : Player , canFly : Bool ) throws
  {



    
    guard position.count == MOVEMENT_ARGUMENTS else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be \(MOVEMENT_ARGUMENTS)")
        }

  
  try board.validateSinglePosition(position : position.substring(to:2) )
    try board.validateSinglePosition(position : position.substring(from:2) )

    let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:MOVEMENT_MIDDLE_POSITION) , board : board)
    let endPosition =  try PositionParser.getPositionFromString(position : position.substring(from:MOVEMENT_MIDDLE_POSITION) , board : board)

            let arePositionsAdj = arePositionsAdjacent(startPosition : startPosition , endPosition :endPosition , board : board)
        print("Can fly \(canFly)")
        print("Are adj \(arePositionsAdj)")


        let isNormalMoveFlyingMove = !canFly && !arePositionsAdj

       if ( isNormalMoveFlyingMove )
        {
             throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) Must  be adjacent  because you CANNOT fly ")
        }
        
       guard startPosition.getColour() == currentPlayer.getColour() else {
          throw NineMortisError.runtimeError("Piece to move \(startPosition.toString()) is not your colour")
        }
          if ( endPosition.getColour() != BoardBoundElements.EMPTY_POSITION ) {
          throw NineMortisError.runtimeError("The position \(endPosition.toString()) is not empty position")
        }



 

  }

  




  


  public static func arePositionsAdjacent(startPosition : BoardPosition ,endPosition: BoardPosition, board : Board) -> Bool 
  {


      let offset = BoardOffsetFinder.getOffset(position : startPosition , board : board)
      let startX = startPosition.getX()
      let startY = startPosition.getY()
      let xOffset = offset.first
      let yOffset = offset.second

   
      let isAdjacent = vlaidateAdjHelper(endPosition : endPosition ,startX :startX + xOffset , startY: startY ,board : board ) ||
     vlaidateAdjHelper(endPosition : endPosition , startX :startX - xOffset ,startY: startY , board : board ) ||
    vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY + yOffset ,board : board) ||
     vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY - yOffset, board : board) 

      return isAdjacent


  }

  public static func vlaidateAdjHelper(endPosition : BoardPosition , startX :Int , startY : Int , board : Board) -> Bool
  {
      let positionExist = board.isPointExisting(xCordinate :startX ,yCordinate: startY )
      if(positionExist)
      {
         return endPosition.getX() == startX && endPosition.getY() == startY
      }
      return false

  }






  








}
