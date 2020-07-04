

class PositionParser
{


static let  lettersToInt: [Character : Int] = [
  "A" : 0,
  "B" : 4,
  "C" : 8,
  "D" : 12,
  "E" : 16,
  "F" : 20,
  "G" : 24
]


static func convertLetterToPosition(position : Character) -> Int
{
  return lettersToInt[position]!
}

static func convertInputIndexToPosition(position : Int) -> Int
{
  if( position == 1)
  {
    return 0
  }
  else if(position == 2 )
  {
    return position
  }
  else if (position == 3)
  {
    return 4
  }
  else
  {
      return 2 * position - 2
  }
}

static func getHalfOfMatrixSide(matrixSide : Int) -> Int
{
  if ( matrixSide % 2 == 0)
  {
    return matrixSide / 2
  }
  else
  {
    return matrixSide / 2 + 1
  }
}




  




static func getPositionWithColour(position : String , board : Board) throws -> BoardPosition
{
   try ParametersValidator.validateSinglePosition(position : position , board : board)

    let yCordinate = convertLetterToPosition(position : position[0]) 
    var xCordinate = Int(String(position[1]))! 


    //  print("Gonna fetch \(yCordinate) \(xCordinate)")
    xCordinate = PositionParser.convertInputIndexToPosition(position : xCordinate)
    // print("new fetch \(yCordinate) \(xCordinate)")
     let colour = board.getPositionColour(x : xCordinate , y : yCordinate)
     let pieceColour = getPieceColourFromString(colour : colour)
  

    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : pieceColour)

}

static func getPosition(xCordinate : Int , yCordinate : Int ,board : Board) throws -> BoardPosition
{
   let position = BoardPosition(xCordinate : xCordinate, yCordinate : yCordinate)
   try ParametersValidator.validateSinglePosition(position : position , board : board)


   //   print("Gonna fetch \(yCordinate) \(xCordinate)")

    // print("new fetch \(yCordinate) \(xCordinate)")
     let colour = board.getPositionColour(x : xCordinate , y : yCordinate)
     let boardColour = getPieceColourFromString(colour : colour)
  

    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : boardColour)

}

static func getPositionFromString(position : String, board : Board) throws -> BoardPosition
{
   try ParametersValidator.validateSinglePosition(position : position , board : board)

    let yCordinate = convertLetterToPosition(position : position[0]) 
    var xCordinate = Int(String(position[1]))! 


      print("Gonna fetch \(yCordinate) \(xCordinate)")
    xCordinate = PositionParser.convertInputIndexToPosition(position : xCordinate)
    let colour = board.getPositionColour(x : xCordinate , y : yCordinate)
    let convertedColour = getPieceColourFromString(colour : colour)
     print("new fetch \(yCordinate) \(xCordinate)")
    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : convertedColour)

}




    static func getPieceColourFromString ( colour : String) -> PieceColour
  {
    if( colour == PlayerColours.WHITE_FIGURE)
    {
      return PieceColour.WHITE
    }
    else if (colour == PlayerColours.BLACK_FIGURE )
    {
      return PieceColour.BLACK
    }
    else if ( colour == BoardBoundElements.HORIZONTAL_LINE)
    {
      return PieceColour.HORIZONTAL_LINE
    }
     else if ( colour == BoardBoundElements.VERTICAL_LINE)
    {
         return PieceColour.VERTICAL_LINE
    }
    else
    {
      return PieceColour.EMPTY
    }

  }





static func getOffset(position : BoardPosition , board : Board) -> (first :Int , second :Int)
{


  let pointX = position.getX()
  let pointY = position.getY()


  var yAnswer = 0
  var xAnswer = 0
  var halfLength = (board.getLength() - 1) 
   var halfHeight = (board.getWidth() - 1)
 
  if(pointY == 0 || pointY == halfLength)
  {
   
    
    if(pointY  == halfLength / 2 )
    {
        yAnswer = halfHeight / 6
    }
    else
    {
        yAnswer = halfLength / 2
    }
  }
  else
  {
  yAnswer =  findY(position : position , board : board)
  }

  
 
  if(pointX == 0 || pointX == halfHeight)
  {
   
    
    if(pointX  == halfHeight / 2 )
    {
        xAnswer = halfLength / 6
    }
    else
    {
        xAnswer = halfHeight / 2
    }
  }
  else
  {
     
     xAnswer = findX(position : position , board : board)
  }

  //print("Found offset : X \(xAnswer) , Y \(yAnswer)")
  return (xAnswer ,yAnswer)

}







static func findX(position : BoardPosition ,board : Board) -> Int

{
   //print("In function X")
  let matrixLength = board.getLength()
  let matrixHeight = board.getWidth()
  let x = position.getX()
  let y = position.getY()
  //print(" x \(x) y \(y)")
//  print(" matrixLength \(matrixLength) matrixHeight \(matrixHeight)")
  let outerPiece = (matrixHeight - 3) / 2
//  print("outerPiece \(outerPiece)")
  var index = abs( matrixLength - 1 - y)
 //  print("tEMP1 index \(outerPiece)")
  index = index / 4
 // print("tEMP2 index \(outerPiece)")
  var result = outerPiece - index * 2
  result += 1
 // print( "Return X \(result)")
  return result
}


static func findY(position : BoardPosition ,board : Board) -> Int

{
  //print("In function Y")
let matrixLength = board.getLength()
  let matrixHeight = board.getWidth()
  let x = position.getX()
  let y = position.getY()
//  print(" x \(x) y \(y)")
//  print(" matrixLength \(matrixLength) matrixHeight \(matrixHeight)")
let halfHeight = (matrixHeight  - 1 ) / 2
  let outerPiece = (matrixLength - 3) / 2
//  print("outerPiece \(outerPiece)")
  //print("Substract \(halfHeight) from \(x) " )
  var index = abs( halfHeight - x)
   //print("tEMP1 index \(index)")
  index = index / 2
  //print("tEMP2 index \(index)")
  var result = 0
  if(index == 3)
  {
    result = outerPiece 
  }
  else if(index == 2)
  {
    result = 7
  }
  else if(index == 1 || index ==  0)
  {
    result =  4
  }

  return result + 1

}





static func findMills(position : BoardPosition , board : Board) -> Int
{


  let tuple = getOffset(position : position , board : board)
 
  let destinationToCenterX = tuple.first


  let destinationToCenterY = tuple.second


  //  print("positionWidth \(positionWidth) positionHeight \(positionHeight) ")

    //print("destinationToCenterX \(destinationToCenterX) destinationToCenterY \(destinationToCenterY) ")
  var totalMills = 0
  totalMills = //findXMills(position: position , offset : destinationToCenterX , board : board )

    findNextXmills(position: position , offset : -destinationToCenterX , board : board ) +
     findNextXmills(position: position , offset : destinationToCenterX , board : board ) +

     findNextYmills(position: position , offset : -destinationToCenterY , board : board ) +
     findNextYmills(position: position , offset : destinationToCenterY , board : board ) +
   findAdjacentMills(position : position , offset : destinationToCenterX , incrementX : true)
  +  findAdjacentMills(position : position , offset : destinationToCenterY , incrementX : false)
  return totalMills 
}





static func findAdjacentMills(position : BoardPosition , offset : Int , incrementX : Bool) -> Int
{
  var result = 0
  var startSum = 0
  let startX = position.getX()
  let startY = position.getY()
  if(incrementX)
  {
    startSum = position.getX()
  }
  else
  {
     startSum = position.getY()
  }
  let secondPointValue = startSum + offset
  let thirdPointValue =  startSum - offset

  var secondPoint = BoardPosition()
  var thirdPoint  = BoardPosition()
  
  do {
  if(incrementX)
  {
       secondPoint = try getPosition(xCordinate : secondPointValue , yCordinate : startY , board :board )
       thirdPoint = try getPosition(xCordinate : thirdPointValue , yCordinate :startY, board :board ) 

  }
  else
  {
      secondPoint = try getPosition(xCordinate : startX , yCordinate : secondPointValue , board :board )
       thirdPoint = try getPosition(xCordinate : startX , yCordinate : thirdPointValue , board :board ) 
  }
  result = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint)
  
   } catch NineMortisError.runtimeError(let errorMessage) {
                  print(errorMessage)
   }
   catch {
     print("Unable to find adjacent mills")
   }
   return result





}


static func findNextXmills(position : BoardPosition , offset : Int , board : Board) -> Int
{
  let startX = position.getX()
  let startY = position.getY()
  var answer = 0
 do{
   let secondPoint = try getPosition(xCordinate : startX + offset , yCordinate : startY , board : board)
   let thirdPoint = try getPosition(xCordinate : startX + 2 * offset , yCordinate : startY, board : board)
   answer = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint)

  } catch NineMortisError.runtimeError(let errorMessage) {
             
   }
   catch
   {

   }

  return answer

}

static func findNextYmills(position : BoardPosition , offset : Int , board : Board) -> Int
{
  let startX = position.getX()
  let startY = position.getY()
  var answer = 0
 do{
   let secondPoint = try getPosition(xCordinate : startX  , yCordinate : startY + offset , board : board)
   let thirdPoint = try getPosition(xCordinate : startX  , yCordinate : startY + 2 * offset, board : board)
   answer = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint)
  } catch NineMortisError.runtimeError(let errorMessage) {
             
   }
   catch
   {

   }

  return answer

}

static func findSameColour(firstPoint : BoardPosition , secondPoint : BoardPosition , thirdPoint : BoardPosition) -> Int
{
  // print("Searching TRIPLETS \(firstPoint.toString()) , \(secondPoint.toString()) , \(thirdPoint.toString()) ")
  if(firstPoint == secondPoint || secondPoint == thirdPoint || thirdPoint == firstPoint)
  {
    return 0
  }
  let firstPointExists = board.isPointExisting(point : firstPoint)
  if(firstPointExists)
  {
    let secondPointExists =  board.isPointExisting(point : secondPoint)
    if(secondPointExists)
    {
      let thirdPointExists =  board.isPointExisting(point : thirdPoint)
      if(thirdPointExists)
      {
          let firstPointColour = board.getPositionColour(position : firstPoint)
           let secondPointColour = board.getPositionColour(position : secondPoint)
            let thirdPointColour = board.getPositionColour(position : thirdPoint)
            if(firstPointColour == secondPointColour && secondPointColour == thirdPointColour  )
            {
                // print("THIS ARE MILL LOL \(firstPoint.toString()) , \(secondPoint.toString()) , \(thirdPoint.toString()) ")
                //  print("With coloursL \(firstPointColour) , \(secondPointColour) , \(thirdPointColour) ")
              return 1
            }
      }
    }
  }
  return 0
}







static func findXMills(position : BoardPosition , offset : Int , board : Board) -> Int
{
    print("for \(position.getX()) ,\(position.getY())")
    print("possible moves 1")
   var totalMills = 0
   let secondPointX = position.getX() + offset
   let thirdPointX = secondPointX + offset
   let allY = position.getY()
  
do{
   let secondPoint = try getPosition(xCordinate : secondPointX , yCordinate : allY , board : board)
   let thirdPoint = try getPosition(xCordinate : thirdPointX  , yCordinate : allY, board : board)
   totalMills = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint)
  } catch NineMortisError.runtimeError(let errorMessage) {
             
   }
   catch
   {

   }

   return totalMills








  /*
   var allY = position.getY()
       print("Alt \(secondPointX) ,\(allY)")
       print("Alt \(thirdPointX) ,\(allY)")
   var secondPointExists = board.isPointExisting(xCordinate : secondPointX, yCordinate : allY )
    var thirdPointExists = board.isPointExisting(xCordinate : thirdPointX, yCordinate : allY )
    var cordinatesAreDifferent = (position.getX() != secondPointX && secondPointX != thirdPointX)

    if(cordinatesAreDifferent && secondPointExists && thirdPointExists )
    {
      var firstColour = board.getPositionColour(x : position.getX() , y: allY)
      var secondColour = board.getPositionColour(x : secondPointX , y: allY)
      var thirdColour = board.getPositionColour(x : thirdPointX , y: allY)

      if(firstColour == secondColour && secondColour == thirdColour)
      {        print("RES \(position.getX()) ,\(allY)")
      print(firstColour)
     print(secondColour)
     print(thirdColour)
        return 1
      }
    }
  return 0
  */
}

static func findYMills(position : BoardPosition , offset : Int , board : Board) -> Int
{
   print("for \(position.getX()) ,\(position.getY())")
    print("possible moves 2")
   let secondPointY = position.getY() + offset
   let thirdPointY = secondPointY + offset
   let allX = position.getX()
   var totalMills = 0 

     
do{
   let secondPoint = try getPosition(xCordinate : allX  , yCordinate : secondPointY , board : board)
   let thirdPoint = try getPosition(xCordinate : allX  , yCordinate : thirdPointY, board : board)
   totalMills = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint)
  } catch NineMortisError.runtimeError(let errorMessage) {
      
   }
   catch
   {

   }

   return totalMills
  /*
   var secondPointExists = board.isPointExisting(xCordinate : allX, yCordinate : secondPointY )
    var thirdPointExists = board.isPointExisting(xCordinate : allX, yCordinate : thirdPointY )
    var cordinatesAreDifferent = (position.getY() != secondPointY && secondPointY != thirdPointY)
    if(cordinatesAreDifferent && secondPointExists && thirdPointExists )
    {
      var firstColour = board.getPositionColour(x : allX , y: position.getY())
      var secondColour = board.getPositionColour(x :allX , y: secondPointY)
      var thirdColour = board.getPositionColour(x : allX , y: thirdPointY)
      if(firstColour == secondColour && secondColour == thirdColour)
      {
            print("RES \(allX) ,\(secondPointY)")
           print("RES \(allX) ,\(thirdPointY)")
            print(firstColour)
     print(secondColour)
     print(thirdColour)
        return 1
      }
    }
  return 0

  */
}



 

 



}