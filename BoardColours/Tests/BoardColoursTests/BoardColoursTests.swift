import XCTest
@testable import BoardColours

final class BoardColoursTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BoardColours().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
