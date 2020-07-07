

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
   try board.validateSinglePosition(position : position )

     let colour = board.getPositionColour(x : xCordinate , y : yCordinate)

  

    return BoardPosition(xCordinate : xCordinate , yCordinate : yCordinate , colour : colour)

}

public static func getPositionFromString(position : String, board : Board) throws -> BoardPosition
{
   try board.validateSinglePosition(position : position )

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










 

 



}