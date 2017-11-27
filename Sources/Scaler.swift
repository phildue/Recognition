public protocol Scaler {
	func train(_ m: Matrix)

	func transform(_ m:Matrix)->Matrix
}
