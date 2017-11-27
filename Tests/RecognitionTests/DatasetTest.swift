import XCTest

@testable import Recognition

class DatasetTest: XCTestCase {
    
    func testInit(){

    	let samples = Matrix([[1,2,3],
    								  [4,5,6],
    								  [7,8,9]])
    	let labels = [1,1,2]
        let dataset =  try! Dataset(samples,labels)
        XCTAssertEqual(dataset.dim,3)
        XCTAssertEqual(dataset.nSamples,3)
        XCTAssertEqual(dataset.classes,[1,2])
    }

    func testClassSamples(){
    	let samples = Matrix([[1,2,3],[4,5,6],[7,8,9]])
    	let labels = [1,1,2]
        let dataset =  try! Dataset(samples,labels)
        let result1 = dataset.classSamples(class_id:2)
        let result2 = dataset.classSamples(class_id:1)

        XCTAssertTrue(result1 == Matrix([[7,8,9]]),"\(result1)")
        XCTAssertTrue(result2 == Matrix([[1,2,3],
        								 [4,5,6]]),"\(result2)")

        XCTAssertTrue(result1.rows == 1)
        XCTAssertTrue(result2.rows == 2)


    }

    func testDimensionException(){
        let samples = Matrix([[1,2,3],[4,5,6],[7,8,9]])
        let labels = [1,2]
        do{
            try Dataset(samples,labels)
            XCTFail("Should have raised exception")
        }catch{}
    }

    func testAppend(){
        let samples = Matrix([[1,2,3],
                              [4,5,6]])
        let labels = [1,2]

        let set_ = try! Dataset(samples,labels)
        let setAppended = try! set_.append(try! Dataset(Matrix([[7,8,9]]),[1]))

        XCTAssertEqual(setAppended.samples,Matrix([ [1,2,3],
                                                    [4,5,6],
                                                    [7,8,9]]))
        XCTAssertEqual(setAppended.labels,[1,2,1])
    }

    func testAppendEmpty(){
        let set_ = Dataset()
        let setAppended = try! set_.append(try! Dataset(Matrix([[7,8,9]]),[1]))

        XCTAssertEqual(setAppended.samples,Matrix([[7,8,9]]))
        XCTAssertEqual(setAppended.labels,[1])
    }


    static var allTests : [(String, (DatasetTest) -> () throws -> Void)] {
        return [
        	("testInit",testInit),
        	("testClassSamples",testClassSamples),
            ("testDimensionException",testDimensionException),
            ("testAppend",testAppend),
            ("testAppendEmpty",testAppendEmpty),

        ]
    }
}
