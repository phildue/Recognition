import XCTest

@testable import Recognition

class DecisionTreeTest: XCTestCase {


  func testImpurity(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
   
      XCTAssertEqual(DecisionTree.impurity(try! Dataset(samples,[0,0,0,0,0])),0.0)
      XCTAssertTrue(DecisionTree.impurity(try! Dataset(samples,[0,1,0,0,0])) > 0.0)
  
  }

  func testWeightedImpurity(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
   
      let higherWeight = DecisionTree.impurity(try! Dataset(samples,[0,1,0,0,0]),[0.2,0.4,0.2,0.1,0.1]) 
      let unweighed = DecisionTree.impurity(try! Dataset(samples,[0,1,0,0,0]))
      XCTAssertTrue( higherWeight > unweighed,"\(higherWeight) is not larger than \(unweighed)")  
  }

  func testWeightedImpurity2(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
   
      XCTAssertEqual(DecisionTree.impurity(try! Dataset(samples,[0,0,0,0,0]),[0.2,0.4,0.2,0.1,0.1]),0.0)  
  }

  func testWeightedImpurity3(){
      let samples = Matrix([[1,1,1]])
   
      XCTAssertEqual(DecisionTree.impurity(try! Dataset(samples,[0]),[1.0]),0.0)  
  }

  func testPrediction(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
      let labels = [0,0,0,1,1]

      let clf = DecisionTree(try! Dataset(samples,labels))
  
      XCTAssertEqual(clf.predict(samples: samples),labels)
  }

  func testPredictionMaxDepth(){
      let samples = Matrix([[0,1,0],
                            [0,1,1]])
      let labels = [1,0]

      let clf = DecisionTree(try! Dataset(samples,labels),[Double](repeating: 1/2, count:2),1)
  
      XCTAssertEqual(clf.predict(samples: samples),labels) 
      XCTAssertEqual(clf.predictSoft(sample:samples[0])[0]!,0.0)
      XCTAssertEqual(clf.predictSoft(sample:samples[0])[1]!,1.0)
      XCTAssertEqual(clf.predictSoft(sample:samples[1])[0]!,1.0)
      XCTAssertEqual(clf.predictSoft(sample:samples[1])[1]!,0.0)

  }

  func testPredictionMultiClass(){
      let samples = Matrix([[0,1,0],
                            [0,1,0],
                            [1,1,1],
                            [0,1,1],
                            [0,1,1]])
      let labels = [0,0,2,1,1]

      let clf = DecisionTree(try! Dataset(samples,labels))
  
      XCTAssertEqual(clf.predict(samples: samples),labels)
  }


	static var allTests : [(String, (DecisionTreeTest) -> () throws -> Void)] {
        return [
        	("testImpurity",testImpurity),
          ("testWeightedImpurity",testWeightedImpurity),
          ("testWeightedImpurity2",testWeightedImpurity2),
          ("testWeightedImpurity3",testWeightedImpurity3),
          ("testPrediction",testPrediction),
          ("testPredictionMaxDepth",testPredictionMaxDepth),
          ("testPredictionMultiClass",testPredictionMultiClass),

          ]
    }
}