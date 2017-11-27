public class RawSample : Vectorizable{
    var accX: Double
    var accY: Double
    var accZ: Double
    var gyrX: Double
    var gyrY: Double
    var gyrZ: Double
    var phi: Double
    var psi: Double
    var theta: Double
    
    public init(_ e: IPostureEntry){
    	
    	accX = Double(e.accX)
    	accY = Double(e.accY)
    	accZ = Double(e.accZ)
    	gyrX = Double(e.gyrX)
    	gyrY = Double(e.gyrY)
    	gyrZ = Double(e.gyrZ)
        phi = Double(e.phi)
        psi = Double(e.psi)
        theta = Double(e.theta)
    }

    public init( _ m: Matrix){
    	
    	accX = m[0,0]
    	accY = m[0,1]
    	accZ = m[0,2]
    	gyrX = m[0,3]
    	gyrY = m[0,4]
    	gyrZ = m[0,5]
        phi = m[0,6]
        psi = m[0,7]
        theta = m[0,8]    	
    }

	public var toVector:Matrix{
		return Matrix([[accX,accY,accZ,gyrX,gyrY,gyrZ,phi,psi,theta]])
	}

	}
