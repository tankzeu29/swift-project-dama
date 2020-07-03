

class GameInitializer : GamePhase
{

 private let totalFiguresToPlace = 18
 
init( gameBoard : Board , player1 : Player , player2 : Player)
{
   
    super.init(board : gameBoard , player1 : player1 , player2 : player2)

}


func start()
{



    let firstPlayer = getFirstPlayer()
    let secondPlayer = getSecondPlayer() 
    var currentPlayer = firstPlayer
    var oponent = secondPlayer




    





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
          print("Something bad")
      }


    }

  var placedFigures = 19 //no hack must be 0


        //hacks
    
    let hacks = ["A1","G1","A7" ,"G7","B4","F4"]
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

 print("Enter parametrs to put figure on the board:")
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
      print(errorMessage)
   
      }
      catch
      {
          print("Very bad")
      }
         board.printBoard()

  } else {
      print("Enter again details")
}


  }


  print("END OF INITIALIZATION \(firstPlayer.info()) , \(secondPlayer.info())")
  setFirstPlayer(firstPlayer : firstPlayer)
  setSecondPlayer(secondPlayer : secondPlayer)

}

 
 func  parseColourNumber(number : String)  throws -> PieceColour
 {
    if let playerChoice = Int(number) {
          
      if( playerChoice == 1)
      {
        return PieceColour.BLACK
      }
      else if(playerChoice == 2)
      {
        return PieceColour.WHITE
      }
      else
      {
        throw NineMortisError.runtimeError("Illegal number \(playerChoice)")
      }
    }
    else
    {
       throw NineMortisError.runtimeError("Input not integer \(number)")
    }


 
 }

 private func getOponentColour(colour : PieceColour) -> PieceColour
 {
   if( colour == PieceColour.WHITE)
   {
     return PieceColour.BLACK
   }
   else
   {
     return PieceColour.WHITE
   }
 }



  

}