public class Matrix : CustomStringConvertible, Equatable{
	var data: [[Double]]

	convenience init(){
		self.init(0,0)
	}

	init(_ nrows:Int, _ ncols:Int){
		data = [[Double]]()
		for _ in 0 ..< nrows {
			var row = [Double]()
			for _ in 0 ..< ncols{
				row.append(0)
			}
			data.append(row)
		}
	}
	
	init(_ data:[[Double]]){
		self.data = data
	}

	init(_ data:[[Int]]){
		var dataDouble = [[Double]]()
		for row in data {
			var rowDouble = [Double]()
			for element in row {
				rowDouble.append(Double(element))
			}
			dataDouble.append(rowDouble)
		}
		
		self.data = dataDouble
	}

	init(_ data:[[Int16]]){
		var dataDouble = [[Double]]()
		for row in data {
			var rowDouble = [Double]()
			for element in row {
				rowDouble.append(Double(element))
			}
			dataDouble.append(rowDouble)
		}
		
		self.data = dataDouble
	}

	convenience init(_ matrix: Matrix){
		self.init(matrix.array())
	}

	convenience init(_ objects: [Vectorizable]){
		var m = Matrix(objects.count,objects[0].toVector.columns)
		for i in 0 ..< objects.count{
			m[i,0 ..< m.columns] = objects[i].toVector
		}
		self.init(m)
	}

	public subscript(_ idxs: [Int]) -> Matrix {
		var submatrix = Matrix(idxs.count,self.columns)
		for i in 0 ..< idxs.count {
			submatrix[i,0 ..< self.columns] = self[idxs[i]]
		}
		return submatrix
	}

	public subscript(_ i: Int, _ j: Int) -> Double {
	  get {
	    return data[i][j]
	  }
	  set {
	    data[i][j] = newValue
	  }
	}

	public subscript(_ i: Int) -> Matrix {
	  get {
	    return Matrix([data[i]])
	  }
	  set {
	  	for j in 0 ..< self.columns{
	  		self[i,j] = newValue[0,j]
	  	}
	  }
	}

	public subscript(_ ir: CountableRange<Int>) -> Matrix {
	  get {
	  	var l = [[Double]]()
	  	for i in ir{
	  		l.append(self[i].array()[0])
	  	}
	    return Matrix(l)
	  }	
	  set {
	  	var n = 0
	  	for i in ir{
	  		self[i] = newValue[n]
	  		n += 1
	  	}
	  }
	}

	public subscript(_ i: Int, _ r: CountableClosedRange<Int>) -> Matrix {
	  get {
	  	let out:Matrix = Matrix(1,r.count)
	    for j in r{
	    	out[0,j] = self[i,j]
	    }
	    return out
	  }
	  set {
	  	for j in r{
	    	self[i,j] = newValue[0,j]
	    }
	  }
	}

	public subscript(_ i: Int, _ r: CountableRange<Int>) -> Matrix {
	  get {
	  	let out:Matrix = Matrix(1,r.count)
	    for j in r{
	    	out[0,j] = self[i,j]
	    }
	    return out
	  }
	  set {
	    for j in r{
	    	self[i,j] = newValue[0,j]
	    }
	  }
	}

	public subscript(_ r: CountableClosedRange<Int>, _ j: Int) -> Matrix {
	  get {
	  	let out:Matrix = Matrix(r.count,1)
	    for i in r{
	    	out[i,0] = self[i,j]
	    }
	    return out
	  }
	  set {
	  	for i in r{
	    	self[i,j] = newValue[i,0]
	    }
	  }
	}

	public subscript(_ r: CountableRange<Int>, _ j: Int) -> Matrix {
	  get {
	  	let out:Matrix = Matrix(r.count,1)
	    for i in r{
	    	out[i,0] = self[i,j]
	    }
	    return out
	  }
	  set {
	    for i in r{
	    	self[i,j] = newValue[i,0]
	    }
	  }
	}

	public var rows:Int{
		return data.count
	}

	public var columns:Int{
		if(self.rows > 0){
			return data[0].count
		}else{
			return 0
		}
	}

	public var description : String{
		var s = String()
		for i in 0 ..< self.rows {
			s += "\n"
			for j in 0 ..< self.columns {
				s += "|\(self[i,j])"
			}
			s += "|"
		}
		return s
	}

	public static func ==(this: Matrix, that: Matrix) -> Bool {
        for i in 0..<this.rows{
			for n in 0..<that.columns{
				if(this[i,n] != that[i,n]){
					return false
				}
			}
		}
		return true
    }

    public var T:Matrix{
    	let transposed = Matrix(self.columns,self.rows)
    	for i in 0 ..< self.rows {
			for j in 0 ..< self.columns {
				transposed[j,i] = self[i,j]
			}
		}
		return transposed
    }

    public func rmColumn(_ j: Int){
    	for i in 0 ..< self.rows {
    		data[i].remove(at:j)
    	}
    }

    public func rmRow(_ i: Int){
    	data.remove(at:i)
    }

    public func array()-> [[Double]]{
    	let deepCopy = data
    	return deepCopy
    }
	
}