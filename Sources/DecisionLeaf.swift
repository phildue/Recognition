class DecisionLeaf : DecisionNode{
	let trainset:Dataset


	init(_ trainset: Dataset){
		self.trainset = trainset
	}
	func predictSoft(sample: Matrix) -> [Int: Double]{
		var probas = [Int: Double]()
		for m in trainset.classes{
			probas.updateValue(Double(trainset.classSamples(class_id:m).rows)/Double(trainset.nSamples),forKey:m)
		}
		return probas
	}
}