import XCTest
@testable import GameMessages

final class GameMessagesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GameMessages().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
