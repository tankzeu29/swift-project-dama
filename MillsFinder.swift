
/* finds the total mills for particular position
*/
class MillsFinder
{







/* Find the total mills for a position
@position - the position to find with which mills it participate
@board - game board
@return - total mills the position is participating
*/
public static func findMills(position : BoardPosition , board : Board) -> Int
{


  let tuple = BoardOffsetFinder.getOffset(position : position , board : board)
 
  let destinationToCenterX = tuple.xAnswer


  let destinationToCenterY = tuple.yAnswer



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





/* Finds all mills for which a point is the center of the mill.
@position - the position to find with which mills it participate
@offset - distance to the next points 
@board - incrementX - if true finds axis mills , else ordinate 
@return - total mills the position is participating
*/
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

    
       secondPoint = try PositionParser.getPosition(xCordinate : secondPointValue , yCordinate : startY , board :board )
       thirdPoint = try  PositionParser.getPosition(xCordinate : thirdPointValue , yCordinate :startY, board :board ) 
      

  }
  else
  {   
      secondPoint = try  PositionParser.getPosition(xCordinate : startX , yCordinate : secondPointValue , board :board )
       thirdPoint = try  PositionParser.getPosition(xCordinate : startX , yCordinate : thirdPointValue , board :board ) 
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

/* Finds all parallel axis mills for which a point is Not center of the mill.
@position - the position to find with which mills it participate
@offset - distance to the next points 
@board - incrementX - if true finds axis mills , else ordinate 
@return - total mills the position is participating
*/
public static func findAdjAxisMills(position : BoardPosition , offset : Int , board : Board) -> Int
{
  let startX = position.getX()
  let startY = position.getY()
  var answer = 0
 do{
   let secondPoint = try  PositionParser.getPosition(xCordinate : startX + offset , yCordinate : startY , board : board)
   let thirdPoint = try  PositionParser.getPosition(xCordinate : startX + 2 * offset , yCordinate : startY, board : board)
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
   let secondPoint = try  PositionParser.getPosition(xCordinate : startX  , yCordinate : startY + offset , board : board)
   let thirdPoint = try  PositionParser.getPosition(xCordinate : startX  , yCordinate : startY + 2 * offset, board : board)
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

              return 1
            }
      }
    }
  }
  return 0
}
}