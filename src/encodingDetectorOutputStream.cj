package chardet4cj

public class EncodingDetectorOutputStream <: OutputStream {
    private var out: OutputStream
    private let detector: UniversalDetector =  UniversalDetector()
    private var outputStreamClosed: Bool = false

    public init(out: OutputStream) {
        super()
        this.out = out
    }

    private func closed(): Unit {
        if (outputStreamClosed) {
            throw Exception("this output stream close")
        }
    }

    public func close(): Unit{
        this.outputStreamClosed = true
        detector.dataEnd()
    }

    public func flush(): Unit {
        out.flush()
    }

    private func write(b: Array<UInt8>, off: Int64,  len: Int64): Unit {
        this.closed()
        out.write(b)
        if (!detector.isDone()) {
            detector.handleData(b, Int32(off), Int32(len))
        }
    }

    public func write(b: Array<UInt8>): Unit {
        this.write(b,0, b.size)
    }

    public func write(b: Int32): Unit {
        this.closed()
        this.write(Array<Byte>([UInt8(b)]))
    }

    public func getDetectedCharset(): String {
        return detector.getDetectedCharset()
    }
    
}
