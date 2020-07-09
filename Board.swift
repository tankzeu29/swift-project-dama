
/*
* Represents the game board 
*/
public class Board
{

private var board = [[String]]()

private var header = ""

private let matrixLength = 25
private let matrixWidth = 13
private let startColumnOffset = "  "
private  var ROWS_TO_INITIALIZE = 0
private  let LETTERS_OFFSET = 4
private  let HEADER_START_OFFSET = "  "
private  let allowedLetters: [Character] = ("A"..."G").characters
 private  let allowedNumbers  : [Character] = ("1"..."7").characters

/*
* Returns the matrix length
*/
func getLength() -> Int
{
  return matrixLength
  
}

/*
* Return the matrix width
*/
func getWidth() -> Int 
{
  return matrixWidth
}


public init()
{
 board = Array(repeating: Array(repeating: BoardBoundElements.ILLEGAL_POSITION, count: matrixLength), count: matrixWidth)
ROWS_TO_INITIALIZE = allowedLetters.count - 2


 setHeader()

initializeMatrixHorizontal()
initializeMatrixVerical()

}


/*
* Initializes all horizontal lines
*/
private func initializeMatrixHorizontal()
{
   var start = 0
  var end = matrixLength - 1
  var currentRow = 0;
   let bound = (end - start) / 2
   for step in 0...ROWS_TO_INITIALIZE{


     for i in start...end
     {
       if(i == start || i == end || i == bound)
       {

         board[currentRow][i] = BoardBoundElements.EMPTY_POSITION
       }
       else
       {
        board[currentRow][i] = BoardBoundElements.HORIZONTAL_LINE
       }
     }
     if ( step < 2)
     {
       start = start + 4
     end = end - 4
     currentRow = currentRow + 2
     }
     else if(step == 2)
     {
           
       currentRow = currentRow + 4
     }
     else
     {
         start = start - 4
          end = end + 4
         currentRow = currentRow + 2
     }

   }

   let middleX = (matrixWidth - 1) / 2
   let middleY = (matrixLength - 1) / 2
   let tileOffset = (matrixLength - 1) / 6 
   for i in 0...matrixLength - 1
   {
     let isOutsideMiddleRectangle = i < (middleY - tileOffset) || i > (middleY + tileOffset)
      if( isOutsideMiddleRectangle )
      {
               board[middleX][i] =  BoardBoundElements.HORIZONTAL_LINE
      }

   }


}


/*
* Initializes all verticle lines
*/
private func initializeMatrixVerical()
{


  var begin = 0
  var finish = (matrixLength - 1) / 2
  let middle = (finish + begin) / 2
  var step = 0;
  for position in 0...ROWS_TO_INITIALIZE{

    for i in begin...finish{


      if(i == begin || i == finish || i == middle)
      {
        
        board[i][step] = BoardBoundElements.EMPTY_POSITION
      }
      else
      {
      
         board[i][step] = BoardBoundElements.VERTICAL_LINE
      }
 
    }
      if(position < 2)
      {
         step = step + 4
      begin = begin + 2
      finish = finish - 2
      }
      else if ( position  == 2)
      {
        step = step + 8
  
      }
      else
      {
           step = step + 4
      begin = begin - 2 
      finish = finish + 2
      }


}

   let middleX = (matrixWidth - 1) / 2
   let middleY = (matrixLength - 1) / 2
   let tileOffset = (matrixWidth - 1) / 6 
  for i in 0...matrixWidth - 1
  {
    let isOutsideMiddleRectangle = i < (middleX - tileOffset) || i > (middleX + tileOffset) 
    let isEmptyPiecePosition = i % tileOffset == 0
    if( isOutsideMiddleRectangle && !isEmptyPiecePosition)
    {
          board[i][middleY]  = BoardBoundElements.VERTICAL_LINE
    }
  
  }


}




/*
* Creates header on top of the matrix to 
* display the letters from A-G
*/
private func setHeader()
{

  

    let emptySpaces  = (matrixLength - 1) / allowedLetters.count
   
    let spaces = String(repeating: " ", count: emptySpaces + LETTERS_OFFSET ) 
 
      var tempHeader = HEADER_START_OFFSET
      for letter in allowedLetters{

             tempHeader  += String(letter) + spaces
      }
      self.header = tempHeader
}


/*
* Prints the board in the console
*/
public func printBoard()
{
  
   print(header)

   for i in 0...matrixWidth - 1 {
   
   var matrixRow = ""
   if( i % 2 == 0)
   {
      matrixRow += String(i / 2 + 1) + " "
   }
   else
   {
     matrixRow += startColumnOffset
   }
  for j in 0...matrixLength - 1{

      let result =  board[i][j]

    
 
     matrixRow += String(result) + " "

 
  }
  print(matrixRow)

  
   }
  print("\n")
  print("\n")
}

/*
* Returns if position is not empty
* @param xPosition - the x position on the axis of the point
* @param yPosition - the y position on the ordinate of the point
* @return true if the position is occupied else return false if the position is free
*/
public func isOccupied( xPosition : Int,  yPosition : Int) -> Bool 
{
    print("Is occupied \(xPosition) \(yPosition) \(board[xPosition][yPosition])")
     return board[xPosition][yPosition] != BoardBoundElements.EMPTY_POSITION 

}
/*
* Sets colour for particular board cell
* @param xPosition - the x position on the axis of the point
* @param yPosition - the y position on the ordinate of the 
 @param colour - colour to be set
*/
private func setTileColor(xPosition : Int , yPosition : Int , colour : String)
{
 // print("\(xPosition) \(yPosition) \(colour)")
  board[xPosition][yPosition] = colour
}

/*
* Sets colour for particular board cell
* @param positionCordinates - cell cordinate
* @param currentPlayer - the player that moves the piece
*  @param oponent - @currentPlayer' s oponent
*/
  func setSinglePosition( positionCordinates : String ,  currentPlayer  : Player , oponent : Player) throws
  {

    
      try validateSinglePosition(position : positionCordinates )

   
       let currentPieceCell = try getPositionWithColour(position : positionCordinates)


    
      if(isOccupied(xPosition :currentPieceCell.getX(),yPosition : currentPieceCell.getY())  )
      

      {
          throw NineMortisError.runtimeError("Position  \(currentPieceCell.toString()) not valid position")
      }

   

     
        
  
      
        currentPieceCell.setColour( colour : currentPlayer.getColour());
        setTileColor(xPosition : currentPieceCell.getX() , yPosition : currentPieceCell.getY() ,colour : currentPieceCell.getColour())
       
        currentPlayer.addPiece(position : currentPieceCell)
          
       let totalMills = MillsFinder.findMills(position : currentPieceCell , board : self )
          print("Found mills : \(totalMills) ")
      if(totalMills > 0)
      {
         
          removeDamaPoints(currentPlayer : currentPlayer, oponent : oponent )
      }





      }
  




/*
* Removes an oponent piece
* @param positionCordinates - cell cordinate
* @param currentPlayer - the player that moves the piece
*
*/
  private func removeDamaPoints(currentPlayer : Player, oponent : Player )  
  {
    
      
          while(true)
          {
            print(IngameMessages.ENTER_VALID_POINT)
           if let playerInput = readLine() {

            do {
            let position =  try getPositionWithColour(position :playerInput)

          if(position.getColour() == BoardBoundElements.ILLEGAL_POSITION)
          {
            throw NineMortisError.runtimeError(GameExceptionMessages.REMOVE_EMPTY_POSITION )
          }

          let isColourCorrect = position.getColour() != currentPlayer.getColour() && position.getColour() == oponent.getColour()
            if(!isColourCorrect) 
            {
                throw NineMortisError.runtimeError(GameExceptionMessages.REMOVE_ILLEGAL_POSITION)
            }

            let currentPieceMills = MillsFinder.findMills(position : position , board : self)
            let oponentPiecesNotInMill = findAllNonMillPieces(player : oponent )
            if( currentPieceMills > 0 && !oponentPiecesNotInMill.contains(position))
            {
              
              var nonMillFiguresMessage = ""
              for position in oponentPiecesNotInMill{
                        nonMillFiguresMessage += position.toString() + ","
              }
        
               throw NineMortisError.runtimeError("This piece is part of oponent mill , you cannot remove it , try again.Possible positions to remove are \(nonMillFiguresMessage)")
            }

            removeAtPosition(point : position)
         
            oponent.removePiece(position : position)
            break;
      
           } catch NineMortisError.runtimeError(let errorMessage) {
                  print(errorMessage)
             
           }
           catch
           {
             print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
          
           }

      
          }
          else
          {
            print(IngameMessages.ENTER_VALID_POINT)
          }

           printBoard()
          }
  }
  
/*
* Finds all pieces that are not part of mill for a player
* @param player - player to find non-mill pieces
* @return nonMillPositions - list containing all pieces not in a mill
*/
private func findAllNonMillPieces(player : Player ) -> [BoardPosition]
{
  var nonMillPositions = [BoardPosition]()
  let playerPieces = player.getPieces()
  for piece in playerPieces
  {
    let totalMills =  MillsFinder.findMills(position : piece , board : self)
    if(totalMills == 0)
    {
      nonMillPositions.append(piece)
    }
  }

  return nonMillPositions

}



/*
* Returns the colour for specific position
* @param x - the x position on the axis of the point
* @param y - the y position on the ordinate of the point
  @return board[x][y] - the colour of the board cell
*/
 public func getPositionColour(x : Int , y : Int ) -> String
{
    return board[x][y]
}

/*
* Returns the colour for specific position
* @param position - the cell position on the board
* @return the colour of the board cell
*/
public func getPositionColour(position : BoardPosition) -> String
{
  let x = position.getX()
  let y = position.getY()
  return getPositionColour(x : x , y : y)
}

/*
* Checks if position is free for a player to move his piece
* @param position - the cell position on the board
* @return true if the position is free for the player to move , else false
*/
public func isPositionEmpty(position : BoardPosition) -> Bool
{
  if( !isPointExisting(point : position))
  {
      return false
  }
  let colour = getPositionColour(x  : position.getX() , y : position.getY())
  
 
  if(colour == BoardBoundElements.getEmptyPositionSymbol() )
  {
   
    return true
  }
  return false
}


/*
* Returns position on the board with the colour with which is on the board
* @param position - the cell position on the board
* @return position on the board with the colour with which is on the board
*/
public func getPositionWithColour(position : String ) throws -> BoardPosition
{
   try validateSinglePosition(position : position )

  
    let yCordinate = try PositionParser.convertLetterToPosition(position : position[0]) 
    var xCordinate = 0
    if let  x = Int(String(position[1]))
    {
      xCordinate = x
    }
    else
    {
       throw NineMortisError.runtimeError("Illegal value \(position[1])  ")
    }
    xCordinate = PositionParser.convertInputIndexToPosition(position : xCordinate)
    let boardColour = getPositionColour(x : xCordinate , y : yCordinate)

    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : boardColour)

}



/*
Checks if position is existing and valid for a player to place a piece
* @param xPosition - the x position on the axis of the point
* @param yPosition - the y position on the ordinate of the 
* @return true if the position exists , else false.
*/
public func isPointExisting(xCordinate : Int , yCordinate : Int) -> Bool
{


  let isXgreaterThanZero =  (xCordinate >= 0)
  let isYgreaterThanZero = (yCordinate >= 0)
  let isXinMaxRange = (xCordinate <= (matrixWidth - 1))
  let isYinMaxRange = (yCordinate <= (matrixLength - 1))
  let inRange = isXgreaterThanZero && isYgreaterThanZero && isXinMaxRange && isYinMaxRange

  if(!inRange)
  {

    return false
  }
  let colour = board[xCordinate][yCordinate]
  if(colour == BoardBoundElements.ILLEGAL_POSITION || colour == BoardBoundElements.HORIZONTAL_LINE || colour == BoardBoundElements.VERTICAL_LINE   )
  {

    return false
  }
  return true

}

/*
Checks if position is existing and valid for a player to place a piece
* @param point - point on the board
* @return true if the position exists , else false.
*/

public func isPointExisting(point : BoardPosition) -> Bool
{
  let xCordinate = point.getX()
  let yCordinate = point.getY()
  return isPointExisting(xCordinate : xCordinate , yCordinate : yCordinate)
}


/*  
  Sets a position on the board to be empty
* @param point - point on the board
* @return true if the position exists , else false.
*/
public func removeAtPosition(point : BoardPosition)
{      let xCordinate = point.getX()
       let yCordinate = point.getY()
      board[xCordinate][yCordinate] = BoardBoundElements.EMPTY_POSITION
}

  


/*
  
* @param point - point on the board
* @return true if the position exists , else false.
*/
 public  func validateSinglePosition(position : String ) throws
  {




    guard position.count == 2 else {
          throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be 2")
        }

    let startX = position[0]
    let startY = position[1]
 
  
    try validatePositionLocation(xCordinate : startX , yCordinate : startY)

    try isPositionExisting(xCordinate: startX , yCordinate : startY , matX : getLength() , matY : getWidth()  )





  }

     public  func validateSinglePosition(position : BoardPosition) throws
  {




    let x = position.getX()
    let y = position.getY()

    guard isPointExisting(xCordinate : x , yCordinate : y) else {
            throw NineMortisError.runtimeError("Position you have entered \(position.toString()) does not exist")
        }

  }
/*
  
* Validates if point has illegal characters
  @xCordinate - the x cordinate
  @yCordinate - the y cordinate
* @return true if the position exists , else false.
*/
 public   func validatePositionLocation(xCordinate : Character , yCordinate : Character) throws
  {

    guard xCordinate.isLetter else {
          throw NineMortisError.runtimeError("First symbol -  \(xCordinate) ,is not a letter")
        }

    guard yCordinate.isNumber else {
         throw NineMortisError.runtimeError("Second symbol \(yCordinate) is not a number")
        }




  }

/* Validates if point is existing  on the board for a Player to play with
  @xCordinate - the x cordinate
  @yCordinate - the y cordinate
* @return true if the position exists , else false.
*/
    public  func isPositionExisting( xCordinate : Character , yCordinate : Character , matX : Int, matY : Int ) throws
  {

  
        guard allowedLetters.contains(xCordinate) else {
            throw NineMortisError.runtimeError("Illegal letter for cordinates - \(xCordinate) ,letter not in Range [A-G]")
        }
          guard allowedNumbers.contains(yCordinate) else {
            throw NineMortisError.runtimeError("Illegal number for cordinates - \(yCordinate) ,number not in Range [1-7]")
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
     
        guard isPointExisting(xCordinate : x , yCordinate : y) 
        else
        { 
           throw NineMortisError.runtimeError("Position does not exist \(xCordinate)\(yCordinate)")
        }


        
  }
  }









