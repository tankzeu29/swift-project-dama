
/*
* Finds for a point the distance to his neightbours
* on the axis and ordinate
*/
class BoardOffsetFinder
{

/*
* Returns pair in the form (x,y) representing x the distance to his
* ordinate neighbours and y the distance to his axis neightbours
* @param position - position on the board to find offset
  @param board - the game board
  @return - offset in the form (x,y) as a pair
*/
public static func getOffset(position : BoardPosition , board : Board) -> (xAnswer :Int , yAnswer :Int)
{


  let pointX = position.getX()
  let pointY = position.getY()


  var yAnswer = 0
  var xAnswer = 0


   let matrixLength = board.getLength() 
   let matrixWidth = board.getWidth() 
 
  yAnswer = findYOffset(pointX : pointX , matrixLength : matrixLength , matrixWidth : matrixWidth)

  
  
  xAnswer = findXOffset(pointY : pointY , matrixLength : matrixLength , matrixWidth : matrixWidth)


  return (xAnswer,yAnswer)

}


/*
* Finds the distance for a point to his axis neightbours
* @param matrixLength - length of the board 
 @param matrixWidth - width of the board 
  @param pointX - the game board
  @return - returns axis distance to his neightbours
*/
private static func findYOffset(pointX : Int , matrixLength : Int , matrixWidth : Int) -> Int

{

  var yAnswer = 0;
      let difference =  abs ( ((matrixWidth ) / 2) - pointX )

      let singlePieceOfLength = (matrixLength - 1) / 6 
if(difference == 0)
{
  yAnswer = singlePieceOfLength  //4
}
else if(difference == 6 )
{
  yAnswer = (matrixLength - 1) / 2
}
else if (difference == 4)
{
  yAnswer = 2 * singlePieceOfLength // 8
}
else 
{
  yAnswer =  singlePieceOfLength //4
}


return yAnswer

}
/*
* Finds the distance for a point to his ordinate neightbours
* @param matrixLength - length of the board 
 @param matrixWidth - width of the board 
  @param pointXY - the game board
  @return - returns ordinate distance to his neightbours
*/
private static func findXOffset(pointY : Int , matrixLength : Int , matrixWidth : Int) -> Int
{
  var xAnswer = 0
    var difference = abs( ( (matrixLength ) / 2 - pointY) )
  let singlePieceOfWidth = (matrixWidth - 1) / 6 
  difference = difference / 4

  if( difference == 0 )
  {

    xAnswer = singlePieceOfWidth //2
  }
  else if(difference  == 3)
  {  
      xAnswer =  (matrixWidth - 1) / 2
  }
  else if( difference == 2){
     xAnswer = singlePieceOfWidth * 2  //4
 
}
else
{  
     xAnswer =  singlePieceOfWidth
}

return xAnswer
}


}