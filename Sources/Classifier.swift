public protocol Classifier {
	/**
	 * [Train classifier from a dataset
	 * Depending on the chosen classifier and the amount of data this can
	 * take a while]
	 * @trainset: 		Dataset [Dataset with labelled samples]
	 */
	func train(_ trainset:Dataset)


	/**
	 * [predict one or several samples. Hard labelled classification]
	 * @samples 		Matrix 		[Samples to predict each row will be classified as one sample]
	 * @return			[Int]		[List of assigned class labels]
	 */
	func predict(samples: Matrix)->[Int]

	/**
	 * [predict one sample. Hard labelled classification]
	 * @samples 		Matrix 		[Samples to predict first row will be classified as one sample]
	 * @return			Int			[assigned class label]
	 */
	func predict(sample: Matrix)->Int


	/**
	 * [predict one or several samples. Soft labelled classification]
	 * @samples 		Matrix 		[Samples to predict each row will be classified as one sample]
	 * @return			[Dict]		[Dictionarys containing the probability for each class]
	 */
	func predictSoft(samples: Matrix)->[[Int: Double]]

	/**
	 * [predict one sample. Soft labelled classification]
	 * @sample 		Matrix 		[Samples to predict first row will be classified as one sample]
	 * @return		Dict		[Dictionary containing the probability for each class]
	 */
	func predictSoft(sample: Matrix)->[Int: Double]

	var isTrained:Bool {get}
}

extension Classifier {
	func predict(samples: Matrix)->[Int] {
		var labelsFound = [Int]()
		for i in 0..<samples.rows{
			labelsFound.append(self.predict(sample:samples[i]))
			
		}
		return labelsFound
	}

	internal func predict(sample: Matrix) -> Int{
		return predictSoft(sample:sample).sorted(by: {$0.1 > $1.1})[0].key
		
	}

	func predictSoft(samples: Matrix)->[[Int: Double]] {
		var softLabels:[[Int:Double]] = []
		for i in 0..<samples.rows{
			softLabels.append(self.predictSoft(sample:samples[i]))
			
		}
		return softLabels
	}
}


	

	
	
