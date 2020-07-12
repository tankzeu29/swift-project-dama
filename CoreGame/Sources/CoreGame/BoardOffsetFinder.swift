
/*
 * Finds for a point the distance to its neightbours
 * on the axis and ordinate
 */
public class BoardOffsetFinder
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
     * Finds the distance for a point to his ordinate neightbours
     * The algorithm is :
     1.find the difference between the middle of the matrix length and the cordinate X
     2. substract them in module and then divide by the respective number of cells
     3. the result is number from 0-3 which will tell us the offset
     * @param matrixLength - length of the board
     @param matrixWidth - width of the board
     @param pointX - the game board
     @return - returns axis distance to his neightbours
     */
    private static func findYOffset(pointX : Int , matrixLength : Int , matrixWidth : Int) -> Int
        
    {
        
        var yAnswer = 0;
        var difference =  abs ( ((matrixWidth ) / 2) - pointX )
        
        let singlePieceOfLength = (matrixLength - 1) / 6
        let offset =  (matrixWidth - 1) / 6
        difference = difference / offset
        
        
        yAnswer = findOffsetHelper(difference : difference , boardSide : matrixLength , boardSidePiece : singlePieceOfLength)
        return yAnswer
        
    }
    /*
     * Finds the distance for a point to his axis neightbours
     * The algorithm is :
     1.find the difference between the middle of the matrix width and the cordinate
     2. substract them in module and then divide by the respective number of cells
     3. the result is number from 0-3 which will tell us the offset
     * @param matrixLength - length of the board
     @param matrixWidth - width of the board
     @param pointXY - the game board
     @return - returns axis distance to his neightbours
     */
    private static func findXOffset(pointY : Int , matrixLength : Int , matrixWidth : Int) -> Int
    {
        var xAnswer = 0
        var difference = abs( ( (matrixLength - 1 ) / 2 - pointY) )
        let singlePieceOfWidth = (matrixWidth - 1) / 6
        let offset = (matrixLength - 1) / 6
        difference = difference / offset
        
        
        xAnswer = findOffsetHelper(difference : difference , boardSide : matrixWidth , boardSidePiece : singlePieceOfWidth)
        return xAnswer
        
        
        
    }
    
    /*
     * Calculates axis or ordinate distance to the next cell
     
     @param difference - the difference between the point and a middle axis divided by modulo cells - always a number in the interval [0;3]
     @param boardSide - board side size
     @param boardSidePiece - board side size between two numbers or letters
     */
    private static func findOffsetHelper(difference : Int , boardSide : Int , boardSidePiece : Int) -> Int
    {
        var answer = 0
        if( difference == 0 )
        {
            
            answer = boardSidePiece
        }
        else if(difference  == 3)
        {
            answer =  (boardSide - 1) / 2
        }
        else if( difference == 2){
            answer = boardSidePiece * 2
            
        }
        else
        {  
            answer =  boardSidePiece
        }
        return answer
    }
    
}
