import XCTest
@testable import GameExceptions

final class GameExceptionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GameExceptions().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
