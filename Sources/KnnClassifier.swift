class KnnClassifier: Classifier{
	
	internal var trainset: Dataset = Dataset()
	internal var kNeighbours: Int = 2
	internal var priors: [Int: Double] = [:]
	var metric: String
	func train(_ trainset: Dataset){
		self.train(trainset,kNeighbours:self.kNeighbours)
	}

	init(trainset: Dataset, kNeighbours: Int = 2, metric: String = "euclidian"){
		self.metric = metric
		self.trainset = trainset
		self.kNeighbours = kNeighbours
		train(trainset,kNeighbours:kNeighbours)

	}

	init(kNeighbours: Int = 2){
		self.kNeighbours = kNeighbours
		self.metric = "euclidian"
		self.trainset = Dataset()
	}

	func train(_ trainset: Dataset, kNeighbours: Int){
		self.trainset = trainset
		self.kNeighbours = kNeighbours

		/*For now*/
		for c in trainset.classes{
			priors.updateValue(0.5,forKey:c)
		}
	}

	var isTrained: Bool{
		return trainset.nSamples > 0
	}

	internal func predictSoft(sample: Matrix)->[Int: Double]{
		var distances = [(distance:Double,label:Int)]()
		var proba: [Int: Double] = [:]
		var ranking = [(key: Int, value: Double)]()
		for i in 0 ..< trainset.nSamples{
			distances.append((self.dist(trainset.samples[i,0..<trainset.samples.columns],sample),trainset.labels[i]))
		}
		distances = distances.sorted(by: {$0.distance < $1.distance})

		for k in kNeighbours ..< trainset.nSamples{
			let neighbours = distances[0 ..< k]
			for c in trainset.classes {
				proba.updateValue(priors[c]!*Double((neighbours.filter({$0.label == c})).count)/Double(k), forKey:c)
			}

			ranking = proba.sorted(by: {$0.1 > $1.1})

			if (ranking[0].value > ranking[1].value){
				break
			} 	
		}
		// normalize
		var sum = 0.0
		for c in trainset.classes{
			sum += proba[c]!
		}
		for c in trainset.classes{
			proba.updateValue(proba[c]!/sum,forKey:c)
		}

		return proba

		
	}

	func dist(_ this: Matrix,_ that: Matrix) -> Double{
		switch (metric){
			case "manhattan":
				return KnnClassifier.dist_manhattan(this:this,that:that)
			default: 
				return KnnClassifier.dist(this:this,that:that)
		}
	}

	internal static func dist(this: Matrix,that: Matrix)->Double{
		//Euclidian distance
		return norm(this-that)
	}
	internal static func dist_manhattan(this: Matrix,that: Matrix) -> Double{
		return sum(this-that)
	}
	
	
        
}