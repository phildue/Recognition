import XCTest

@testable import Recognition

class MatrixMathTest: XCTestCase {
    
    func testPlus(){
        let matrix1 = Matrix([[1,2],[3,4]])
        let matrix2 = Matrix([[1,2],[3,4]])

        do{
            let result = try MatrixMath.plus(matrix1,matrix2)
            XCTAssertTrue(result[0,0] == 2)
            XCTAssertTrue(result[0,1] == 4)
            XCTAssertTrue(result[1,0] == 6)
            XCTAssertTrue(result[1,1] == 8)    
        }catch {
            XCTFail("Improper exception")
        }
        
    }


    func testMinus(){
        let matrix1 = Matrix([[1,2],[3,4]])
        let matrix2 = Matrix([[2,2],[3,4]])

        do{
            let result = try MatrixMath.minus(matrix1,matrix2)
            XCTAssertTrue(result[0,0] == -1)
            XCTAssertTrue(result[0,1] == 0)
            XCTAssertTrue(result[1,0] == 0)
            XCTAssertTrue(result[1,1] == 0)    
        }catch {
            XCTFail("Improper exception")
        }
        
    }

    func testMinusException(){
        let matrix1 = Matrix([[1,2],[3,4],[5,6]])
        let matrix2 = Matrix([[2,2],[3,4]])

        do{
            _ = try MatrixMath.minus(matrix1,matrix2)
            XCTFail("No Error thrown")
        }catch {

        }
        
    }

    func testPlusException(){
        let matrix1 = Matrix([[1,2],[3,4],[5,6]])
        let matrix2 = Matrix([[2,2],[3,4]])

        do{
            _ = try MatrixMath.plus(matrix1,matrix2)
            XCTFail("No Error thrown")
        }catch {
            
        }
    }


    func testTimes(){
        let matrix1 = Matrix([[1,2],[3,4]])
        let matrix2 = Matrix([[1,2],[3,4]])

        do{
            let result = try MatrixMath.times(matrix1,matrix2)
            XCTAssertTrue(result[0,0] == 7)
            XCTAssertTrue(result[0,1] == 10)
            XCTAssertTrue(result[1,0] == 15)
            XCTAssertTrue(result[1,1] == 22)    
        }catch {
            XCTFail("Improper exception")
        }
    }

    func testTimes2(){
        let matrix1 = Matrix([[1,2]])
        let matrix2 = Matrix([[1,2],
                                [3,4]])

        do{
            let result = try MatrixMath.times(matrix1,matrix2)
            XCTAssertTrue(result.rows == 1)
            XCTAssertTrue(result.columns == 2)
            XCTAssertTrue(result[0,0] == 7)
            XCTAssertTrue(result[0,1] == 10)
        }catch {
            XCTFail("Improper exception")
        }
    }


    func testTimesException(){
        let matrix1 = Matrix([[1,2],
                                [3,4]])
        let matrix2 = Matrix([[2,2]])

        do{
            _ = try MatrixMath.times(matrix1,matrix2)
            XCTFail("No Error thrown")
        }catch {
            
        }
    }


    func testMinusScalar(){
        let matrix = Matrix([[2]])
        let scalar = 2.0
        do{
            let result = try MatrixMath.minus(matrix,scalar)
            XCTAssertEqual(result,0)
        }catch {
            XCTFail("Improper exception")
        }   
    }

    func testPlusScalar(){
        let matrix = Matrix([[2]])
        let scalar = 2.0
        do{
            let result = try  MatrixMath.plus(matrix,scalar)
            XCTAssertEqual(result,4)
        }catch {
            XCTFail("Improper exception")
        } 
    }

    func testTimesScalar(){
        let matrix = Matrix([[1,2],
                                [3,4]])
        let scalar = 2.0
        do{
            let result = try  MatrixMath.times(matrix,scalar)
            XCTAssertTrue(result[0,0] == 2)
            XCTAssertTrue(result[0,1] == 4)
            XCTAssertTrue(result[1,0] == 6)
            XCTAssertTrue(result[1,1] == 8)    
        }catch {
            XCTFail("Improper exception")
        }         
    }

    func testMinusScalarException(){
        let matrix = Matrix([[2,2]])
        let scalar = 2.0
        do{
            let _ = try  MatrixMath.minus(matrix,scalar)
            XCTFail("Should throw exception")
        }catch {
        }   
    }

    func testPlusScalarException(){
        let matrix = Matrix([[2],[2]])
        let scalar = 2.0
        do{
            let _ = try  MatrixMath.plus(matrix,scalar)
            XCTFail("Should throw exception")
        }catch {
        } 
    }


    func testDiv(){
        XCTFail("Not implemented")
    }

    func testDivScalar(){
        let matrix = Matrix([[1,2],
                                [3,4]])
        let scalar = 2.0
        do{
            let result = try  MatrixMath.div(matrix,scalar)
            XCTAssertTrue(result[0,0] == 0.5)
            XCTAssertTrue(result[0,1] == 1)
            XCTAssertTrue(result[1,0] == 1.5)
            XCTAssertTrue(result[1,1] == 2.0)    
        }catch {
            XCTFail("Improper exception")
        } 
        
    }    

    static var allTests : [(String, (MatrixMathTest) -> () throws -> Void)] {
        return [
        	("testPlus",testPlus),
            ("testMinus",testMinus),
            ("testPlusException",testPlusException),
            ("testMinusException",testMinusException),
            ("testTimes",testTimes),
            ("testTimes2",testTimes2),
            ("testTimesException",testTimesException),
            ("testMinusScalar",testMinusScalar),
            ("testPlusScalar",testPlusScalar),
            ("testTimesScalar",testTimesScalar),
            ("testMinusScalarException",testMinusScalarException),
            ("testPlusScalarException",testPlusScalarException),
            ("testDiv",testDiv),
            ("testDivScalar",testDivScalar),
            


        ]
    }
}
