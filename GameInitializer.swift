

public class GameInitializer : GamePhase
{

 private let totalFiguresToPlace = 18
 
public init( gameBoard : Board , player1 : Player , player2 : Player)
{
   
    super.init(board : gameBoard , player1 : player1 , player2 : player2)

}


public func start()
{



    let firstPlayer = getFirstPlayer()
    let secondPlayer = getSecondPlayer() 
    var currentPlayer = firstPlayer
    var oponent = secondPlayer




    




    let board = getBoard()
   board.printBoard()
    while(true)
    {
          print("Choose 1 for black or 2 for white figures")
          let chooseColour = readLine()
          do {

          
          let  firstPlayerColour = try parseColourNumber(number : chooseColour!)
         firstPlayer.setColour(colour : firstPlayerColour)
        let  secondPlayerColour = getOponentColour(colour : firstPlayerColour)
        secondPlayer.setColour(colour : secondPlayerColour)

         break;
      
            } catch NineMortisError.runtimeError(let errorMessage) {
                  print(errorMessage)
                

      }
      catch
      {
          print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
      }

        board.printBoard()
    }

 var placedFigures = 19 //no hack must be 0


   let hacks = ["G1","B2","A1","C4","A4","B6","G4"]
     // let hacks = ["A1","A4","A7","D7","G7","G4","G1","D1"]

  //   let hacks = ["A1","A4","A7","D7","G7","G4","G1","D1","C5","D5","E5","E4","E3","D3","C3","C4","B4","D2","F4","D6"]
    for playerInput in hacks
    {
      do{
          try board.setSinglePosition(positionCordinates : playerInput , currentPlayer : currentPlayer , oponent: oponent , isMovement : true)


      let tempPlayer = currentPlayer
       currentPlayer = oponent
      oponent = tempPlayer

       } catch NineMortisError.runtimeError(let errorMessage) {
     print(errorMessage)

      }
      catch
      {
          print("Very bad")
      }
    }


        for playerInput in hacks
    {
      do{
          try board.setSinglePosition(positionCordinates : playerInput , currentPlayer : currentPlayer , oponent: oponent , isMovement : true)


      let tempPlayer = currentPlayer
       currentPlayer = oponent
      oponent = tempPlayer

       } catch NineMortisError.runtimeError(let errorMessage) {
     print(errorMessage)

      }
      catch
      {
          print("Very bad")
      }
    }
      board.printBoard()
  
    

 
  while(true) {

  
      if( placedFigures >= totalFiguresToPlace)
      {
        break;
      }

      board.printBoard()

 print(IngameMessages.ENTER_INPUT_PLACE)
  print("\(currentPlayer.getColour()) turn")
 if let playerInput = readLine() {
      do {
      print("Enter Position to move , steps \(placedFigures) ")
      print("Current : \(currentPlayer.info())")
      print("Oponent : \(oponent.info())")


      try board.setSinglePosition(positionCordinates : playerInput , currentPlayer : currentPlayer , oponent: oponent , isMovement : true)
    
      placedFigures = placedFigures + 1


      //swap
      let tempPlayer = currentPlayer
       currentPlayer = oponent
      oponent = tempPlayer





     
      print(currentPlayer.info())
      print(oponent.info())
      print("Placed figures \(placedFigures)")


      } catch NineMortisError.runtimeError(let errorMessage) {
       board.printBoard()
      print(errorMessage)
       print(IngameMessages.ENTER_INPUT_AGAIN)
   
      }
      catch
      {    board.printBoard()
          print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
           print(IngameMessages.ENTER_INPUT_AGAIN)
      }
       

  } else {
     board.printBoard()
      print(IngameMessages.ENTER_INPUT_AGAIN)
}

    
  }


  print("END OF INITIALIZATION \(firstPlayer.info()) , \(secondPlayer.info())")
  setFirstPlayer(firstPlayer : firstPlayer)
  setSecondPlayer(secondPlayer : secondPlayer)

}

 
private func  parseColourNumber(number : String)  throws -> String
 {
    if let playerChoice = Int(number) {
          
      if( playerChoice == 1)
      {
        return BoardBoundElements.BLACK_FIGURE
      }
      else if(playerChoice == 2)
      {
        return BoardBoundElements.WHITE_FIGURE
      }
      else
      {
        throw NineMortisError.runtimeError("Illegal number - \(playerChoice)")
      }
    }
    else
    {
       throw NineMortisError.runtimeError("Input not integer - \(number)")
    }


 
 }

 private func getOponentColour(colour : String) -> String
 {
   if( colour == BoardBoundElements.WHITE_FIGURE)
   {
     return BoardBoundElements.BLACK_FIGURE
   }
   else
   {
     return BoardBoundElements.WHITE_FIGURE
   }
 }



  

}