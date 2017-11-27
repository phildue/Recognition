import XCTest

@testable import Recognition
class LdaClassifierTest: XCTestCase {
    
    func testMeans(){

    	let samples = Matrix([[1,2,3],
    								  [4,5,6],
                                      [7,8,9],
    								  [7,8,9]])
    	let labels = [1,1,2,2]
        let dataset =  try! Dataset(samples,labels)
        let means = LdaClassifier.estimateMeans(dataset:dataset)

        XCTAssertTrue(means[0] == Matrix([[2.5,3.5,4.5]]),"\(means[0])")
        XCTAssertTrue(means[1] == Matrix([[7,8,9]]),"\(means[1])")
        
    }

    func testCov(){

        let samples = Matrix([[1,2,3],
                                      [4,5,6],
                                      [7,8,9],
                                      [7,8,9]])
        let labels = [1,1,2,2]
        let dataset =  try! Dataset(samples,labels)
        let cov = LdaClassifier.estimateCov(dataset:dataset,regularizer:0.0)

        XCTAssertTrue(cov == Matrix([[2.25,2.25,2.25],
                                             [2.25,2.25,2.25],
                                             [2.25,2.25,2.25]]),"Was: \(cov)")
        
    }

    func testPrior(){
        let samples = Matrix([[1,2,3],
                                      [4,5,6],
                                      [7,8,9],
                                      [7,8,9]])
        let labels = [1,1,2,2]
        let dataset =  try! Dataset(samples,labels)
        let priors = LdaClassifier.estimatePriors(dataset:dataset)

        XCTAssertTrue(priors[0]==0.5,"Priors_0 = \(priors[0])")
        XCTAssertTrue(priors[1]==0.5,"Priors_1 = \(priors[1])")

    }

    func testLDA(){
        let samples = Matrix([[1,2],
                                      [1,2],
                                      [7,8],
                                      [7,8]])
        let labels = [1,1,2,2]
        let dataset =  try! Dataset(samples,labels)
        let ldc = LdaClassifier(dataset)
        let res1 = ldc.predict(samples:Matrix([[1,2]]))
        XCTAssertTrue(res1[0]==1,"Res1: \(res1)")
        let res2 = ldc.predict(samples:Matrix([[7,8]]))
        XCTAssertTrue(res2[0]==2,"Res2: \(res2)")

        
    }

    func testLDA2(){
        let samples = Matrix([[-1,-2],
                                      [-15,-3],
                                      [-1,-27],
                                      [-17,-27],
                                      [-100,-27],
                                      [7,8],
                                      [9,27],
                                      [12,8],
                                      [13,9],
                                      [7,8]])
        let labels = [1,1,1,1,1,2,2,2,2,2]
        let dataset =  try! Dataset(samples,labels)
        let ldc = LdaClassifier(dataset)
        let testsamples = Matrix([  [-15,-3],
                                            [-19,-21],
                                            [7,8],
                                            [15,9]])
        let results = ldc.predict(samples:testsamples)
        XCTAssertTrue(results[0]==1,"Was:\(results[0])")
        XCTAssertTrue(results[1]==1,"Was:\(results[1])")
        XCTAssertTrue(results[2]==2,"Was:\(results[2])")
        XCTAssertTrue(results[3]==2,"Was:\(results[3])")

        
    }

    


    static var allTests : [(String, (LdaClassifierTest) -> () throws -> Void)] {
        return [
        	("testMeans",testMeans),
            ("testCov",testCov),
            ("testPrior",testPrior),
            ("testLDA", testLDA),
            ("testLDA2", testLDA2),

        ]
    }
}