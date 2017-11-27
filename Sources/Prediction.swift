class Predicition : IPostureEntry{
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

    init(_ posture: Double, _ postureLbl: String = ""){
        self.accX = Int16(0)
        self.accY = Int16(0)
        self.accZ = Int16(0)
        self.gyrX = Int16(0)
        self.gyrY = Int16(0)
        self.gyrZ = Int16(0)
        self.phi = Int16(0)
        self.theta = Int16(0)
        self.psi = Int16(0)
        self.p2p = 0.0
        self.posture = posture
        self.postureLbl = postureLbl
    }


}