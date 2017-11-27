public protocol IPostureEntry {
    var accX: Int16 {get set}
    var accY: Int16 {get set}
    var accZ: Int16 {get set}
    var gyrX: Int16 {get set}
    var gyrY: Int16 {get set}
    var gyrZ: Int16 {get set}
    var phi: Int16 {get set}
    var psi: Int16 {get set}
    var theta: Int16 {get set}

    var p2p: Double {get set}
    var posture: Double {get set}
    var postureLbl: String {get set}
}
