

public class Board
{

private var arr = [[String]]()
private var header = ""

private let matrixLength = 25
private let matrixWidth = 13
private let startColumnOffset = "  "
private let letters = [ "A" , "B", "C", "D", "E" , "F" , "G"]

func getLength() -> Int
{
  return matrixLength
}
func getWidth() -> Int 
{
  return matrixWidth
}


public init()
{
 arr = Array(repeating: Array(repeating: BoardBoundElements.ILLEGAL_POSITION, count: matrixLength), count: matrixWidth)
   
   

 setHeader()

initializeMatrixHorizontal()
initializeMatrixVerical()

}



private func initializeMatrixHorizontal()
{
   var start = 0
  var end = matrixLength - 1
  var currentRow = 0;
   let bound = (end - start) / 2
   for step in 0...5{


     for i in start...end
     {
       if(i == start || i == end || i == bound)
       {

         arr[currentRow][i] = BoardBoundElements.EMPTY_POSITION
       }
       else
       {
        arr[currentRow][i] = BoardBoundElements.HORIZONTAL_LINE
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
      if( i < (middleY - tileOffset) || i > (middleY + tileOffset))
      {
               arr[middleX][i] =  BoardBoundElements.HORIZONTAL_LINE
      }

   }


}


private func initializeMatrixVerical()
{


  var begin = 0
  var finish = (matrixLength - 1) / 2
  let middle = (finish + begin) / 2
  var step = 0;
  for position in 0...5{

    for i in begin...finish{


      if(i == begin || i == finish || i == middle)
      {
        
        arr[i][step] = BoardBoundElements.EMPTY_POSITION
      }
      else
      {
      
         arr[i][step] = BoardBoundElements.VERTICAL_LINE
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
    if( i < (middleX - tileOffset) || i > (middleX + tileOffset) )
    {
          arr[i][middleY]  = BoardBoundElements.VERTICAL_LINE
    }
  
  }


}


private func setHeader()
{

  

    let emptySpaces  = (matrixLength - 1) / letters.count
   
    let spaces = String(repeating: " ", count: emptySpaces + 4 ) 
 
      var tempHeader = "  "
      for alphabet in letters{

            
           

             tempHeader  += alphabet + spaces
      }
      self.header = tempHeader
}


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
     matrixRow += "  "
   }
  for j in 0...matrixLength - 1{

      let result =  arr[i][j]

    
 
     matrixRow += String(result) + " "

 
  }
  print(matrixRow)

  
   }

}

public func isOccupied( xPosition : Int,  yPosition : Int) -> Bool 
{
    //print("Is occupied \(xPosition) \(yPosition) \(arr[xPosition][yPosition])")
     return arr[xPosition][yPosition] == BoardBoundElements.EMPTY_POSITION 

}

private func setTileColor(xPosition : Int , yPosition : Int , colour : String)
{
 // print("\(xPosition) \(yPosition) \(colour)")
  arr[xPosition][yPosition] = colour
}


  func setSinglePosition( positionCordinates : String ,  currentPlayer  : Player , oponent : Player, isMovement : Bool) throws
  {

    
      try ParametersValidator.validateSinglePosition(position : positionCordinates , board : board)

   
       let currentPieceCell = try getPositionWithColour(position : positionCordinates , colour : currentPlayer.getColour())


    
      if(isMovement && board.isOccupied(xPosition :currentPieceCell.getX(),yPosition : currentPieceCell.getY())  )
      

      {
          throw NineMortisError.runtimeError("Possition is \(currentPieceCell.toString()) not valid position")
      }

   

     
        
  
                   let boardColour = PlayerColours.getColour( colour : currentPieceCell.getColour())
        board.setTileColor(xPosition : currentPieceCell.getX() , yPosition : currentPieceCell.getY() ,colour : boardColour)
       
        currentPlayer.addPiece(position : currentPieceCell)
          
       let totalMills = PositionParser.findMills(position : currentPieceCell , board: board)
          print("Found mills : \(totalMills) ")
      if(totalMills > 0)
      {
     
          removeDamaPoints(totalMills : totalMills , oponent : oponent)
      }





      }
  





 
     
  


  private func removeDamaPoints(totalMills : Int  , oponent : Player)  
  {
      var totalRemoved = 0
          print("Enter cordinates to remove Enemy figure")
          while(totalRemoved !=  totalMills || oponent.getTotalPieces() == 0)
          {
           if let playerInput = readLine() {

            do {
            let position =  try getPositionWithColour(position :playerInput, colour : oponent.getColour())

            if(position.getColour() != oponent.getColour())
            {
               throw NineMortisError.runtimeError("You cannot remove your piece , enter again")
            }
            let oponentMillsWithPiece = PositionParser.findMills(position : position , board : board)
            if(oponentMillsWithPiece != 0)
            {
               throw NineMortisError.runtimeError("This piecei is part of oponent mill , you cannot remove it , try again.")
            }

            removeAtPosition(point : position)
            totalRemoved += 1
            oponent.removePiece(position : position)
      
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
            print("Please enter valid point")
          }
          }
  }
  





 public func getPositionColour(x : Int , y : Int ) -> String
{
    return arr[x][y]
}

public func getPositionColour(position : BoardPosition) -> String
{
  let x = position.getX()
  let y = position.getY()
  return getPositionColour(x : x , y : y)
}

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



public func getPositionWithColour(position : String ,  colour : PieceColour) throws -> BoardPosition
{
   try ParametersValidator.validateSinglePosition(position : position , board : board)

  
    let yCordinate = PositionParser.convertLetterToPosition(position : position[0]) 
    var xCordinate = Int(String(position[1]))! 
    xCordinate = PositionParser.convertInputIndexToPosition(position : xCordinate)
  
    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : colour)

}

















public func isPointExisting(xCordinate : Int , yCordinate : Int) -> Bool
{

  //print("Does \(xCordinate) \(yCordinate) exist?")
  let inRange =  (xCordinate >= 0) && (yCordinate >= 0) && (xCordinate <= (matrixWidth - 1)) && (yCordinate <= (matrixLength - 1))

  if(!inRange)
  {
    //print("Not in range")
    return false
  }
  let colour = arr[xCordinate][yCordinate]
  if(colour == BoardBoundElements.ILLEGAL_POSITION || colour == BoardBoundElements.HORIZONTAL_LINE || colour == BoardBoundElements.VERTICAL_LINE   )
  {
   // print("Bad colour \(colour)")
    return false
  }
  return true

}

public func isPointExisting(point : BoardPosition) -> Bool
{
  let xCordinate = point.getX()
  let yCordinate = point.getY()
  return isPointExisting(xCordinate : xCordinate , yCordinate : yCordinate)
}



public func removeAtPosition(point : BoardPosition)
{
      arr[point.getX()][point.getY()] = BoardBoundElements.EMPTY_POSITION
}



  }








