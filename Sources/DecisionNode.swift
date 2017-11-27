protocol DecisionNode {
	func predictSoft(sample: Matrix)->[Int: Double]
}