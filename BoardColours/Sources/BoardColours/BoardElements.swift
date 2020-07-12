
/*
 * All possible board cell colours
 */
import GameExceptions
public class BoardElements
{
    
    public static let HORIZONTAL_LINE = "-"
    public static let VERTICAL_LINE = "|"
    public static let EMPTY_POSITION = "."
    public static let ILLEGAL_POSITION = " "
    public static let WHITE_FIGURE = "○"
    public  static let BLACK_FIGURE = "●"
    
    
    public static func getEmptyPositionSymbol() -> String
    {
        return EMPTY_POSITION
    }
    
    /*
     * Retrieves the oponent colour
     * @param colour - colour of a player
     @return the opposite colour for 2 player game
     */
    public static func getOponentColour(colour : String) throws -> String
    {
        if( colour.isEmpty)
        {
            throw NineMortisError.runtimeError("Empty colour - \(colour)")
        }
        else if( colour == BoardElements.WHITE_FIGURE)
        {
            return BoardElements.BLACK_FIGURE
        }
        else if( colour == BoardElements.BLACK_FIGURE)
        {
            return BoardElements.WHITE_FIGURE
        }
        else
        {
            throw NineMortisError.runtimeError("Undefined colour - \(colour)")
        }
    }
    
    
    
    
    
}
