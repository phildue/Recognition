class MatrixMath {
	static func plus(_ this: Matrix, _ that: Matrix) throws -> Matrix {

		try checkDimAdd(this,that)
		return doPlus(this,that)
		
	}

	static func plus(_ this: Matrix, _ that: Double) throws -> Double {
		let mat = Matrix([[that]])
		let scalarMat = try plus(this,mat)
		return scalarMat[0,0]
	}

	static func minus(_ this: Matrix, _ that: Matrix) throws -> Matrix {

		try checkDimAdd(this,that)
		return doMinus(this,that)
		
	}

	static func minus(_ this: Matrix, _ that: Double) throws -> Double {
		let mat = Matrix([[that]])
		let scalarMat = try minus(this,mat)
		return scalarMat[0,0]
	}

	static func times(_ this: Matrix, _ that: Matrix) throws -> Matrix {
		try checkDimTimes(this,that)
		return doTimes(this,that)
	
	}

	static func times(_ this: Matrix, _ that: Double) throws -> Matrix {
		let out = Matrix(this.rows,this.columns)
		for i in 0 ..< this.rows {
			for j in 0 ..< this.columns {
				out[i,j] = this[i,j] * that
			}
		}
		return out		
	}

	static func div(_ this: Matrix, _ that: Double) throws -> Matrix {
		return try times(this,1.0/that)
	}

	internal static func checkDimAdd(_ this: Matrix, _ that: Matrix) throws{
		if(this.rows != that.rows){
			throw MatrixMathError.dimensionsDoNotMatch(this.rows,that.rows)
		}

		if(this.columns != that.columns){
			throw MatrixMathError.dimensionsDoNotMatch(this.columns,that.columns)
		}
	}

	internal static func checkDimTimes(_ this: Matrix, _ that: Matrix) throws{
		if(this.columns != that.rows){
			throw MatrixMathError.dimensionsDoNotMatch(this.columns,that.rows)
		}		
	}

	internal static func doPlus(_ this: Matrix,_ that: Matrix) -> Matrix {
		let out = Matrix(this.rows,this.columns)

		for i in 0 ..< this.rows {
			for j in 0 ..< this.columns {
				out[i,j] = this[i,j] + that[i,j]
			}
		}
		return out
	}

	internal static func doMinus(_ this: Matrix, _ that: Matrix) -> Matrix{
		let out = Matrix(this.rows,this.columns)

		for i in 0 ..< this.rows {
			for j in 0 ..< this.columns {
				out[i,j] = this[i,j] - that[i,j]
			}
		}
		return out
	}

	internal static func doTimes(_ this: Matrix, _ that: Matrix) -> Matrix {
		let out = Matrix(this.rows,that.columns)

		for i in 0 ..< this.rows {
			for j in 0 ..< that.columns {
				for k in 0 ..< that.rows {
					out[i,j] += this[i,k] * that[k,j]
				}
			}
		}
		return out
	}
}