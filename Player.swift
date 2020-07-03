

class Player
{

  var piecesColour = PieceColour.WHITE
  var state = PlayerMoveState.FREE
  var currentPieces = [BoardPosition]()
  init()
  {

  }
  init(colour : PieceColour)
  {
    self.piecesColour = colour
  }
  init(pieces : Int , colour : PieceColour)
  {
    self.piecesColour = colour
 
  }

func  getPieces() -> [BoardPosition]
  {
    return currentPieces
  }

  func  addPiece( position : BoardPosition)
  {
    currentPieces.append(position)
  }
    func  removePiece( position : BoardPosition)
  {
      print("To remove \(position.toString())")

      currentPieces = currentPieces.filter() { $0 != position }
    
  }

  func getTotalPieces() -> Int
  {
    return currentPieces.count
  }

  

  

  func getColour() -> PieceColour
  {
    return piecesColour
  }

  func setColour(colour : PieceColour)
  {
    piecesColour = colour
  }

  func info() -> String
  {
   var playerInfo = "Available pieces : \(currentPieces.count) , colour : \(piecesColour) \n "
   for piece in currentPieces
   {
     playerInfo += piece.toString() + " "
   }
   return playerInfo
  }
}