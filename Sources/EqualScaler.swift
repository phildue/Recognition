/**
 * Equal Scaler
 *
 * divide all values by its maximum on the training set
 * that way all features should be in the range of ~ 0..1
 */

public class EqualScaler : Scaler {
	
	var maximum = [Double]()
	var minimum = [Double]()

	public init(_ m: Matrix){
		self.train(m)
	}

	public init(){
		maximum = [Double]()
		minimum = [Double]()
	}

    public func train(_ m: Matrix){
		maximum = [Double]()
		minimum = [Double]()
		for j in 0 ..< m.columns{
			maximum.append( max(m[ 0 ..< m.rows, j]))
			minimum.append( -1*max(-1*m[ 0 ..< m.rows, j]))
		}
	}

    public func transform(_ m:Matrix)->Matrix{
        let m_transform = Matrix(m.rows,m.columns)

		for i in 0 ..< m.rows {
			for j in 0 ..< m.columns{
				m_transform[ i, j] = (m[ i, j]-minimum[j])/(maximum[j]-minimum[j])
			}
		}
			
		return m_transform
	}
}
