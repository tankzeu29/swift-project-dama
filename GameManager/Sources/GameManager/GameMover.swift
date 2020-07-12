
/* responsible  for the second phase in the game
 which is each player moving his pieces until the game ends
 */
import CoreGame
import GameExceptions
import GameMessages

public class GameMover : GamePhase
{
    
    private let NEEDED_PIECES_TO_FLY = 3
    
    public  init( gameBoard : Board , player1 : Player , player2 : Player)
    {
        
        super.init(board : gameBoard, player1 : player1 , player2 : player2)
        
    }
    
    /*
     starts the game
     */
    
    public func start()
    {
        
        print("Moving phase started!")
        
        let board = getBoard()
        var currentPlayer = getFirstPlayer()
        var oponent = getSecondPlayer()
        
        board.printBoard()
        
        
        while(true)
        {
            
            
            let currentState = shouldGameEnd(firstPlayer:currentPlayer, secondPlayer : oponent, board : board)
            if( currentState != EndGameState.IN_PROGRESS)
            {
                printWinner(winner : currentState)
                break;
            }
            
            board.printBoard()
            print(GameInputMessages.ENTER_INPUT_MOVE)
            print("\(currentPlayer.getColour()) turn")
            if let position = readLine() {
                
                do {
                    
                    try movePiece(position : position , currentPlayer : currentPlayer ,oponent : oponent , board : board)
                    let tempPlayer = currentPlayer
                    currentPlayer = oponent
                    oponent = tempPlayer
                    
                    
                    
                    
                    
                }
                catch NineMortisError.runtimeError(let errorMessage) {
                    print(errorMessage)
                }
                catch
                {
                    board.printBoard()
                    print(GameExceptionMessages.UNEXEPECTED_EXCEPTION)
                }
                
            }
            else
            {     board.printBoard()
                print(WrongInputMessages.ENTER_INPUT_AGAIN)
            }
            
            
        }
        
        
    }
    
    
    
    
    /* Moves a piece for a player on the board
     @param position - piece to be moved
     @param currentPlayer - the player moving the piece
     @param oponent - the oponent of the current player
     @param board - game board
     */
    public func movePiece(position : String , currentPlayer : Player , oponent : Player , board : Board) throws
    {
        let canCurrentPlayerFily = canPlayerFly(player : currentPlayer)
        
        
        
        try MovementValidator.validateMovement(position : position , board : board , currentPlayer : currentPlayer , oponent : oponent , canFly : canCurrentPlayerFily)
        
        
        let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:2) , board : board)
        board.removeAtPosition(point : startPosition)
        try board.setSinglePosition(positionCordinates : position.substring(from:2) , currentPlayer :currentPlayer , oponent : oponent  )
        
        currentPlayer.removePiece(position : startPosition)
        
        
        
    }
    /* Checks if player can Fly
     @param - player to check if he can move
     @return true if he can fly , else false
     */
    private func canPlayerFly(player : Player) -> Bool
    {
        return player.getTotalPieces() == NEEDED_PIECES_TO_FLY
    }
    
    /*
     * Check if the game should end by verifying if a player is blocked or has 2 pieces
     @param firstPlayer - first player of the game
     @param secondPlayer - second player of the game
     @param board - game board
     @return game state
     */
    private func shouldGameEnd(firstPlayer : Player , secondPlayer : Player , board : Board) -> EndGameState
    {
        let firstEnd = canMovePieces(currentPlayer : firstPlayer , board : board)
        let secondEnd = canMovePieces(currentPlayer : secondPlayer , board : board)
        
        
        
        
        if(!firstEnd)
        {
            return EndGameState.PLAYER2_WINNER
        }
        else if(!secondEnd)
        {
            return EndGameState.PLAYER1_WINNER
        }
        else
        {
            return EndGameState.IN_PROGRESS
        }
    }
    /* Checks if player can move his pieces
     @param currentPlayer - player to check if he can move
     @board - game board
     @return true if an move any of his pieces to adjacent location, else false
     */
    private func canMovePieces(currentPlayer : Player , board : Board) -> Bool
    {
        
        if(currentPlayer.getTotalPieces() <= 2)
        {
            
            return false
        }
        
        
        var canCurrentPlayerMove = false
        
        
        
        let currentPlayerPieces = currentPlayer.getPieces()
        
        for piece in currentPlayerPieces
        {
            let offset = BoardOffsetFinder.getOffset(position : piece, board : board)
            let xOffset = offset.xAnswer
            let yOffset = offset.yAnswer
            
            let isMovable = canPieceMove( position : piece , xOffset : xOffset , yOffset : yOffset , board : board)
            
            
            if(isMovable)
            {
                canCurrentPlayerMove = true
                break;
            }
        }
        
        return canCurrentPlayerMove
    }
    
    /* Checks if piece can move to any of the directions - top, bottom ,left, right
     by given offset for the cordinates
     @position - position to check if it can move
     @xOffset - axis offset to move
     @yOffset - ordinate offset to move
     @board - game board
     @return true if the piece is not blocked , else false
     */
    private func canPieceMove(position : BoardPosition ,xOffset : Int ,yOffset : Int ,board : Board) -> Bool
    {
        let startX = position.getX()
        let startY = position.getY()
        
        
        
        let topPosition  = BoardPosition(xCordinate : startX + xOffset ,yCordinate : startY)
        
        let bottomPosition  = BoardPosition(xCordinate : startX + xOffset ,yCordinate : startY)
        let leftPosition  = BoardPosition(xCordinate : startX  ,yCordinate : startY - yOffset)
        let rightPosition  = BoardPosition(xCordinate : startX  ,yCordinate : startY + yOffset)
        
        
        let canMove = board.isPositionEmpty(position : topPosition) ||
            board.isPositionEmpty(position : bottomPosition) ||
            board.isPositionEmpty(position : leftPosition) ||
            board.isPositionEmpty(position : rightPosition)
        
        return canMove
        
    }
    
    /* Prints the winner of the game
     @param winner - the state of the game moving phase
     */
    public func printWinner(winner : EndGameState)
    {
        if (winner == EndGameState.PLAYER1_WINNER)
        {
            print(GameResultMessages.PLAYER1_WON)
        }
        else if (winner == EndGameState.PLAYER2_WINNER)
        {
            print(GameResultMessages.PLAYER2_WON)
        }
        else
        {
            print(GameResultMessages.UNDETERMINED_WINNER)
        }
        
    }
    
    
    
    
}

