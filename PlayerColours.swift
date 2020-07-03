


class PlayerColours
{

  static let WHITE_FIGURE = "○"
  static let BLACK_FIGURE = "●"

  static func getColour ( colour : PieceColour) -> String
  {
    if(colour == PieceColour.WHITE)
    {
      return WHITE_FIGURE
    }
    else
    {
      return BLACK_FIGURE
    }
  }

  static func convertToPlayerColour ( colour : String) -> PieceColour
  {
    if(colour == WHITE_FIGURE)
    {
      return PieceColour.WHITE
    }
    else
    {
      return PieceColour.BLACK
    }
  }








  
}