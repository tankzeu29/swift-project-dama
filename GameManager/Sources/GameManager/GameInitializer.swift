
/*
 Initializes the first
 phase which is each player to put
 figures on the board
 */

import CoreGame
import GameExceptions
import GameMessages

public class GameInitializer : GamePhase
{
    
    /*total pieces for both players to put */
    private let totalFiguresToPlace = 18
    
    public init( gameBoard : Board , player1 : Player , player2 : Player)
    {
        
        super.init(board : gameBoard , player1 : player1 , player2 : player2)
        
    }
    
    /* starts the first phase */
    
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
                let  secondPlayerColour = try BoardElements.getOponentColour(colour : firstPlayerColour)
                secondPlayer.setColour(colour : secondPlayerColour)
                
                break;
                
            } catch NineMortisError.runtimeError(let errorMessage) {
                board.printBoard()
                print(errorMessage)
                
                
            }
            catch
            {     board.printBoard()
                print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
            }
            
            
        }
        
        var placedFigures = 0
        
        
        
        
        while(true) {
            
            
            if( placedFigures >= totalFiguresToPlace)
            {
                break;
            }
            
            
            board.printBoard()
            print(GameInputMessages.ENTER_INPUT)
            print("\(currentPlayer.getColour()) turn")
            if let playerInput = readLine() {
                do {
                    
                    
                    
                    
                    try board.setSinglePosition(positionCordinates : playerInput , currentPlayer : currentPlayer , oponent: oponent )
                    
                    placedFigures = placedFigures + 1
                    
                    
                    //swap players
                    let tempPlayer = currentPlayer
                    currentPlayer = oponent
                    oponent = tempPlayer
                    
                    
                    
                    
                    
                    
                    
                    print("Total placed figures \(placedFigures)")
                    
                } catch NineMortisError.runtimeError(let errorMessage) {
                    board.printBoard()
                    print(errorMessage)
                    
                    
                }
                catch
                {    board.printBoard()
                    print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
                    
                }
                
                
            } else {
                board.printBoard()
                print(WrongInputMessages.ENTER_INPUT_AGAIN)
            }
            
            
        }
        
        
        setFirstPlayer(firstPlayer : firstPlayer)
        setSecondPlayer(secondPlayer : secondPlayer)
        
    }
    
    /* parses choice for player colour
     * @arg number - the choice of colour
     @return chosen colour to play with
     */
    private func  parseColourNumber(number : String)  throws -> String
    {
        if let playerChoice = Int(number) {
            
            if( playerChoice == 1)
            {
                return BoardElements.BLACK_FIGURE
            }
            else if(playerChoice == 2)
            {
                return BoardElements.WHITE_FIGURE
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
    
    
    
    
    
    
}
