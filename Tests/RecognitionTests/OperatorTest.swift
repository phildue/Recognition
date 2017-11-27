import XCTest


@testable import Recognition
class OperatorTest: XCTestCase {
    
    func testEqInt(){
        let A = Matrix([[1, 2],[3, 4]])
        XCTAssertTrue(A==A)
    }

    func testEqDouble(){
        let A = Matrix([[1, 2],[3, 4]])
        XCTAssertTrue(A==A)
    }

    func testEquals(){
        let A = Matrix([[1, 2],[3, 4]])
        XCTAssertTrue(equals(A,A,within:0.1))
    }

    func testNotEquals(){
        let A = Matrix([[1, 2],[3, 4]])
        let B = Matrix([[1, 2.2],[3, 4]])

        XCTAssertFalse(equals(A,B,within:0.1))
    }

    func testDiv(){
        let A = Matrix([[2, 2],[4, 4]])
        let B = Matrix([[1, 1],[2, 2]])
        XCTAssertTrue((A/2)==B)

    }

    func testMul(){
        let A = Matrix([[2, 2],[4, 4]])
        let B = Matrix([[1, 1],[2, 2]])
        XCTAssertTrue(A==(B*2))

    }

    static var allTests : [(String, (OperatorTest) -> () throws -> Void)] {
        return [
            ("testEqInt",testEqInt),
            ("testEqDouble",testEqDouble),
            ("testEquals",testEquals),
            ("testNotEquals",testEquals),
            ("testDiv",testDiv),
            ("testMul",testMul),
        ]
    }
}
