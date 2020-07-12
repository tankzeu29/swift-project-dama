import XCTest
@testable import CoreGame

final class CoreGameTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CoreGame().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
