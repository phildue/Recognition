import XCTest

@testable import Recognition
class PostMajorityVoteTest: XCTestCase {

    func testHardLabelWindow(){
        var predictions = [1,2,2]
        var pp = PostMajorityVote(3)
        XCTAssertEqual(try! pp.postprocessWindow(predictions),2)

        predictions = [3,3,3,2,2]
        pp = PostMajorityVote(5)
        XCTAssertEqual(try! pp.postprocessWindow(predictions),3)
    }

    func testSoftLabelWindow(){
      var predictions = [[1: 0.4,
                         2: 0.6],
                         [1: 0.3,
                         2: 0.7]]
      var pp = PostMajorityVote(2)
      var res = try! pp.postprocessWindow(predictionSoft:predictions)
      XCTAssertEqual(res[1]!,Double(0.35))
//      XCTAssertEqual(res[2]!,0.65)

    }

    func testHardLabel(){
        var predictions = [1,2,2,1,1,3]
        var pp = PostMajorityVote(3)
        XCTAssertEqual(try! pp.postprocess(predictions),[2,1])

        predictions = [1,1,1,2,2,3,3,3,1,1]
        pp = PostMajorityVote(5)
        XCTAssertEqual(try! pp.postprocess(predictions),[1,3])
    }

    func testSoftLabel(){
      var predictions = [[1: 0.4,
                         2: 0.6],
                         [1: 0.3,
                         2: 0.7],
                         [3: 0.6,
                         4: 0.4],
                         [3: 0.7,
                         4: 0.3]]
      var pp = PostMajorityVote(2)
      var res = try! pp.postprocess(predictionSoft:predictions)
      XCTAssertEqual(res[0][1]!,Double(0.35))
//      XCTAssertEqual(res[2]!,0.65)
      XCTAssertEqual(res[1][4]!,Double(0.35))


    }
        
     static var allTests : [(String, (PostMajorityVoteTest) -> () throws -> Void)] {
        return [
          ("testHardLabelWindow",testHardLabelWindow),
          ("testSoftLabelWindow",testSoftLabelWindow),
          ("testHardLabel",testHardLabel),
          ("testSoftLabel",testSoftLabel),
        ]
    }
}