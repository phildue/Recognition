public struct MagnitudeThetaVector : FeatureVector{

	let theta: Double
	let peak2peakAccel: Double

	public init(_ vector: Matrix){
		theta = vector[0,1]
		peak2peakAccel = vector[0,2]
	}

	public var toVector:Matrix{
		return Matrix([[theta,peak2peakAccel]])
	}
}
	
