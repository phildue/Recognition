import XCTest

@testable import Recognition

class DecisionLeafTest: XCTestCase {

  func testPrediction(){
      let samples = Matrix([[1,1,0],
                            [1,1,0],
                            [1,1,1]])
      let labels = [0,0,1]

      let clf = DecisionLeaf(try! Dataset(samples,labels))
      
      for i in 0 ..< samples.rows{
        XCTAssertEqual(clf.predictSoft(sample:samples[i])[0]!,2.0/3.0)
        XCTAssertEqual(clf.predictSoft(sample:samples[i])[1]!,1.0/3.0)
      }
      
  }

	static var allTests : [(String, (DecisionLeafTest) -> () throws -> Void)] {
        return [
          ("testPrediction",testPrediction),
        ]
    }
}