import XCTest

@testable import Recognition

class MatrixTest: XCTestCase {
    
    func testInit(){
        _ = Matrix([[1,2],[3,4]])
        XCTAssertTrue(true)
    }

    func testSubscript(){
        let matrix = Matrix([[1,2],[3,4]])
    	XCTAssertTrue(matrix[0,0] == 1)
        XCTAssertTrue(matrix[0,1] == 2)
        XCTAssertTrue(matrix[1,0] == 3)
        XCTAssertTrue(matrix[1,1] == 4)

    }

    func testSubscriptSet(){
        var matrix = Matrix([[1,2],[3,4]])
        matrix[0,0] = 0
        matrix[0,1] = 0 
        XCTAssertTrue(matrix[0,0] == 0)
        XCTAssertTrue(matrix[0,1] == 0)
        XCTAssertTrue(matrix[1,0] == 3)
        XCTAssertTrue(matrix[1,1] == 4)

    }

    func testSubscriptRow(){
        let matrix = Matrix([[1,2],[3,4]])
        let row1 = matrix[0]
        let row2 = matrix[1]

        XCTAssertEqual(row1[0,0],1)
        XCTAssertEqual(row1[0,1],2)
        XCTAssertEqual(row2[0,0],3)
        XCTAssertEqual(row2[0,1],4)
        
    }


    func testRowsCols(){
        let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
        XCTAssertEqual(matrix.rows,3)
        XCTAssertEqual(matrix.columns,2)

        
    }

    func testEquals(){
        let matrix1 = Matrix([[1,2],[3,4],[5,6]])
        let matrix2 = Matrix([[1,2],[3,4],[5,6]])
        XCTAssertEqual(matrix1,matrix2)
    }

    func testNotEquals(){
        let matrix1 = Matrix([[1,2],[3,4],[5,6]])
        let matrix2 = Matrix([[1,2],[3,5],[5,6]])
        XCTAssertTrue(matrix1 != matrix2)
    }

    func testSubscriptRangeGet(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         let row1 = matrix[0,0 ..< matrix.columns]

         XCTAssertEqual(row1,Matrix([[1,2]]))
    }

    func testSubscriptRangeSet(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         matrix[0,0 ..< matrix.columns] = Matrix([[0,0]])

         XCTAssertEqual(matrix,Matrix([ [0,0],
                                        [3,4],
                                        [5,6]]))
    }
    func testSubscriptRangeGet2(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         let row1 = matrix[1,0 ..< matrix.columns]

         XCTAssertEqual(row1,Matrix([[3,4]]))
    }

    func testSubscriptRangeSet2(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         matrix[1,0 ..< matrix.columns] = Matrix([[0,0]])

         XCTAssertEqual(matrix,Matrix([ [1,2],
                                        [0,0],
                                        [5,6]]))
    }

    func testSubscriptRowRangeSet(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         matrix[1 ..< 3] = Matrix([[0,0],[0,0]])

         XCTAssertEqual(matrix,Matrix([ [1,2],
                                        [0,0],
                                        [0,0]]))   
    }

    func testSubscriptColumnRangeGet(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         let row1 = matrix[0 ..< matrix.columns,0]

         XCTAssertEqual(row1,Matrix([[1],
                                     [3],
                                     [5]]))
    }

    func testSubscriptColumnRangeSet(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         matrix[0 ..< matrix.rows,0] = Matrix([[0],
                                                  [0],
                                                  [0]])

         XCTAssertEqual(matrix,Matrix([ [0,2],
                                        [0,4],
                                        [0,6]]))
    }
    func testSubscriptColumnRangeGet2(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         let row1 = matrix[0 ..< matrix.rows,1]

         XCTAssertEqual(row1,Matrix([[2],
                                     [4],
                                     [6]]))
    }

    func testSubscriptColumnRangeSet2(){
         let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])
         matrix[0 ..< matrix.rows,1] = Matrix([[0],
                                                  [0],
                                                  [0]])

         XCTAssertEqual(matrix,Matrix([ [1,0],
                                        [3,0],
                                        [5,0]]))
    }

    func testSubscriptList(){
        let matrix = Matrix([[1,2],
                             [3,4],
                             [5,6]])

         XCTAssertEqual(matrix[[0,2]],Matrix([ [1,2],
                                               [5,6]]))

    }

    func testTransposed(){
        let matrix = Matrix([[1,2],
                              [3,4],
                              [5,6]])

        let transposed = Matrix([[1,3,5],
                                 [2,4,6]])

        XCTAssertEqual(matrix.T, transposed)

    }

    func testRmColumn(){
        var matrix = Matrix([[1,2],
                              [3,4],
                              [5,6]])
        matrix.rmColumn(0)
        XCTAssertEqual(matrix,Matrix([[2],
                                      [4],
                                      [6]]))

    }

    func testRmRow(){
        var matrix = Matrix([[1,2],
                              [3,4],
                              [5,6]])
        matrix.rmRow(0)
        XCTAssertEqual(matrix,Matrix([[3,4],
                                      [5,6]]))

    }

    func testDeepCopy(){
        var m1 = Matrix([[1,2],
                         [3,4],
                         [5,6]])
        
        var m2 = Matrix(m1)
        
        XCTAssertEqual(m1,m2)

        m1.rmRow(1)

        XCTAssertNotEqual(m1,m2)

        m2.rmRow(1)

        XCTAssertEqual(m1,m2)

    }

    func testInitVectorizable(){
        let matrix = Matrix([[1,2,3,4,5,6,7,8,9,10],
                             [7,6,5,4,3,2,1,0,-1,-2]])

        let v1 = SimpleFeatureVector(matrix[0])
        let v2 = SimpleFeatureVector(matrix[1])

        let matrix2 = Matrix([v1,v2])

        XCTAssertEqual(matrix,matrix2)
    }

    static var allTests : [(String, (MatrixTest) -> () throws -> Void)] {
        return [
        	("testInit",testInit),
        	("testSubscript",testSubscript),
            ("testSubscriptSet",testSubscript),
            ("testSubscriptRow",testSubscriptRow),
            ("testEquals",testEquals),
            ("testNotEquals",testNotEquals),
            ("testRowsCols",testRowsCols),
            ("testSubscriptRangeGet",testSubscriptRangeGet),
            ("testSubscriptRangeSet",testSubscriptRangeSet),
            ("testSubscriptRangeGet2",testSubscriptRangeGet2),
            ("testSubscriptRangeSet2",testSubscriptRangeSet2),
            ("testSubscriptColumnRangeGet",testSubscriptColumnRangeGet),
            ("testSubscriptColumnRangeSet",testSubscriptColumnRangeSet),
            ("testSubscriptColumnRangeGet2",testSubscriptColumnRangeGet2),
            ("testSubscriptColumnRangeSet2",testSubscriptColumnRangeSet2),
            ("testSubscriptList",testSubscriptList),
            ("testTransposed",testTransposed),
            ("testRmColumn",testRmColumn),
            ("testRmRow",testRmRow),
            ("testDeepCopy",testDeepCopy),
            ("testInitVectorizable",testInitVectorizable),
            ("testSubscriptRowRangeSet",testSubscriptRowRangeSet),
        ]
    }
}
