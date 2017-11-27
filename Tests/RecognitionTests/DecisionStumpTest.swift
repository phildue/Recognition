import XCTest

@testable import Recognition

class DecisionStumpTest: XCTestCase {

  func testDecision(){
       let sample = Matrix([[1,2,3]])
       XCTAssertEqual(DecisionStump.label(sample:sample,2,true,2.5),1)
       XCTAssertEqual(DecisionStump.label(sample:sample,2,false,2.5),0)
       XCTAssertEqual(DecisionStump.label(sample:sample,1,true,2.5),0)

  }

  func testTraining(){
      let samples = Matrix([[1,1,0],
                            [1,1,0],
                            [1,1,1]])
      let labels = [0,0,1]
      let (bestCmp,bestThresh,bestFeature) = DecisionStump.train(try! Dataset(samples,labels),[Double](repeating: 1/3, count: 3))

      XCTAssertEqual(bestFeature,2)
      XCTAssertEqual(bestThresh,1.0)
      XCTAssertEqual(bestCmp,true)
       
  }

  func testTrainingOtherLabels(){
      let samples = Matrix([[1,1,0],
                            [1,1,0],
                            [1,1,1]])
      let labels = [1,1,5]
      let (bestCmp,bestThresh,bestFeature) = DecisionStump.train(try! Dataset(samples,labels),[Double](repeating: 1/3, count: 3))

      XCTAssertEqual(bestFeature,2)
      XCTAssertEqual(bestThresh,1.0)
      XCTAssertEqual(bestCmp,true)
      
  }

  func testTrainingMoreClasses(){
      let samples = Matrix([[1,1,0],
                            [1,1,0],
                            [1,1,0],
                            [1,1,1],
                            [1,1,1],
                            [1,1,1]])
      let labels = [1,2,2,3,4,4]
      let (bestCmp,bestThresh,bestFeature) = DecisionStump.train(try! Dataset(samples,labels),[Double](repeating: 1/3, count: 6))

      XCTAssertEqual(bestFeature,2)
      XCTAssertEqual(bestThresh,1.0)
      XCTAssertEqual(bestCmp,true)
      
  }

  
  func testInit(){
      let sample = Matrix([[1,2,3]])
      let sample2 = Matrix([[1,2,2.4]])

      let clf = DecisionStump(true,2,2.5)
      XCTAssertEqual(clf.label(sample),1)
      XCTAssertEqual(clf.label(sample2),0)

  }

  
  func testWeightedLabeling(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
      let labels = [0,0,0,1,1]
      let weights = [0.1,0.1,0.4,0.2,0.2]
      let (bestCmp,bestThresh,bestFeature) = DecisionStump.train(try! Dataset(samples,labels),weights)
      
      
      XCTAssertEqual(bestFeature,0)
      XCTAssertEqual(bestThresh,1.0)
      XCTAssertEqual(bestCmp,true)
  }


	static var allTests : [(String, (DecisionStumpTest) -> () throws -> Void)] {
        return [
        	("testDecision", testDecision),
          ("testTraining", testTraining),
          ("testTrainingOtherLabels", testTrainingOtherLabels),
          ("testTrainingMoreClasses",testTrainingMoreClasses),
          ("testInit", testInit),
          ("testWeightedLabeling",testWeightedLabeling)
/*          
          ("testClassifSoft",testClassifSoft),
          ("testWeightedClassification",testWeightedClassification),
*/
        ]
    }
}