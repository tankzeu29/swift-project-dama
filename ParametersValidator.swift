

public class ParametersValidator
{

private static let allowedLetters: [Character] = ("A"..."G").characters
 private static let allowedNumbers  : [Character] = ("1"..."7").characters
   private static let MOVEMENT_ARGUMENTS = 4 
     private static let MOVEMENT_MIDDLE = 2




   public static func validateMovement(position : String , board : Board , currentPlayer : Player, oponent : Player , canFly : Bool ) throws
  {



    
    guard position.count == MOVEMENT_ARGUMENTS else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be \(MOVEMENT_ARGUMENTS)")
        }

  
  try validateSinglePosition(position : position.substring(to:2) , board : board)
    try validateSinglePosition(position : position.substring(from:2) , board : board)

    let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:MOVEMENT_MIDDLE) , board : board)
    let endPosition =  try PositionParser.getPositionFromString(position : position.substring(from:MOVEMENT_MIDDLE) , board : board)


       guard startPosition.getColour() == currentPlayer.getColour() else {
          throw NineMortisError.runtimeError("Piece to move \(startPosition.toString()) is not your colour")
        }
          guard endPosition.getColour() == PieceColour.EMPTY else {
          throw NineMortisError.runtimeError("The position \(endPosition.toString()) is not empty")
        }

        let arePositionsAdj = arePositionsAdjacent(startPosition : startPosition , endPosition :endPosition , board : board)
        print("Can fly \(canFly)")
        print("Are adj \(arePositionsAdj)")

        let isFlyingMoveAdj = canFly && arePositionsAdj
        let isNormalMoveFlyingMove = !canFly && !arePositionsAdj

        if ( isFlyingMoveAdj )
        {
            throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) Must not must be adjacent because you must fly ")
        }
       if ( isNormalMoveFlyingMove )
        {
             throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) Must  be adjacent  because you CANNOT fly ")
        }
 

  }

  




  


  public static func arePositionsAdjacent(startPosition : BoardPosition ,endPosition: BoardPosition, board : Board) -> Bool 
  {


      let offset = PositionParser.getOffset(position : startPosition , board : board)
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



 public  static func validatePositionLocation(xCordinate : Character , yCordinate : Character) throws
  {

    guard xCordinate.isLetter else {
          throw NineMortisError.runtimeError("First symbol -  \(xCordinate) ,is not a letter")
        }

    guard yCordinate.isNumber else {
         throw NineMortisError.runtimeError("Second symbol \(yCordinate) is not a number")
        }




  }


 public static func validateSinglePosition(position : String , board : Board) throws
  {




    guard position.count == 2 else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be 2")
        }

    let startX = position[0]
    let startY = position[1]
 
  
    try validatePositionLocation(xCordinate : startX , yCordinate : startY)

    try isPositionExisting(xCordinate: startX , yCordinate : startY , matX : board.getLength() , matY : board.getWidth() , board : board )
    ///check if it is in range 




  }


   public static func validateSinglePosition(position : BoardPosition, board : Board) throws
  {




    let x = position.getX()
    let y = position.getY()

    guard board.isPointExisting(xCordinate : x , yCordinate : y) else {
            throw NineMortisError.runtimeError("Position \(x) \(y) does not exist")
        }

  }




  public static func isPositionExisting( xCordinate : Character , yCordinate : Character , matX : Int, matY : Int , board :Board) throws
  {

  
        guard allowedLetters.contains(xCordinate) else {
            throw NineMortisError.runtimeError("Illegal letter for cordinates - \(xCordinate) ,letter not in Range [A-G]")
        }
          guard allowedNumbers.contains(yCordinate) else {
            throw NineMortisError.runtimeError("Illegal number for cordinates - \(yCordinate) ,number not in Range [1;7]")
        }
        let y = try PositionParser.convertLetterToPosition(position : xCordinate)
        var x = 0
        if let inputY = Int(String(yCordinate))
        {
           x = inputY
        }
        else
        {
            throw NineMortisError.runtimeError("Passed Parameter \(yCordinate) is not a number ")
        }

         x = PositionParser.convertInputIndexToPosition(position : x)
     
        guard board.isPointExisting(xCordinate : x , yCordinate : y) 
        else
        { 
           throw NineMortisError.runtimeError("Illegal posiiton \(x)\(y)")
        }


        
  }



  








}
