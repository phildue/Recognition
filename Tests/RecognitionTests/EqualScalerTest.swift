import XCTest

@testable import Recognition

class EqualScalerTest: XCTestCase {


  func testSimple(){
     let mat = Matrix([
      [1, 10, -100],
      [1000, 10000, -100000]
     ])

     let scaler = EqualScaler(mat)
     let scaledMat = scaler.transform(mat)
     XCTAssertEqual(scaledMat,Matrix([
      [0.0, 0.0, 1.0],
      [1.0,  1.0,  0.0]]))
  }

  static var allTests : [(String, (EqualScalerTest) -> () throws -> Void)] {
        return [
            ("testSimple",testSimple),
        ]
    }
}