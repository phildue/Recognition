class PostMajorityVote: Postprocessor{

	let windowSize: Int
	init(_ windowSize : Int = 10){
		self.windowSize = windowSize
	}

	func postprocess(_ prediction: [Int]) throws -> [Int]{
		if(prediction.count < windowSize){
			throw PostprocessorError.NotEnoughSamples(prediction.count,windowSize)
		}
		var results = [Int]()

		var window = [Int]()
		for i in 0 ..< prediction.count{	
			window.append(prediction[i])
			if(i>0 && (i+1)%windowSize==0){
				results.append(try postprocessWindow(window))	
				window = [Int]()
			}
		}
		return results
	}
	
	public func postprocessWindow(_ prediction: [Int]) throws -> Int{
		return majorityVote(prediction)
	}

	public func postprocess(predictionSoft: [[Int: Double]]) throws -> [[Int: Double]]{
		if(predictionSoft.count < windowSize){
			throw PostprocessorError.NotEnoughSamples(predictionSoft.count,windowSize)
		}
		var results = [[Int: Double]]()

		var window = [[Int: Double]]()
		for i in 0 ..< predictionSoft.count{	
			window.append(predictionSoft[i])
			if(i>0 && (i+1)%windowSize==0){
				results.append(try postprocessWindow(predictionSoft:window))	
				window = [[Int: Double]]()
			}
		}
		return results
	}

	func postprocessWindow(predictionSoft: [[Int: Double]]) throws -> [Int: Double]{
		var matrix = Matrix(windowSize,predictionSoft[0].keys.count)
		for i in 0 ..< windowSize{
			//TODO check dimensions
			var probas = [Double]()
			for k in predictionSoft[i].keys {
				probas.append(predictionSoft[i][k]!)
			}
			matrix[i] = Matrix([probas])
		}
		let mean = meanRow(matrix:matrix)
		var result = [Int: Double]()
		var i = 0
		for k in predictionSoft[0].keys{
			result[k] = mean[0,i]
			i += 1 
		}

		return result
	}

}