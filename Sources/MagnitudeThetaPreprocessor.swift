 public class MagnitudeThetaPreprocessor: SimplePreprocessor{
	
	override func preprocessWindow(_ rawData: [RawSample]) -> FeatureVector{
		let average = SimplePreprocessor.averageFilter(rawData)
		let magnitude = SimplePreprocessor.getPeak2Peak(rawData)

		var vector = Matrix([[average.theta,
							  average.phi,
							  magnitude]])
		
		return	MagnitudeThetaVector(vector)
		
	}

}
