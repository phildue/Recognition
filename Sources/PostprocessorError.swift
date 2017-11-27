enum PostprocessorError : RecognitionError{
	case NotEnoughSamples(_ :Int,_ :Int)
}