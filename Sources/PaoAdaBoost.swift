class PaoAdaboost : BasePaoClassifier{
	
	convenience init(_ traindata: [IPostureEntry]){
		self.init(traindata,AdaBoost())
	}


}