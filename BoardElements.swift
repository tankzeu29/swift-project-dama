
/*
* All possible board cell colours
*/
public class BoardBoundElements
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

  
  


}