public struct Dataset{
	public let samples:Matrix
	public let labels:[Int]
	
	init(_ samples: Matrix,_ labels: [Int]) throws{
		if( samples.rows != labels.count){
			throw DatasetError.nLabelsAndNSamplesDoNotMatch(labels.count,samples.rows)
		}
		self.samples = samples
		self.labels = labels
	}

	init(){
		samples = Matrix(0,0)
		labels = [Int]()
	}

	var dim:Int{
		return samples.columns
	}
	var nSamples:Int{
		return samples.rows
	}
	var classes:[Int]{
		return unique(list:labels)
	}

	public func classSamples(class_id:Int) -> Matrix{
		var count = 0
		for i in 0..<labels.count{
			if(labels[i] == class_id){
				count+=1
			}
		}
		var n = 0
		var classSamples:Matrix = Matrix(count,self.dim)
		for i in 0..<labels.count{
			if(labels[i] == class_id){
				classSamples[n,0..<self.dim] = samples[i,0..<self.dim]
				n+=1

			}
		}

		return classSamples
	}

	public func append(_ dataset: Dataset) throws -> Dataset{
		if (self.dim != 0 && dataset.dim != self.dim){
			throw DatasetError.dimensionsDoNotMatch(dataset.dim,self.dim)
		}
		var newSamples = Matrix(self.nSamples + dataset.nSamples,dataset.dim)
		var newLabels = [Int]()

		if(self.samples.rows > 0){
			newSamples[0 ..< self.samples.rows] = self.samples
			newLabels.append(contentsOf:self.labels)
		}
		newSamples[self.samples.rows  ..< newSamples.rows] = dataset.samples

		newLabels.append(contentsOf:dataset.labels)
		return try! Dataset(newSamples,newLabels)
	}

}
