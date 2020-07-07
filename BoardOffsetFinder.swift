
class BoardOffsetFinder
{

public static func getOffset(position : BoardPosition , board : Board) -> (first :Int , second :Int)
{


  let pointX = position.getX()
  let pointY = position.getY()


  var yAnswer = 0
  var xAnswer = 0


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

private static func findXOffset(pointY : Int , matrixLength : Int , matrixWidth : Int) -> Int
{
  var xAnswer = 0
    var difference = abs( ( (matrixLength ) / 2 - pointY) )
  let singlePieceOfWidth = (matrixWidth - 1) / 6 
  difference = difference / 4
 // print("X difference \(difference)")
  if( difference == 0 )
  {
 //     print("X case_0")
    xAnswer = singlePieceOfWidth //2
  }
  else if(difference  == 3)
  {  //print("X case_3")
      xAnswer =  (matrixWidth - 1) / 2
  }
  else if( difference == 2){
     xAnswer = singlePieceOfWidth * 2  //4
    //  print("X case_2")
}
else
{  //  print("X case_1")
     xAnswer =  singlePieceOfWidth
}

return xAnswer
}


}