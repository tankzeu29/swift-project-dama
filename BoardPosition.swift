

public class BoardPosition : Equatable
{

 private var xCordinate : Int
 private var yCordinate : Int
 private var colour : PieceColour

 public init()
 {
   xCordinate = 0
   yCordinate = 0
   colour = PieceColour.WHITE
 }

 public  init (xCordinate : Int, yCordinate : Int )
 {
   self.xCordinate = xCordinate
   self.yCordinate = yCordinate
   self.colour = PieceColour.WHITE
 }


 public convenience init (xCordinate : Int, yCordinate : Int , colour : PieceColour)
 {
    self.init(xCordinate : xCordinate , yCordinate : yCordinate)
   self.colour = colour
 }


public  func getX() -> Int
 {
   return xCordinate
 }

 public func getY() -> Int
 {
   return yCordinate
 }
 
 public func getColour() -> PieceColour
 {
   return colour
 }

 public func setColour(colour : PieceColour)
 {
   self.colour = colour
 }
public  func info()
 {
   print("\(xCordinate) \(yCordinate)")
 }

 public func toString() -> String 
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
