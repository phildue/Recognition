import XCTest

@testable import Recognition

class AdaBoostTest: XCTestCase {

	func testClassif(){
      let samples = Matrix([[0, 1, 0],
                            [0, 0, 0], 
                            [1, 1, 1], 
                            [0, 1, 1], 
                            [0, 0, 1], 
                            [0, 1, 1]])
      let labels = [1,1,1,2,2,2]

      let clf = AdaBoost(try! Dataset(samples,labels),100)

      XCTAssertEqual(clf.predict(samples:samples),[1,1,1,2,2,2])
	}

  func testClassifMultiClass(){
      let samples = Matrix([[0, 1, 0],
                            [0, 0, 0], 
                            [1, 1, 1], 
                            [0, 1, 1], 
                            [0, 0, 1], 
                            [0, 1, 1]])
      let labels = [1,1,3,2,2,2]

      let clf = AdaBoost(try! Dataset(samples,labels),100)

      XCTAssertEqual(clf.predict(samples:samples),[1,1,3,2,2,2])
  }

  func testClassifMultiClassSoft(){
      let samples = Matrix([[0, 1, 0],
                            [0, 0, 0], 
                            [1, 1, 1], 
                            [1, 1, 0], 
                            [0, 0, 1], 
                            [0, 1, 1]])
      let labels = [1,1,3,2,2,2]

      let clf = AdaBoost(try! Dataset(samples,labels),100)
      //more like a demo than a test
      //print(clf.predictSoft(samples:samples))
  }

	static var allTests : [(String, (AdaBoostTest) -> () throws -> Void)] {
        return [
        	("testClassif",testClassif),
          ("testClassifMultiClass",testClassifMultiClass),
          ("testClassifMultiClassSoft",testClassifMultiClassSoft)
        ]
    }
}