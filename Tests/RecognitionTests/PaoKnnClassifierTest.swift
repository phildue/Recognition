import XCTest

@testable import Recognition

class PaoKnnClassifierTest: XCTestCase {

  class PostureEntry : IPostureEntry{
      var accX: Int16
      var accY: Int16
      var accZ: Int16
      var gyrX: Int16
      var gyrY: Int16
      var gyrZ: Int16
      var phi: Int16
      var theta: Int16
      var psi: Int16
      var p2p: Double
      var posture: Double
      var postureLbl: String

      init(_ values: [Int16],_ label: String){
          self.accX = values[0]
          self.accY = values[1]
          self.accZ = values[2]
          self.gyrX = values[3]
          self.gyrY = values[4]
          self.gyrZ = values[5]
          self.phi = values[6]
          self.psi = values[7]
          self.theta = values[8]
          
          posture = 0
          self.p2p = 0
          self.postureLbl = label
        }
  }

	func testSimple(){
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 6 {
        var l = [PostureEntry]()
        for i in 0 ..< 10{
          let i16 = Int16(i)
          l.append(PostureEntry([i16,i16,i16,i16,i16,i16,i16,i16,i16],lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }
      let classifier = PaoKnnClassifier(samples,windowSize:10,kNeighbours:2)
      for j in 0 ..< 6 {
          let prediction = classifier.predictSampleSoft(classSamples[j])
          XCTAssertTrue(-1.0 <= prediction[0].posture && prediction[0].posture <= 1.0)
          
          //print(prediction[0].posture)

      }
  }

  func testMissingClass(){
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 3 {
        var l = [PostureEntry]()
        for i in 0 ..< 10{
          let i16 = Int16(i)
          l.append(PostureEntry([i16,i16,i16,i16,i16,i16,i16,i16,i16],lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }
      let classifier = PaoKnnClassifier(samples,windowSize:10,kNeighbours:2)
      for j in 0 ..< 3 {
          let prediction = classifier.predictSampleSoft(classSamples[j])
          XCTAssertTrue(-1.0 <= prediction[0].posture && prediction[0].posture <= 1.0)
          //print(prediction[0].posture)

      }
  }

  func testNormalDistr(){


      /* Some random values generated with matlab
         each class follows a normal distribution around
         a different mean */
      let class1 = [[ 2932, -4019,  6957, -2664, -7102,  9407, -6580,  1720,
         1101],
       [ 6968,  2276,  6828, -8007,  6011, -8313,  4011,  7999,
         3001],
       [-6663,  3544, -1927,  2378, -4965,  3561,  1103,  7437,
         -753],
       [-7158,   595, -1664, -4646, -6766,  6544,  5131,  1682,
        -4363],
       [-1473,  3188, -2733,  5143, -1309,  2166,  -110, -1198,
         4552]]


      let class2 = [[  1488,   -405,   5191,   3333,   -619,   5663,    421,
          -816,   6989],
       [  9943,  -6623,   3347,  11330,   -759,   1746,   4062,
          7086,   5099],
       [  6152,  -8198,   5529,   5184,    997,    317,   9233,
          5349,   3941],
       [ -1896,   5473,   3671,    904,   8221,   3144,   2457,
          5190,  -4494],
       [  3199,   5523,   -639,   1002,   3565,   6418,   -432,
           982,   1943]]

      let class3 = [[ 4484,  5251,  4577,  5825,  1236,  2282,  9113,  6720,
         -754],
       [ 1484,  9217,  1556,  3558,  4003,  4465,  7841,   -69,
         4410],
       [ 3110,  -160,  7307,  1953,  4909,  7012,  2837,  5138,
         7166],
       [ 2754,  4727,  -867,  4341,  7661,   931,  4134,  4559,
         5982],
       [ 2195,  8771,  2420,  4456,  1085,  1101,  4795,  6463,
         5750]]

      let class4 = [[ 3422,  6243,  5753,  4664,  3511,  3925,  3540,  5551,
         2989],
       [ 2836,  5750,  4204,  6136,  5639,  4626,  6276,  6976,
         5009],
       [ 2363,  8159,  3496,  2696,  4588,  6643,  6829,  4164,
         4365],
       [ 3429,  5831,  8021,  4352,  3689,  1641,  3760,  3650,
         5461],
       [ 5737,  3319,  2681,  4091,  8010,  4397,  2123,  3602,
         3730]]

      let class5 = [[ 4709,  6444,  5396,  4851,  4330,  4412,  4034,  4865,
         4027],
       [ 7510,  5656,  5920,  4035,  3921,  3418,  5416,  3657,
         4937],
       [ 5425,  4176,  6603,  4588,  4096,  4562,  3901,  6334,
         4050],
       [ 4813,  3192,  2234,  5804,  3855,  5748,  5409,  5985,
         5497],
       [ 5084,  4808,  5035,  2129,  4251,  5425,  5410,  3716,
         4842]]

      let class6 = [[ 4968,  6200,  5173,  4073,  4484,  5586,  6189,  4271,
         3949],
       [ 4823,  5216,  5238,  3724,  4691,  4678,  6323,  2462,
         5627],
       [ 5010,  5459,  4012,  4994,  4706,  4984,  4923,  4482,
         4562],
       [ 5261,  5086,  5681,  5885,  5023,  3664,  5413,  5226,
         4571],
       [ 5471,  3048,  4179,  4218,  5712,  3798,  3603,  5926,
         3992]]

      let classes = [
        class1,
        class2,
        class3,
        class4,
        class5,
        class6
      ]
      /* Generate PostureEntries from the values*/
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 6 {
        var l = [PostureEntry]()

        for i in 0 ..< 5{
          let class_ = classes[j]
          l.append(PostureEntry(class_[i].map{Int16($0)},lookupLabel(Double(j+1))))
        }
        for i in 0 ..< 5{
          let class_ = classes[j]
          l.append(PostureEntry(class_[i].map{Int16($0)},lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }

      /* Train */
      let classifier = PaoKnnClassifier(samples,windowSize:2,kNeighbours:1)
      
      /* Predict
      *  just predicting the training data again to see if the code works*/
      for j in 0 ..< 6 {
          let predictions = classifier.predictSampleSoft(classSamples[j])

          for p in predictions{
              XCTAssertEqual(p.postureLbl,lookupLabel(Double(j+1)))

              /* Since we are predicting the training data with 1 nearest neighbour 
              *  healthy/unhealthy should just allways be 100%*/
              if(lookupLabel(p.postureLbl) == 1 ||
                lookupLabel(p.postureLbl) == 3 ||
                lookupLabel(p.postureLbl) == 5){
                XCTAssertEqual(p.posture,1.0)
              }else{
                XCTAssertEqual(p.posture,-1.0)

              }            
          }

      }
  }


  func testEmptySet(){
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 6 {
        var l = [PostureEntry]()
        for i in 0 ..< 10{
          let i16 = Int16(i)
          l.append(PostureEntry([i16,i16,i16,i16,i16,i16,i16,i16,i16],lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }
      let classifier = PaoKnnClassifier([PostureEntry](),windowSize:10,kNeighbours:2)
      for j in 0 ..< 6 {
          let prediction = classifier.predictSampleSoft(classSamples[j])
          //XCTAssertTrue(-1.0 <= prediction[0].posture && prediction[0].posture <= 1.0)
          
          //print(prediction[0].posture)

      }
  }


   func testNormalDistrPostProcess(){


      /* Some random values generated with matlab
         each class follows a normal distribution around
         a different mean */
      let class1 = [[ 2932, -4019,  6957, -2664, -7102,  9407, -6580,  1720,
         1101],
       [ 6968,  2276,  6828, -8007,  6011, -8313,  4011,  7999,
         3001],
       [-6663,  3544, -1927,  2378, -4965,  3561,  1103,  7437,
         -753],
       [-7158,   595, -1664, -4646, -6766,  6544,  5131,  1682,
        -4363],
       [-1473,  3188, -2733,  5143, -1309,  2166,  -110, -1198,
         4552]]


      let class2 = [[  1488,   -405,   5191,   3333,   -619,   5663,    421,
          -816,   6989],
       [  9943,  -6623,   3347,  11330,   -759,   1746,   4062,
          7086,   5099],
       [  6152,  -8198,   5529,   5184,    997,    317,   9233,
          5349,   3941],
       [ -1896,   5473,   3671,    904,   8221,   3144,   2457,
          5190,  -4494],
       [  3199,   5523,   -639,   1002,   3565,   6418,   -432,
           982,   1943]]

      let class3 = [[ 4484,  5251,  4577,  5825,  1236,  2282,  9113,  6720,
         -754],
       [ 1484,  9217,  1556,  3558,  4003,  4465,  7841,   -69,
         4410],
       [ 3110,  -160,  7307,  1953,  4909,  7012,  2837,  5138,
         7166],
       [ 2754,  4727,  -867,  4341,  7661,   931,  4134,  4559,
         5982],
       [ 2195,  8771,  2420,  4456,  1085,  1101,  4795,  6463,
         5750]]

      let class4 = [[ 3422,  6243,  5753,  4664,  3511,  3925,  3540,  5551,
         2989],
       [ 2836,  5750,  4204,  6136,  5639,  4626,  6276,  6976,
         5009],
       [ 2363,  8159,  3496,  2696,  4588,  6643,  6829,  4164,
         4365],
       [ 3429,  5831,  8021,  4352,  3689,  1641,  3760,  3650,
         5461],
       [ 5737,  3319,  2681,  4091,  8010,  4397,  2123,  3602,
         3730]]

      let class5 = [[ 4709,  6444,  5396,  4851,  4330,  4412,  4034,  4865,
         4027],
       [ 7510,  5656,  5920,  4035,  3921,  3418,  5416,  3657,
         4937],
       [ 5425,  4176,  6603,  4588,  4096,  4562,  3901,  6334,
         4050],
       [ 4813,  3192,  2234,  5804,  3855,  5748,  5409,  5985,
         5497],
       [ 5084,  4808,  5035,  2129,  4251,  5425,  5410,  3716,
         4842]]

      let class6 = [[ 4968,  6200,  5173,  4073,  4484,  5586,  6189,  4271,
         3949],
       [ 4823,  5216,  5238,  3724,  4691,  4678,  6323,  2462,
         5627],
       [ 5010,  5459,  4012,  4994,  4706,  4984,  4923,  4482,
         4562],
       [ 5261,  5086,  5681,  5885,  5023,  3664,  5413,  5226,
         4571],
       [ 5471,  3048,  4179,  4218,  5712,  3798,  3603,  5926,
         3992]]


      let classes = [
        class1,
        class2,
        class3,
        class4,
        class5,
        class6
      ]
      /* Generate PostureEntries from the values*/
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 6 {
        var l = [PostureEntry]()

        for i in 0 ..< 5{
          let class_ = classes[j]
          l.append(PostureEntry(class_[i].map{Int16($0)},lookupLabel(Double(j+1))))
        }
        for i in 0 ..< 5{
          let class_ = classes[j]
          l.append(PostureEntry(class_[i].map{Int16($0)},lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }

      /* Train */
      let classifier = BasePaoClassifier(samples,KnnClassifier(kNeighbours:1),EqualScaler(),PostMajorityVote(10))
      
      /* Predict
      *  just predicting the training data again to see if the code works*/
      for j in 0 ..< 6 {
          let predictions = classifier.predictSampleSoft(classSamples[j])

          for p in predictions{
              XCTAssertEqual(p.postureLbl,lookupLabel(Double(j+1)))

              /* Since we are predicting the training data with 1 nearest neighbour 
              *  healthy/unhealthy should just allways be 100%*/
              if(lookupLabel(p.postureLbl) == 1 ||
                lookupLabel(p.postureLbl) == 3 ||
                lookupLabel(p.postureLbl) == 5){
                XCTAssertEqual(p.posture,1.0)
              }else{
                XCTAssertEqual(p.posture,-1.0)

              }            
          }

      }
  }

  func testSimpleManhattan(){
      var classSamples = [[PostureEntry]]()
      var samples = [PostureEntry]()
      for j in 0 ..< 6 {
        var l = [PostureEntry]()
        for i in 0 ..< 10{
          let i16 = Int16(i)
          l.append(PostureEntry([i16,i16,i16,i16,i16,i16,i16,i16,i16],lookupLabel(Double(j+1))))
        } 
        classSamples.append(l)
        samples.append(contentsOf:l) 
      }
      let classifier = BasePaoClassifier(samples,KnnClassifier(trainset:Dataset(),kNeighbours:1,metric:"manhattan"),EqualScaler(),PostMajorityVote(10))
      for j in 0 ..< 6 {
          let prediction = classifier.predictSampleSoft(classSamples[j])
          //print(prediction[0].posture)

      }
  }
  

	static var allTests : [(String, (PaoKnnClassifierTest) -> () throws -> Void)] {
        return [
            ("testSimple",testSimple),
            ("testNormalDistr",testNormalDistr),
            ("testMissingClass",testMissingClass),
            ("testEmptySet",testEmptySet),
            ("testNormalDistrPostProcess",testNormalDistrPostProcess),
            ("testSimpleManhattan",testSimpleManhattan),      
        ]
    }
}