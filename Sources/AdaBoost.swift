class AdaBoost : Classifier {
	
	var weights = Matrix()
	var beta = [Double]()
	var hypotheses = [Classifier]()
	var totalI = 0
	var classes = [Int]()
	var isTrained = false
	required convenience init(trainset:Dataset){
		self.init(trainset,1000)
	}

	init(){
		
	}

	init(_ trainset: Dataset, _ maxI: Int){

		classes = trainset.classes
		self.train(trainset,maxI)
	}

	func train(_ trainset: Dataset){
		self.train(trainset)

	}

	func train(_ trainset: Dataset, _ maxI: Int){
		let ret = AdaBoost.train(trainset,1000)
		
		weights = ret.0
		beta = ret.1
		hypotheses = ret.2
		totalI = ret.3
		isTrained = true
	}

	internal static func train(_ trainset:Dataset,_ maxI: Int, _ regularizer: Double = 0.000001) -> (Matrix,[Double],[Classifier],Int){

		var weights = ones(maxI+1,trainset.nSamples)/trainset.nSamples
		var error = [Double]()
		var beta = [Double]()
		var hypotheses = [Classifier]()
		var totalI = 0
		for i in 0 ..< maxI {
			totalI = i
			//print("Weights: \(weights[i])")

			let	normedWeights = weights[i]/sum(weights[i])
			
			//print("Normed weights: \(normedWeights) = \(weights[i])/\(sum(weights[i]))")
			
			let clf = DecisionTree(trainset,normedWeights.array()[0],trainset.classes.count-1)
			hypotheses.append(clf)
			
			let predictions = clf.predict(samples:trainset.samples)
			//print("Predictions: \(predictions)")

			error.append(evaluate(predictions,trainset,normedWeights))
			
			var beta_i = (error[i]+regularizer)/(1-error[i])
			//print("Beta: \(beta_i)")
			beta.append(beta_i)
			let power = ones(trainset.nSamples,1)-loss(predictions,trainset.labels)

			//print("Power: \(power) = \((ones(trainset.nSamples,1)).T) - \((abs(Matrix([predictions]) - Matrix([trainset.labels])).T).T)")
			for j in 0 ..< power.rows{
				weights[i+1,j] = weights[i,j]*(beta[i]**power[j,0]) 
			}


			if ( i>1 && (abs(error[i]-error[i-1]) <= 0.00001 ||
				error[i] == 0)){
				break;
			}
		}

		return (weights,beta,hypotheses,totalI)
	}

	internal static func loss( _ predictions: [Int], _ labels: [Int]) -> Matrix{
		var loss = Matrix(predictions.count,1)
		for i in 0 ..< predictions.count {
			if(predictions[i] != labels[i]){
				loss[i] = Matrix([[1.0]])
			}
		}
		return loss
	}



	func predictSoft(sample: Matrix) -> [Int: Double]{
		var probas = [Int: Double]()
		for m in classes{
			probas.updateValue(0.0,forKey:m)
		}
		for i in 0 ..< self.totalI {
			let clf = hypotheses[i]
			let logBeta = _log(1/beta[i])
			let softLabels = clf.predictSoft(samples:sample)[0]
			/*Instead of adding 1*logBeta we weigh it with the confidence*/
			for m in classes{
				probas[m]! += softLabels[m]!*logBeta
			}
		}
		/* Normalize*/
		var sum = 0.0
		for m in classes{
				sum += probas[m]!
		}
		for m in classes{
				probas[m]! /= sum
		}
		return probas
	}

}