package chardet4cj

public class UniversalDetector {
    public static let  SHORTCUT_THRESHOLD: Float32 = 0.95
    public static let  MINIMUM_THRESHOLD: Float32 = 0.20

    func getDetectedCharset(): String {
        //TODO
        return ""
    }

    static func detectCharset(inputStream: InputStream): String {
        //TODO
        return ""
    }

    public func isDone(): Bool {
        //TODO
        return true
    }

    public func handleData(b: Array<Byte>, off: Int64, len: Int64){
        //TODO
    }

    public func dataEnd() {
        //TODO
    }
}