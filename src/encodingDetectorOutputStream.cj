package chardet4cj

public class EncodingDetectorOutputStream <: OutputStream {
    private var out: OutputStream
    private let detector: UniversalDetector =  UniversalDetector()
    
    public init(out: OutputStream) {
        super()
        this.out = out
    }

    public func close(): Unit{
        detector.dataEnd();
    }

    public func flush(): Unit {
        out.flush();
    }

    private func write(b: Array<UInt8>, off: Int64,  len: Int64): Unit {
        out.write(b);
        if (!detector.isDone()) {
            detector.handleData(b, off, len);
        }
    }

    public func write(b: Array<UInt8>): Unit {
        this.write(b,0, b.size);
    }

    public func write(b: Int32): Unit {
        this.write(Array<Byte>([UInt8(b)]));
    }

    public func getDetectedCharset(): String {
        return detector.getDetectedCharset();
    }
    
}
