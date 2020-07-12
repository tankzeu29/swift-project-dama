

public class BoardPosition : Equatable
{
    
    private var xCordinate : Int
    private var yCordinate : Int
    private var colour : String
    
    public init()
    {
        xCordinate = 0
        yCordinate = 0
        colour = BoardElements.WHITE_FIGURE
    }
    
    public  init (xCordinate : Int, yCordinate : Int )
    {
        self.xCordinate = xCordinate
        self.yCordinate = yCordinate
        self.colour = BoardElements.WHITE_FIGURE
    }
    
    
    public convenience init (xCordinate : Int, yCordinate : Int , colour : String)
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
    
    public func getColour() -> String
    {
        return colour
    }
    
    public func setColour(colour : String)
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
