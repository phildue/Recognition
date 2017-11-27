class ParzenClassifier : Classifier{

	internal var trainset = Dataset()
	internal var width =  0.0
	internal var priors: [Int: Double] = [:]
	var isTrained = false

	required init(trainset:Dataset){
		self.train(trainset)
	}
	init(trainset:Dataset,maxApparentErr: Double, maxI: Int, learningRate: Double){
		self.trainset = trainset
		self.width = sqrt(Double(trainset.nSamples))/2
		self.train(trainset,maxApparentErr,maxI,learningRate)
	}

	func train(_ trainset: Dataset){
		self.trainset = trainset
		self.width = sqrt(Double(trainset.nSamples))/2
		self.train(trainset)
	}

	func train(_ trainset: Dataset,_ maxApparentErr: Double = 0.000001, _ maxI: Int = 1000, _ learningRate: Double = 10.0){
		self.trainset = trainset
		self.width = sqrt(Double(trainset.nSamples))/2
		
		var errorLast = 1.0
		var width = self.width
		for c in trainset.classes{
			priors.updateValue(Double(trainset.classSamples(class_id:c).rows)/Double(trainset.nSamples),forKey:c)
		}
		for i in 0 ..< maxI{
			let error = getApparentError()
			if(abs(error - errorLast) <= maxApparentErr){
				break;
			}else{
				width = sqrt(Double(trainset.nSamples))/(Double((i+1))*learningRate)
				errorLast = error
			}
		}
		self.width = width
		isTrained = true
	}

	internal func getApparentError()->Double{
		var error = 0.0
		for i in 0 ..< self.trainset.nSamples{
			if(predict(sample:self.trainset.samples[i,0..<trainset.dim]) != self.trainset.labels[i]){
				error += 1
			}
		}
		error /= Double(self.trainset.nSamples)
		return error;
	}


	static internal func kernel(x: Matrix,width: Double, mean: Matrix)->Double{
		//Gaussian with unity covariance
		let normConst = 1.0/(2.0*pi())**(Double(x.rows)/2.0)
		let xMu = x-mean;
		let outerProd = (xMu*(xMu.T))*(-0.5)
		let scalar = outerProd[0,0]
		return normConst * (euler()**scalar)
	}

	internal func predictSoft(sample: Matrix)->[Int: Double]{
		var classLikelihoods: [Int: Double]=[:]
		for c in trainset.classes{
			classLikelihoods.updateValue(priors[c]!*getClassLikelihood(sample,c),forKey:c)
		}
		//normalize
		var sum = 0.0
		for c in trainset.classes{
			sum += classLikelihoods[c]!
		}
		for c in trainset.classes{
			classLikelihoods.updateValue(classLikelihoods[c]!/sum,forKey:c)
		}

		return classLikelihoods
	}

	internal func getClassLikelihood(_ sample: Matrix,_ class_: Int)->Double{
		var windowSum = 0.0
		for i in 0 ..< trainset.nSamples{
			if(trainset.labels[i] == class_){
				let x = (sample - trainset.samples[i,0..<trainset.samples.columns])/width
				windowSum += ParzenClassifier.kernel(x:x,width:self.width,mean:trainset.samples[i,0..<trainset.samples.columns])/Double(trainset.classSamples(class_id:class_).rows)
			}
		}
		return windowSum/(Double(trainset.classSamples(class_id:class_).rows) * width**sample.rows)

	}
}