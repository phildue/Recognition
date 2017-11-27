import XCTest

@testable import Recognition
class UtilsTest: XCTestCase {

	func testMeanRow(){
		let A = Matrix([[1, 1],[2, 2]])
        let Solution = Matrix([[1.5, 1.5]])
	    let B = meanRow(matrix:A)
	    XCTAssertTrue(B==Solution,"\(B)")    
	}

	func testMeanRow2(){
		let A = Matrix([[1, 2],[3, 4]])
        let Solution = Matrix([[2, 3]])
	    let B = meanRow(matrix:A)
	    XCTAssertTrue(B==Solution,"\(B)")    
	}

	func testMeanCol(){
		let A = Matrix([[1, 1],[2, 2]])
        let Solution = Matrix([[1, 2]])
	    let B = meanCol(matrix:A)
	    XCTAssertTrue(B==Solution,"\(B)")    
	}


	func testTranspose(){

		let A = Matrix([[1, 2],[3, 4]])
        let Solution = Matrix([[1, 3],[2, 4]])
	    let B = A.T
	    XCTAssertTrue(B==Solution,"\(B)")    	
	}
	func testTranspose1(){
		let A = Matrix([[1, 2],[3, 4]])

        let Solution = Matrix([[1],
         					   [2]])
	    let B:Matrix = A[0,0...1].T
	    XCTAssertTrue(B==Solution,"\(B)")    	

	}
	func testTranspose2(){
		let A = Matrix([[1, 2],
				 		[3, 4]])

        let Solution = Matrix([[3], 
        					   [4]])
	    let B:Matrix = A[1,0...1].T
	    XCTAssertTrue(B==Solution,"\(B)")    	
	}

	func testCov(){
        let A = Matrix([[1, 2],[3, 4]])
        let Solution = Matrix([[2, 2],[2, 2]])
        let B = cov(matrix:A);
        XCTAssertTrue(B==Solution,"\(B)")
    }

    func testUnique(){
    	let labels = [1,1,1,2,2,2,4,4,4,5,5,5,4,4,3,4,4]
    	let result = [1,2,3,4,5]
    	XCTAssertTrue(unique(list:labels).count==5)
    	XCTAssertEqual(unique(list:labels),result)

    }

    func testLn(){
    	  XCTAssertTrue(ln(x:2) <= 0.693148,"Was\(ln(x:2))")
          XCTAssertTrue(ln(x:2) >= 0.693146,"Was\(ln(x:2))")      
    }

    func testDet2(){
    	let m = Matrix([[1,2],
    					[2,3]])

    	XCTAssertEqual(try! det(m),-1)
    }
	func testDet3(){
    	let m = Matrix([[10,2,3],
    					[4,5,6],
    					[7,8,9]])

    	XCTAssertEqual(try! det(m),-27)
    }

    func testDet4(){
    	let m = Matrix([[10,2,3,1],
    					[4,5,6,2],
    					[7,8,9,3],
    					[4,3,2,1]])

    	XCTAssertEqual(try! det(m),-9)
    }

    func testDetUnequal(){
	 	let m = Matrix([[10,2,3,1],
    					[4,5,6,2],
    					[7,8,9,3]])
	 	do{
	 		try _ = det(m)
	 		XCTFail("Should have thrown exception")
	 		}catch{

	 		}
    }

    func testCofactor(){
		let m = Matrix([[10,2,3],
    					[4,5,6],
    					[7,8,9]])

    	let trueResult = Matrix([[-3,    6,    -3],
    							 [ 6,   69,   -66],
    							 [-3,  -48,    42]])

    	XCTAssertEqual(try! cof(m),trueResult)
    }

   func testInv2(){
    	let m = Matrix([[1,2],
    					[2,3]])

    	XCTAssertEqual(try! inv(m),Matrix([[-3,2],
    									   [2,-1]]))
    }

    func testInv3(){
    	let m = Matrix([[10,2,3],
    					[4,5,6],
    					[7,8,9]])
    	let result = try! inv(m)
    	let trueResult = Matrix([ [0.1111 ,-0.2222 ,0.1111],
								  [-0.2222,-2.5556,1.7778],
								  [0.1111 ,2.4444 ,-1.5556]])

    	XCTAssertTrue(equals(result,trueResult,within:0.001),"\(result) is not equal to \(trueResult)")
    }

    func testInv4(){
    	let m = Matrix([[10,2,3,1],
    					[4,5,6,2],
    					[7,8,9,3],
    					[4,3,2,1]])

    	let result = try! inv(m)
    	let trueResult = Matrix([[0.1111,   -0.2222,    0.1111,    0.0000],
   								 [-0.2222,  -2.5556,    1.7778,    0.0000],
    							 [0.1111,   -1.2222,    1.1111,   -1.0000],
         						 [0,   		11.0000,   -8.0000,    3.0000] ])

    	XCTAssertTrue(equals(result,trueResult,within:0.001),"\(result) is not equal to \(trueResult)")
    }

    func testInvUnequal(){
	 	let m = Matrix([[10,2,3,1],
    					[4,5,6,2],
    					[7,8,9,3]])
	 	do{
	 		try _ = inv(m)
	 		XCTFail("Should have thrown exception")
	 		}catch{

	 		}
    }

    func testInvSingular(){
    	let m = Matrix([[0,0],
    					[0,0]])
		do{
	 		try _ = inv(m)
	 		XCTFail("Should have thrown exception")
 		}catch{

 		}

    }

    func testEvaluate(){
        let samples = Matrix([[1,1,0],
                              [1,2,0],
                              [1,1,1],
                              [1,2,1]])
        let labels = [0,0,1,1]

        XCTAssertEqual(evaluate([1,1,1,1],try! Dataset(samples,labels)),0.5)

        XCTAssertEqual(evaluate([0,0,1,1],try! Dataset(samples,labels)),0.0)

    }

    func testEvaluateWeights(){
        let samples = Matrix([[1,1,0],
                              [1,2,0],
                              [1,1,1],
                              [1,2,1]])
        let labels = [0,0,1,1]
        let weights = Matrix([[0.375, 0.375, 0.125, 0.125]])
        XCTAssertEqual(evaluate([1,1,1,1],try! Dataset(samples,labels),weights),6/8)

    }

	static var allTests : [(String, (UtilsTest) -> () throws -> Void)] {
        return [
        	("testMeanRow",testMeanRow),
        	("testMeanRow2",testMeanRow2),
        	("testMeanCol",testMeanRow2),
        	("testTranspose",testTranspose), 	
        	("testTranspose1",testTranspose1), 	
        	("testTranspose2",testTranspose2), 	
        	("testCov",testCov),
        	("testUnique",testUnique),
            ("testLn",testLn),
            ("testDet2",testDet2),
            ("testDet3",testDet3),
            ("testDet4",testDet4),
            ("testDetUnequal",testDetUnequal),
            ("testCofactor",testCofactor),
            ("testInv2",testInv2),
			("testInv3",testInv3),
            ("testInv4",testInv4),
            ("testInvUnequal",testInvUnequal),
            ("testInvSingular",testInvSingular),
            ("testEvaluate",testEvaluate),
            ("testEvaluateWeights",testEvaluateWeights)

    	]
	}
}