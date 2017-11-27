public protocol Preprocessor{

	func preprocess(_ rawData: [RawSample]) throws -> [FeatureVector]

	func preprocess(_ rawData: [RawSample], _ labels: [Int]) throws -> ([FeatureVector],[Int])
	
}
