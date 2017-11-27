public class  BasePaoClassifier: PaoClassifier {

	let classifier: Classifier
	let scaler: Scaler?
	let preprocessor: Preprocessor?
	let postprocessor: Postprocessor?


	public init(_ traindata: [IPostureEntry], _ classifier: Classifier, _ scaler: Scaler = EqualScaler()){
		self.postprocessor = nil
		self.classifier = classifier
		self.scaler = scaler
		self.preprocessor = nil
		self.train(traindata)
	}
	public init(_ traindata: [IPostureEntry], _ classifier: Classifier,_ preprocessor: Preprocessor = SimplePreprocessor(), _ scaler: Scaler = EqualScaler()){
		self.postprocessor = nil
		self.classifier = classifier
		self.scaler = scaler
		self.preprocessor = preprocessor
		self.train(traindata)
	}

	public init(_ traindata: [IPostureEntry], _ classifier: Classifier,_ preprocessor: Preprocessor = SimplePreprocessor(), _ scaler: Scaler = EqualScaler(), _ postprocessor: Postprocessor){
		self.postprocessor = postprocessor
		self.classifier = classifier
		self.scaler = scaler
		self.preprocessor = preprocessor
		self.train(traindata)

	}

	public init(_ traindata: [IPostureEntry], _ classifier: Classifier,_ scaler: Scaler = EqualScaler(), _ postprocessor: Postprocessor){
		self.postprocessor = postprocessor
		self.classifier = classifier
		self.scaler = scaler
		self.preprocessor = nil
		self.train(traindata)

	}

	public func train(_ traindata: [IPostureEntry]){

		if (traindata.count > 0){
			/* convert the posture entries to local type raw data and put labels in seperate list*/
			var rawData = [RawSample]()
			var labels = [Int]()
			for i in 0 ..< traindata.count{
				labels.append(Int(lookupLabel(traindata[i].postureLbl)))
				rawData.append(RawSample(traindata[i]))
			}


            /* apply preprocessing*/
            var filtered: ([Vectorizable],[Int]) = (rawData,labels)
            if preprocessor != nil{
                let preprocessed = (try! preprocessor!.preprocess(rawData,labels))
                filtered.0 = preprocessed.0.map{$0 as Vectorizable}
                filtered.1 = preprocessed.1
            }

            /* convert to matrix */
            var matrixRep = Matrix(filtered.0)
            
            /* apply scaling*/
            self.scaler?.train(matrixRep)
            matrixRep = scaler?.transform(matrixRep) ?? matrixRep

            /*generate trainingset and train*/
            let trainset = try! Dataset(matrixRep,filtered.1)
            self.classifier.train(trainset)
        }
	}

	public func predictSampleSoft(_ testdata: [IPostureEntry]) -> [IPostureEntry]{

		if(testdata.count > 0 && classifier.isTrained){
			/* convert data to  local type*/
			var rawData = [RawSample]()
			for i in 0 ..< testdata.count{
				rawData.append(RawSample(testdata[i]))
			}

            /* apply preprocessing -> average filter and peak2peak*/
            var featureVector:[Vectorizable] = rawData
            if preprocessor != nil {
            featureVector = try! preprocessor!.preprocess(rawData).map{$0 as Vectorizable}

            }

            /* apply same scaling as on the training set*/
            let sampleMatrix = scaler?.transform(Matrix(featureVector)) ?? Matrix(featureVector)

            /* get the hard labels*/
            var hardLabels = classifier.predict(samples:sampleMatrix)

            hardLabels = try! postprocessor?.postprocess(hardLabels) ?? hardLabels
            
            /* get the soft labels*/
            var softLabels = classifier.predictSoft(samples:sampleMatrix)

            softLabels = try! postprocessor?.postprocess(predictionSoft:softLabels) ?? softLabels

            /* create output data type for each classified sample*/
            var predictions = [Predicition]()
            for i in 0 ..< softLabels.count{

                /* calculate percentage of healthy/unhealthy*/
                var probabilities = softLabels[i]
                var badPosture = probabilities[Int(lookupLabel("SitNok"))] ?? 0
                badPosture += probabilities[Int(lookupLabel("StandNok"))] ?? 0
                badPosture += probabilities[Int(lookupLabel("MovNok"))] ?? 0
                var goodPosture = probabilities[Int(lookupLabel("SitOk"))] ?? 0
                goodPosture += probabilities[Int(lookupLabel("StandOk"))] ?? 0
                goodPosture += probabilities[Int(lookupLabel("MovOk"))] ?? 0

                /* put it all together */
                predictions.append(Predicition(goodPosture-badPosture,lookupLabel(Double(hardLabels[i]))))

            }
            
            return predictions
        } else {
            return [Predicition]()
        }
	}
}
