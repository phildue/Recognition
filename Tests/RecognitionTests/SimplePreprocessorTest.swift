import XCTest

@testable import Recognition
class SimplePreprocessorTest: XCTestCase {

    func testAverageFilter(){
        let measurement1 = RawSample(Matrix([[1.0,1.0,1.0, 2.0,2.0,2.0]]))
        let measurement2 = RawSample(Matrix([[2.0,2.0,2.0, 1.0,1.0,1.0]]))

        let result = SimplePreprocessor.averageFilter([measurement1,measurement2])

        XCTAssertTrue(result.gyrX == 1.5)
        XCTAssertTrue(result.gyrY == 1.5)
        XCTAssertTrue(result.gyrZ == 1.5)
        XCTAssertTrue(result.accX == 1.5)
        XCTAssertTrue(result.accY == 1.5)
        XCTAssertTrue(result.accZ == 1.5)

    }

    func testPeak2Peak(){
        let measurement1 = RawSample(Matrix([[0.0,0.0,0.0, 0.0,1.0,0.0]]))
        let measurement2 = RawSample(Matrix([[1.0,0.0,0.0, 1.0,0.0,0.0]]))
        let measurement3 = RawSample(Matrix([[0.1,0.1,0.1, 2.1,2.1,2.1]]))

        let result = SimplePreprocessor.getPeak2Peak([measurement1,measurement2,measurement3])

        XCTAssertEqual(1.0, result)
    }

    func testWindowSize(){
         var samples = [RawSample]()
         let windowSize = 10
          for i in 0 ..< windowSize{
              let i16 = Int16(i)
              samples.append(RawSample(Matrix([[i16,i16,i16,i16,i16,i16]])))
          }
          for i in 0 ..< windowSize{
              let i16 = Int16(i)
              samples.append(RawSample(Matrix([[i16*10,i16*10,i16*10,i16*10,i16*10,i16*10]])))
          }


        let preprocessor = SimplePreprocessor(windowSize)
        let featureVectors = try! preprocessor.preprocess(samples)

        XCTAssertEqual(featureVectors.count,2)
    }

    func testNotEnoughSamples(){
        var samples = [RawSample]()
        let windowSize = 5
        for i in 0 ..< windowSize{
              let i16 = Int16(i)
              samples.append(RawSample(Matrix([[i16,i16,i16,i16,i16,i16]])))
        }
        let preprocessor = SimplePreprocessor(10)
        do{
            try preprocessor.preprocess(samples)
            XCTFail("Should have raised NotEnoughSamplesError")
        }catch{}

        
    }
    
     static var allTests : [(String, (SimplePreprocessorTest) -> () throws -> Void)] {
        return [
          ("testAverageFilter",testAverageFilter),
          ("testPeak2Peak",testPeak2Peak),
          ("testWindowSize",testWindowSize),
          (" testNotEnoughSamples",testNotEnoughSamples)
        ]
    }
}