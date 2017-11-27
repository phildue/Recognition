public protocol Postprocessor{

	func postprocess(_ prediction: [Int]) throws -> [Int]
	func postprocess(predictionSoft: [[Int: Double]]) throws -> [[Int: Double]]
	
}
