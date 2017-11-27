class DecisionStump {

	var cmpLarge = false
	var feature = 0
	var threshold = 0.0
	
	init(){

	}

	init(_ trainset:Dataset, _ weights:[Double]){

		let ret = DecisionStump.train(trainset,weights)

		cmpLarge = ret.0
		threshold = ret.1
		feature = ret.2

	}

	init(_ cmpLarge: Bool, _ feature: Int, _ threshold: Double){
		
		self.cmpLarge = cmpLarge
		self.feature = feature
		self.threshold = threshold
	}

	internal static func train(_ trainset: Dataset, _ weights: [Double]) -> (Bool,Double,Int){
		var bestCmp = false
		var bestThresh = 0.0
		var bestFeature = 0
		var bestImpurity = Double.greatestFiniteMagnitude
		var weightMatrix = Matrix([weights]).T

		for o in 0 ..< 2 {
			let cmp = o == 0
			for j in 0 ..< trainset.dim {
				let sortedSamples = Matrix(trainset.samples.array().sorted{$0[j] < $1[j]})
				var threshPrev = -Double.greatestFiniteMagnitude
				for i in 0 ..< trainset.nSamples {
					let thresh = sortedSamples[i,j]
					if (thresh <= threshPrev){
						continue;
					}
					threshPrev = thresh

					let sets = DecisionStump(cmp,j,thresh).split(trainset)
					let splitIdxs = DecisionStump.getSplitIdxs(DecisionStump.label(trainset.samples,j,cmp,thresh))
					
					var impurity = 0.0
					for i in 0 ..< sets.count{

						if(sets[i].nSamples < 1){
							continue
						}
						var weightSubset = weightMatrix[splitIdxs[i]]
						weightSubset = weightSubset/sum(weightSubset)
						impurity += DecisionTree.impurity(sets[i],weightSubset.T.array()[0])
					}
					
					if (impurity < bestImpurity){
						
						bestCmp = cmp
						bestThresh = thresh
						bestFeature = j
						bestImpurity = impurity
						if (impurity == 0.0) {
							return (bestCmp,bestThresh,bestFeature)
						}
					}
				}
			}
		}
		return (bestCmp,bestThresh,bestFeature)
	}

	func split(_ dataset: Dataset) -> [Dataset] {
		let splitLabels = DecisionStump.label(dataset.samples,self.feature,self.cmpLarge,self.threshold)
		let splitIdxs = DecisionStump.getSplitIdxs(splitLabels)
		
		return DecisionStump.split(dataset,splitIdxs)
	}

	func label(_ sample: Matrix) -> Int {
		return DecisionStump.label(sample:sample,self.feature,self.cmpLarge,self.threshold)
	}

	internal static func getSplitIdxs(_ labels: [Int])->[[Int]]{
		var idx = [Int: [Int]]()

		for i in 0 ..< labels.count{
			if(idx[labels[i]] == nil){
				idx.updateValue([Int](),forKey:labels[i])
			}

			idx[labels[i]]!.append(i)
		}
		return Array(idx.values)
	}
	
	internal static func split(_ data: Dataset,_ idxs: [[Int]]) -> [Dataset]{

		var sets = [Dataset]()
		for l in idxs{
			if (l.count == 0){
				continue
			}
			let labels = Matrix([data.labels]).T[l].T.array()[0].map{Int($0)}//looks wicked but is just selecting a the subset l of labels
			sets.append(try! Dataset(data.samples[l],labels))
		}
		return sets
	}

	internal static func label(_ samples: Matrix, _ feature: Int, _ cmpLarge: Bool, _ threshold: Double) -> [Int]{
		var labels = [Int]()
		for i in 0 ..< samples.rows{
			labels.append(DecisionStump.label(sample:samples[i],feature,cmpLarge,threshold))
		}
		return labels
	}


	internal static func label(sample: Matrix, _ feature: Int, _ cmpLarge: Bool, _ threshold: Double) -> Int {
		if (cmpLarge) {
			if (sample[0,feature] >= threshold){
				return 1
			}else{
				return 0
			}
		}else{
			if (sample[0,feature] < threshold){
				return 1
			}else{
				return 0
			}
		}
	}

}