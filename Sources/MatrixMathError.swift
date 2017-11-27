enum MatrixMathError : Error{
	case dimensionsDoNotMatch(_: Int,_: Int)
	case singularMatrix
}