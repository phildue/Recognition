public protocol PaoClassifier {

	/**
	 * trains a classifier
	 * @param traindata [array of raw data]
	 */
	func train(_ traindata: [IPostureEntry])

	/**
	 * classifiy a bunch of samples
	 * @param testdata [raw data, should be multiples of the selected window size
	 *                  each window results in one classification]
	 * @return 		   [ list of predictions ]	 
	 */
	func predictSampleSoft(_ testdata: [IPostureEntry]) -> [IPostureEntry]
}


