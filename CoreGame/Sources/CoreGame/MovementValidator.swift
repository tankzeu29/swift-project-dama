/*Validates if movement of a piece is correct in the move phase*/

import GameExceptions

public class MovementValidator
{
    
    
    private static let MOVEMENT_ARGUMENTS = 4
    private static let MOVEMENT_MIDDLE_POSITION = 2
    
    
    
    
    public static func validateMovement(position : String , board : Board , currentPlayer : Player, oponent : Player , canFly : Bool ) throws
    {
        
        
        
        
        guard position.count == MOVEMENT_ARGUMENTS else {
            throw NineMortisError.runtimeError("Illegal number of paramters \(position.count). It must be \(MOVEMENT_ARGUMENTS)")
        }
        
        
        try board.validateSinglePosition(position : position.substring(to:2) )
        try board.validateSinglePosition(position : position.substring(from:2) )
        
        let startPosition = try PositionParser.getPositionFromString(position : position.substring(to:MOVEMENT_MIDDLE_POSITION) , board : board)
        let endPosition =  try PositionParser.getPositionFromString(position : position.substring(from:MOVEMENT_MIDDLE_POSITION) , board : board)
        
        let arePositionsAdj = arePositionsAdjacent(startPosition : startPosition , endPosition :endPosition , board : board)
        
        
        guard startPosition.getColour() == currentPlayer.getColour() else {
            throw NineMortisError.runtimeError("Piece to move \(startPosition.toString()) is not your colour")
        }
        if ( endPosition.getColour() != BoardElements.EMPTY_POSITION ) {
            throw NineMortisError.runtimeError("The position \(endPosition.toString()) is not empty position")
        }
        
        let isNormalMoveFlyingMove = !canFly && !arePositionsAdj
        
        if ( isNormalMoveFlyingMove )
        {
            throw NineMortisError.runtimeError("Positions \(startPosition.toString()) and \(endPosition.toString()) Must  be adjacent  because you CANNOT fly ")
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    /* Validate if 2 positions are adjacent by checking all possible cases - left,right ,top ,bottom
     @param startPosition - the position we try to move from
     @parma endPosition - destination position
     @return true if they are adjacent , else false
     */
    
    public static func arePositionsAdjacent(startPosition : BoardPosition ,endPosition: BoardPosition, board : Board) -> Bool
    {
        
        
        let offset = BoardOffsetFinder.getOffset(position : startPosition , board : board)
        let startX = startPosition.getX()
        let startY = startPosition.getY()
        let xOffset = offset.xAnswer
        let yOffset = offset.yAnswer
        
        
        let isAdjacent = vlaidateAdjHelper(endPosition : endPosition ,startX :startX + xOffset , startY: startY ,board : board ) ||
            vlaidateAdjHelper(endPosition : endPosition , startX :startX - xOffset ,startY: startY , board : board ) ||
            vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY + yOffset ,board : board) ||
            vlaidateAdjHelper(endPosition : endPosition ,startX :startX , startY: startY - yOffset, board : board)
        
        return isAdjacent
        
        
    }
    
    
    /* Validate if there is adjacent position for specific offset
     @param endPosition - destination position
     @param startX - axis cordinate of possible adjacent cell
     @param startY - ordinate cordinate of possible adjacent cell
     @return true if they are adjacent , else false
     */
    
    public static func vlaidateAdjHelper(endPosition : BoardPosition , startX :Int , startY : Int , board : Board) -> Bool
    {
        let positionExist = board.isPointExisting(xCordinate :startX ,yCordinate: startY )
        if(positionExist)
        {
            return endPosition.getX() == startX && endPosition.getY() == startY
        }
        return false
        
    }
    
    
    
    
    
}
