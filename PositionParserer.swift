

public class PositionParser
{


private static let  lettersToInt: [Character : Int] = [
  "A" : 0,
  "B" : 4,
  "C" : 8,
  "D" : 12,
  "E" : 16,
  "F" : 20,
  "G" : 24
]


public static func convertLetterToPosition(position : Character) throws -> Int
{
  if let dictionaryValue =  lettersToInt[position]
  {
    return dictionaryValue
  }
  else
  {
      throw NineMortisError.runtimeError("Illegal column value \(position)  ")
  }
}

public static func convertInputIndexToPosition(position : Int) -> Int
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





  


public static func getPosition(xCordinate : Int , yCordinate : Int ,board : Board) throws -> BoardPosition
{
   let position = BoardPosition(xCordinate : xCordinate, yCordinate : yCordinate)
   try ParametersValidator.validateSinglePosition(position : position , board : board)


   //   print("Gonna fetch \(yCordinate) \(xCordinate)")

    // print("new fetch \(yCordinate) \(xCordinate)")
     let colour = board.getPositionColour(x : xCordinate , y : yCordinate)

  

    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : colour)

}

public static func getPositionFromString(position : String, board : Board) throws -> BoardPosition
{
   try ParametersValidator.validateSinglePosition(position : position , board : board)

    let yCordinate = try convertLetterToPosition(position : position[0])
    var xCordinate = 0 
    if let  inputX = Int(String(position[1]))
    {
      xCordinate = inputX
    }
    else
    {
       throw NineMortisError.runtimeError("Passed parameter \(position[1]) is not a number ")
    }


      print("Gonna fetch \(yCordinate) \(xCordinate)")
    xCordinate = PositionParser.convertInputIndexToPosition(position : xCordinate)
    let colour = board.getPositionColour(x : xCordinate , y : yCordinate)
 
     print("new fetch \(yCordinate) \(xCordinate)")
    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : colour)

}








public static func getOffset(position : BoardPosition , board : Board) -> (first :Int , second :Int)
{


  let pointX = position.getX()
  let pointY = position.getY()


  var yAnswer = 0
  var xAnswer = 0
  let halfLength = (board.getLength() - 1) 

   let matrixLength = board.getLength() 
   let matrixWidth = board.getWidth() 
 
  yAnswer = findYOffset(pointX : pointX , matrixLength : matrixLength , matrixWidth : matrixWidth)

  
  
  xAnswer = findXOffset(pointY : pointY , matrixLength : matrixLength , matrixWidth : matrixWidth)

  print("FOUND_OFFSET \(xAnswer) , \(yAnswer)")
  return (xAnswer,yAnswer)

}



private static func findYOffset(pointX : Int , matrixLength : Int , matrixWidth : Int) -> Int

{

  var yAnswer = 0;
      let difference =  abs ( ((matrixWidth ) / 2) - pointX )

if(difference == 0)
{
  yAnswer = 4
}
else if(difference == 6 )
{
  yAnswer = (matrixLength - 1) / 2
}
else if (difference == 4)
{
  yAnswer = 8
}
else if (difference == 2)
{
  yAnswer =  4
}
else
{

}

return yAnswer

}

private static func findXOffset(pointY : Int , matrixLength : Int , matrixWidth : Int) -> Int
{
  var xAnswer = 0
    var difference = abs( ( (matrixLength ) / 2 - pointY) )

  difference = difference / 4
 // print("X difference \(difference)")
  if( difference == 0 )
  {
 //     print("X case_0")
    xAnswer = 2
  }
  else if(difference  == 3)
  {  //print("X case_3")
      xAnswer =  (matrixWidth - 1) / 2
  }
  else if( difference == 2){
     xAnswer =  4
    //  print("X case_2")
}
else if (difference == 1)
{  //  print("X case_1")
     xAnswer =  2
}
else
{

}

return xAnswer
}




public static func findMills(position : BoardPosition , board : Board) -> Int
{


  let tuple = getOffset(position : position , board : board)
 
  let destinationToCenterX = tuple.first


  let destinationToCenterY = tuple.second


  //  print("positionWidth \(positionWidth) positionHeight \(positionHeight) ")

    //print("destinationToCenterX \(destinationToCenterX) destinationToCenterY \(destinationToCenterY) ")
  var totalMills = 0
  totalMills = //findXMills(position: position , offset : destinationToCenterX , board : board )

    findAdjAxisMills(position: position , offset : -destinationToCenterX , board : board ) +
     findAdjAxisMills(position: position , offset : destinationToCenterX , board : board ) +

     findAdjOrdinateMills(position: position , offset : -destinationToCenterY , board : board ) +
     findAdjOrdinateMills(position: position , offset : destinationToCenterY , board : board ) +
   findAdjacentMills(position : position , offset : destinationToCenterX , incrementX : true , board : board)
  +  findAdjacentMills(position : position , offset : destinationToCenterY , incrementX : false , board : board)
  return totalMills 
}





public static func findAdjacentMills(position : BoardPosition , offset : Int , incrementX : Bool , board : Board) -> Int
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

      print("CASE1")
       secondPoint = try getPosition(xCordinate : secondPointValue , yCordinate : startY , board :board )
       thirdPoint = try getPosition(xCordinate : thirdPointValue , yCordinate :startY, board :board ) 
        print("CASE1_END")

  }
  else
  {   print("CASE2")
      secondPoint = try getPosition(xCordinate : startX , yCordinate : secondPointValue , board :board )
       thirdPoint = try getPosition(xCordinate : startX , yCordinate : thirdPointValue , board :board ) 
  }
  print("Searching as center \(position.toString()) ,\(secondPoint.toString()), \(thirdPoint.toString())")
  result = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint , board : board)
  
   } catch NineMortisError.runtimeError(let errorMessage) {
                  print(errorMessage)
   }
   catch {
     print(GameExceptionMessages.UNEXPECED_MILLS_OUTCOME)
   }
   return result





}


public static func findAdjAxisMills(position : BoardPosition , offset : Int , board : Board) -> Int
{
  let startX = position.getX()
  let startY = position.getY()
  var answer = 0
 do{
   let secondPoint = try getPosition(xCordinate : startX + offset , yCordinate : startY , board : board)
   let thirdPoint = try getPosition(xCordinate : startX + 2 * offset , yCordinate : startY, board : board)
   answer = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint , board : board)

  }  
   catch
   {
     return answer
   }

  return answer

}

public static func findAdjOrdinateMills(position : BoardPosition , offset : Int , board : Board) -> Int
{
  let startX = position.getX()
  let startY = position.getY()
  var answer = 0
 do{
   let secondPoint = try getPosition(xCordinate : startX  , yCordinate : startY + offset , board : board)
   let thirdPoint = try getPosition(xCordinate : startX  , yCordinate : startY + 2 * offset, board : board)
   answer = findSameColour(firstPoint : position , secondPoint : secondPoint , thirdPoint : thirdPoint , board : board)
  }    catch
   {
     return answer
   }

  return answer

}

public static func findSameColour(firstPoint : BoardPosition , secondPoint : BoardPosition , thirdPoint : BoardPosition , board : Board) -> Int
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
            if(firstPointColour == secondPointColour && secondPointColour == thirdPointColour && firstPointColour != BoardBoundElements.EMPTY_POSITION  )
            {
                 print("THIS ARE MILL LOL \(firstPoint.toString()) , \(secondPoint.toString()) , \(thirdPoint.toString()) ")
                  print("With colours \(firstPointColour) , \(secondPointColour) , \(thirdPointColour) ")
              return 1
            }
      }
    }
  }
  return 0
}






 

 



}