enum DatasetError : RecognitionError{
	case nLabelsAndNSamplesDoNotMatch(_ :Int,_ : Int)
	case dimensionsDoNotMatch(_: Int, _: Int)
}