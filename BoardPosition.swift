

public class BoardPosition : Equatable
{

 private var xCordinate : Int
 
 
 private var yCordinate : Int
 private var colour : PieceColour

 init()
 {
   xCordinate = 0
   yCordinate = 0
   colour = PieceColour.WHITE
 }

  init (xCordinate : Int, yCordinate : Int )
 {
   self.xCordinate = xCordinate
   self.yCordinate = yCordinate
   self.colour = PieceColour.WHITE
 }


 convenience init (xCordinate : Int, yCordinate : Int , colour : PieceColour)
 {
    self.init(xCordinate : xCordinate , yCordinate : yCordinate)
   self.colour = colour
 }


 func getX() -> Int
 {
   return xCordinate
 }

 func getY() -> Int
 {
   return yCordinate
 }
 
 func getColour() -> PieceColour
 {
   return colour
 }

 func setColour(colour : PieceColour)
 {
   self.colour = colour
 }
 func info()
 {
   print("\(xCordinate) \(yCordinate)")
 }

 func toString() -> String 
 {
   return "[\(xCordinate),\(yCordinate),\(colour)] "
 }

   public func equalTo(rhs: BoardPosition) -> Bool {
       return getX() == rhs.getX() && getY() == rhs.getY() && getColour() == rhs.getColour()
    }

 public static func ==(lhs: BoardPosition, rhs: BoardPosition) -> Bool {
        return lhs.getX() == rhs.getX() && lhs.getY() == rhs.getY() && lhs.getColour() == rhs.getColour()
    }

}
