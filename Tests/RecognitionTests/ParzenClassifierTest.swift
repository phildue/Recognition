import XCTest

@testable import Recognition
class ParzenClassifierTest: XCTestCase {
    
 
    func testSimpleClassif(){
        let samples = Matrix([[-1,-1],
                              [1,1]])
        let labels = [1,2]
        let dataset =  try! Dataset(samples,labels)
        let parzenc = ParzenClassifier(trainset:dataset)
        let testsamples = Matrix([[-1,-1],
                                   [0,0],
                                   [1,1]])
        let results = parzenc.predictSoft(samples:testsamples)

        XCTAssertTrue(0.9999999 <= results[0][1]!)
        XCTAssertTrue(results[0][1]! <= 1.0)

        XCTAssertTrue(0.00001 >= results[0][2]!)
        XCTAssertTrue(results[0][2]! >= 0.0)

        XCTAssertTrue(0.49 <= results[1][1]!)
        XCTAssertTrue(results[1][1]! <= 0.51)

        XCTAssertTrue(0.49 <= results[1][2]!)
        XCTAssertTrue(results[1][2]! <= 0.51)

        XCTAssertTrue(0.9999999 <= results[2][2]!)
        XCTAssertTrue(results[2][2]! <= 1.0)

        XCTAssertTrue(0.00001 >= results[2][1]!)
        XCTAssertTrue(results[2][1]! >= 0.0)


    }

    func testClassif1(){
        let samples = Matrix([[-1,-1],
                                        [1,1]])

        let labels = [1,2]
        let dataset =  try! Dataset(samples,labels)
        let parzenc = ParzenClassifier(trainset:dataset)
        let testsamples = Matrix([  [-1,-1],
                                            [-0.5,-0.5],
                                            [-0.25,-0.25],
                                            [0.25,0.25],
                                            [0.5,0.5],
                                            [1,1]])
        let results = parzenc.predict(samples:testsamples)
        XCTAssertTrue(results[0]==1,"Was:\(results[0])")
        XCTAssertTrue(results[1]==1,"Was:\(results[1])")
        XCTAssertTrue(results[2]==1,"Was:\(results[2])")
        XCTAssertTrue(results[3]==2,"Was:\(results[3])")
        XCTAssertTrue(results[4]==2,"Was:\(results[4])")
        XCTAssertTrue(results[5]==2,"Was:\(results[5])")
        

    }



    func testClassif2(){
        let samples = Matrix([[-5,-5],
                                      [-5,-4],
                                      [-5,-6],
                                      [-4,-5],
                                      [5,5],
                                      [5,4],
                                      [5,6],
                                      [4,5]])
        let labels = [1,1,1,1,2,2,2,2]
        let dataset =  try! Dataset(samples,labels)
        let parzenc = ParzenClassifier(trainset:dataset)
        let testsamples = Matrix([  [-5,-4.5],
                                            [-4.5,-6],
                                            [5,4.5],
                                            [4.5,5]])
        let results = parzenc.predict(samples:testsamples)
        XCTAssertTrue(results[0]==1,"Was:\(results[0])")
        XCTAssertTrue(results[1]==1,"Was:\(results[1])")
        XCTAssertTrue(results[2]==2,"Was:\(results[2])")
        XCTAssertTrue(results[3]==2,"Was:\(results[3])")

    }



    static var allTests : [(String, (ParzenClassifierTest) -> () throws -> Void)] {
        return [
          ("testSimpleClassif",testSimpleClassif),
          ("testClassif1",testClassif1),
          ("testClassif2",testClassif2)

        ]
    }
}