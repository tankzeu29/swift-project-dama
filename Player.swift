

public class Player
{

  var piecesColour = BoardBoundElements.WHITE_FIGURE
  var state = PlayerMoveState.FREE
  var currentPieces = [BoardPosition]()
  init()
  {

  }
  public init(colour : String)
  {
    self.piecesColour = colour
  }
 public  init(pieces : Int , colour : String)
  {
    self.piecesColour = colour
 
  }

public func  getPieces() -> [BoardPosition]
  {
    return currentPieces
  }

 public  func  addPiece( position : BoardPosition)
  {
    currentPieces.append(position)
  }
  public   func  removePiece( position : BoardPosition)
  {
      print("To remove \(position.toString())")

      currentPieces = currentPieces.filter() { $0 != position }
    
  }

  public func getTotalPieces() -> Int
  {
    return currentPieces.count
  }

  

  

 public  func getColour() -> String
  {
    return piecesColour
  }

 public  func setColour(colour : String)
  {
    piecesColour = colour
  }

  public func info() -> String
  {
   var playerInfo = "Available pieces : \(currentPieces.count) , colour : \(piecesColour) \n "
   for piece in currentPieces
   {
     playerInfo += piece.toString() + " "
   }
   return playerInfo
  }
}