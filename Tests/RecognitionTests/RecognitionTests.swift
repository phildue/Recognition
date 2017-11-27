import XCTest
@testable import Recognition

class RecognitionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Recognition().text, "Hello, World!")
    }


    static var allTests : [(String, (RecognitionTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
