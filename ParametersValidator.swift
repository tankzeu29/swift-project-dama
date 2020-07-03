

class ParametersValidator
{

static let allowedLetters: [Character] = ("A"..."G").characters
  static var allowedNumbers  : [Character] = ("1"..."7").characters






   static func validateMovement(position : String , board : Board , currentPlayer : Player, oponent : Player , canFly : Bool ) throws
  {



    
    guard position.count == 4 else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be 4")
        }

  
  try validateSinglePosition(position : position.substring(to:2) , board : board)
    try validateSinglePosition(position : position.substring(from:2) , board : board)

    let startPosition = try PositionParser.getPositionWithColour(position : position.substring(to:2) , board : board)
    let endPosition =  try PositionParser.getPositionWithColour(position : position.substring(from:2) , board : board)


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

        guard isFlyingMoveAdj else
        {
            throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) MUST NOT BE adjacent because u must fly ")
        }
       guard isNormalMoveFlyingMove else
        {
             throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) MUST BE adjacent ")
        }
 

  }

  




  


  static func arePositionsAdjacent(startPosition : BoardPosition ,endPosition: BoardPosition, board : Board) -> Bool 
  {


      let offset = PositionParser.getOffset(position : startPosition , board : board)
      let startX = startPosition.getX()
      let startY = startPosition.getY()
      let xOffset = offset.first
      let yOffset = offset.second
      //print(" Found offset \(xOffset) \(yOffset)")
   
      let isAdjacent = vlaidateAdjHelper(endPosition : endPosition ,startX :startX + xOffset , startY: startY ) ||
     vlaidateAdjHelper(endPosition : endPosition , startX :startX - xOffset ,startY: startY ) ||
    vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY + yOffset ) ||
     vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY - yOffset) 

      return isAdjacent


  }

  static func vlaidateAdjHelper(endPosition : BoardPosition , startX :Int , startY : Int) -> Bool
  {
      let positionExist = board.isPointExisting(xCordinate :startX ,yCordinate: startY )
      if(positionExist)
      {
         return endPosition.getX() == startX && endPosition.getY() == startY
      }
      return false

  }



  static func validatePositionLocation(xCordinate : Character , yCordinate : Character) throws
  {

    guard xCordinate.isLetter else {
          throw NineMortisError.runtimeError("First symbol -  \(xCordinate) ,is not a letter")
        }

    guard yCordinate.isNumber else {
         throw NineMortisError.runtimeError("Second symbol \(yCordinate) is not a number")
        }




  }


 static func validateSinglePosition(position : String , board : Board) throws
  {




    guard position.count == 2 else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be 2")
        }

    let startX = position[0]
    let startY = position[1]
 

    try validatePositionLocation(xCordinate : startX , yCordinate : startY)

    try isPositionExisting(xCordinate: startX , yCordinate : startY , matX : board.getLength() , matY : board.getWidth() )
    ///check if it is in range 

  }


   static func validateSinglePosition(position : BoardPosition, board : Board) throws
  {




    let x = position.getX()
    let y = position.getY()

    guard board.isPointExisting(xCordinate : x , yCordinate : y) else {
            throw NineMortisError.runtimeError("Position \(x) \(y) does not exist")
        }

  }




  static func isPositionExisting( xCordinate : Character , yCordinate : Character , matX : Int, matY : Int) throws
  {

  
        guard allowedLetters.contains(xCordinate) else {
            throw NineMortisError.runtimeError("Illegal letter for cordinates - \(xCordinate) ,letter not in Range [A-G]")
        }
          guard allowedNumbers.contains(yCordinate) else {
            throw NineMortisError.runtimeError("Illegal number for cordinates - \(yCordinate) ,number not in Range [1;7]")
        }
        let y = PositionParser.convertLetterToPosition(position : xCordinate)
        var x = Int(String(yCordinate))!

         x = PositionParser.convertInputIndexToPosition(position : x)
     
        guard board.isPointExisting(xCordinate : x , yCordinate : y) 
        else
        { 
           throw NineMortisError.runtimeError("Illegal posiiton \(x)\(y)")
        }


        
  }



  








}
