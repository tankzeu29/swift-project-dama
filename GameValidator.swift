

public class GameValidator
{

  var board : Board
  private  let allowedLetters: [Character] = ("A"..."G").characters
 private  let allowedNumbers  : [Character] = ("1"..."7").characters

public init(board : Board)
{
  self.board = board
}


 public  func validateSinglePosition(position : String , board : Board) throws
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

     public  func validateSinglePosition(position : BoardPosition, board : Board) throws
  {




    let x = position.getX()
    let y = position.getY()

    guard board.isPointExisting(xCordinate : x , yCordinate : y) else {
            throw NineMortisError.runtimeError("Position you have entered \(position.toString()) does not exist")
        }

  }

 public   func validatePositionLocation(xCordinate : Character , yCordinate : Character) throws
  {

    guard xCordinate.isLetter else {
          throw NineMortisError.runtimeError("First symbol -  \(xCordinate) ,is not a letter")
        }

    guard yCordinate.isNumber else {
         throw NineMortisError.runtimeError("Second symbol \(yCordinate) is not a number")
        }




  }


    public  func isPositionExisting( xCordinate : Character , yCordinate : Character , matX : Int, matY : Int , board :Board) throws
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
     
        guard board.isPointExisting(xCordinate : x , yCordinate : y) 
        else
        { 
           throw NineMortisError.runtimeError("Position does not exist \(xCordinate)\(yCordinate)")
        }


        
  }


}