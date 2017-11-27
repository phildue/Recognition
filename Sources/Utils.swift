func sum(_ m: Matrix) -> Double {
    var sum:Double = 0
    for i in 0 ..< m.rows {
        for j in 0 ..< m.columns {
        sum += m[i,j]
        }
    }
    return sum
}

func abs(_ m: Matrix) -> Matrix {

    var mAbs = Matrix(m.rows,m.columns)
    
    for i in 0 ..< m.rows {
        for j in 0 ..< m.columns {
            if(m[i,j] < 0.0){
                mAbs[i,j] = -1*m[i,j] 
            }else{
                mAbs[i,j] = m[i,j]
            }
        }
    }
    return mAbs
}

func evaluate(_ predictions: [Int],_ dataset: Dataset,_ weights: Matrix) -> Double{
    

    var weights_ = weights
    if(weights.rows == 1){
        weights_ = weights.T
    }

    let error = abs((Matrix([predictions]) - Matrix([dataset.labels])))*(weights_)

    return error[0,0]
}

func evaluate(_ predictions: [Int],_ dataset: Dataset) -> Double{
    return evaluate(predictions,dataset,ones(dataset.nSamples,1)/dataset.nSamples)
}

func majorityVote(_ elements: [Int]) -> Int {
    var votes = [Int: Double]()
    for i in unique(list:elements){
        votes[i] = 0.0
    }
    for i in 0 ..< elements.count{
        votes[elements[i]]! += 1
    }
    return votes.sorted(by: {$0.1 > $1.1})[0].key
}

let labelDict: [String:Double] = [
        "SitOk"     : 1.0,
        "SitNok"    : 2.0,
        "StandOk"   : 3.0,
        "StandNok"  : 4.0,
        "MovOk"     : 5.0,
        "MovNok"    : 6.0,
    ]
    
public func lookupLabel(_ strLabel : String)->Double{
    return labelDict[strLabel]!
}
public func lookupLabel(_ doubleLabel : Double)->String{

    return labelDict.first(where: {$1 == doubleLabel})!.key
}

public func argmax(_ l: [Double]) -> (Int,Double){
    var max = -Double.greatestFiniteMagnitude
    var maxI = 0
    for i in 0 ..< l.count{
        if(l[i] > max){
            max = l[i]
            maxI = i
        }
    }

    return (maxI,max)
}

public func max(_ matrix: Matrix)->Double{
    var maximum = -Double.greatestFiniteMagnitude
    for i in 0 ..< matrix.rows{
        for j in 0 ..< matrix.columns{
            if (matrix[i,j] > maximum){
                maximum = matrix[i,j]
               }
        }
        
    }
    
    return maximum
}

public func meanRow( matrix: Matrix)->Matrix{
	var sum:Matrix = Matrix(1,matrix.columns)
	for i in 0..<matrix.rows{
        sum = sum + matrix[i]
    }
    return sum/matrix.rows
}

public func meanCol(matrix: Matrix)->Matrix{
	return (meanRow(matrix:matrix.T)).T
}

public func cov(matrix: Matrix) -> Matrix{
	var sum:Matrix = Matrix(matrix.columns, matrix.columns)

    for i in 0..<matrix.rows{
        sum = sum + (matrix[i]-meanRow(matrix:matrix)).T * ((matrix[i]-meanRow(matrix:matrix)))
    }

    return sum/(matrix.rows-1)
}

public func unique<T>(list: [T])->[T] where T:Comparable, T:Hashable{
	return (Array<T>(Set<T>(list))).sorted(by:<)
}

public func euler()-> Double{
    return 2.7182818284
}

public func pi() -> Double{
    return 3.14159265359
}

public func ln(x: Double)->Double{
    return _log(x)/_log(euler())

}
public func inv(_ m: Matrix) throws ->Matrix{
    let d = try det(m)

    if (d==0){
        throw MatrixMathError.singularMatrix
    }

    return try cof(m.T)/d
}

public func cof(_ m: Matrix) throws ->Matrix{
    let cofM = Matrix(m.rows,m.columns)

    for i in 0 ..< m.rows{
        for j in 0 ..< m.columns{
            let submatrix = Matrix(m)
            submatrix.rmRow(i)
            submatrix.rmColumn(j)
            cofM[i,j] = try ((-1)**(1+i+1+j))*det(submatrix)
        }
    }
    return cofM
}

public func det(_ matrix: Matrix) throws -> Double{
    if( matrix.rows != matrix.columns ){
        throw MatrixMathError.dimensionsDoNotMatch(matrix.rows,matrix.columns)
    }
    return doDet(matrix)
}

internal func doDet(_ matrix: Matrix) -> Double{
    if(matrix.rows == 1){
        return matrix[0,0]
    }else{
        var d = 0.0
        for i in 0 ..< matrix.columns{
            let submatrix = Matrix(matrix)
            submatrix.rmRow(0)
            submatrix.rmColumn(i)
            d += matrix[0,i]*((-1)**(1+i+1))*doDet(submatrix)
        }
        return d
    }
}

public func norm(_ m: Matrix) -> Double{
    var sum:Double = 0
    for i in 0 ..< m.rows {
        for j in 0 ..< m.columns {
        sum += m[i,j]**2
        }
    }
    return sum.squareRoot()
}

public func sqrt(_ x: Double) -> Double{
   return x.squareRoot()
}

public func eye(_ rows: Int, _ cols: Int) -> Matrix{
    let mat = Matrix(rows,cols)
    for i in 0 ..< mat.rows {
        for j in 0 ..< mat.columns {
            if( i==j){
                mat[i,j] = 1.0
            }
        }
    }
    return mat
}


public func ones(_ rows: Int, _ cols: Int) -> Matrix{
    let mat = Matrix(rows,cols)
    for i in 0 ..< mat.rows {
        for j in 0 ..< mat.columns {
            mat[i,j] = 1.0
        }
    }
    return mat
}


