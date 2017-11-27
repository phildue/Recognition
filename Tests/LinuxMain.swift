import XCTest
@testable import RecognitionTests

XCTMain([ 
	 testCase(MatrixTest.allTests),
     testCase(MatrixMathTest.allTests),
     testCase(OperatorTest.allTests),
     testCase(UtilsTest.allTests),
     testCase(DatasetTest.allTests),
     testCase(LdaClassifierTest.allTests),
     testCase(KnnClassifierTest.allTests),
     testCase(ParzenClassifierTest.allTests),
     testCase(SimplePreprocessorTest.allTests),
     testCase(EqualScalerTest.allTests),
     testCase(PaoKnnClassifierTest.allTests),
     testCase(DecisionTreeTest.allTests),
     testCase(DecisionStumpTest.allTests),
     testCase(DecisionLeafTest.allTests),
     testCase(AdaBoostTest.allTests),
     testCase(PostMajorityVoteTest.allTests),
    

])
