package chardet4cj

from std import io.*
from std import math.*

public class EncodingDetectorInputStream <: InputStream {

    private var input: InputStream
    private let detector: UniversalDetector = UniversalDetector()
    private var streamClosed: Bool = false

    public init(input: InputStream) {
        this.input = input
    }

    public func available(): Int32 {
        return 0
    }

    private func closed(): Unit {
        if (streamClosed) {
            throw Exception("this input stream close")
        }
    }

    public func close(): Unit {
        this.streamClosed = true
    }

    public func mark(readlimit: Int32): Unit {
        if (readlimit !=  0) {
            throw Exception("mark is not null")
        }
    }

    public func markSupported(): Bool {
        return false
    }

    public func read(): Int64 {
        var data: Array<Byte> = Array<Byte>(input.length, item: 0)
        var nrOfBytesRead: Int64 = this.read(data,0,1)
        if (nrOfBytesRead > 0){
            return Int64(data[0])
        }
        return -1
    }

    private func read(b: Array<Byte>, off: Int64, len: Int64): Int64 {
        this.closed()
        if (this.input.length == 0) {
            throw Exception("this input is Empty")
        }
        if (b.size == 0) {
            throw Exception("this buf is Empty")
        }
        let nrOfBytesRead: Int64 = input.read(b)
        if (!detector.isDone() && nrOfBytesRead > 0) {
            detector.handleData(b, Int32(off), Int32(nrOfBytesRead))
        }
        if (nrOfBytesRead == 0) {
            detector.dataEnd()
        }
        return nrOfBytesRead
    }

    public func read(b: Array<Byte>): Int64 {
        return this.read(b, 0, b.size)
    }

    public func reset(): Unit {
        throw Exception("mark/reset not supported")
    }

    public func skip(n: Int64): Int64{
        this.closed()
        if (this.input.length == 0) {
            throw Exception("this input is Empty")
        }
        if (detector.isDone()) {
            return skip(this.input,n)
        }
        else {
            var lastRead: Int64 = 0
            var count: Int64 = -1
            var i: Int64 = 0
            var temp = Array<Byte>(1,item:0)
            while ( i < n && lastRead >= 0) {
                if (this.input.read(temp) < 1) {
                    throw Exception("read failed")
                }
                lastRead = Int64(temp[0])
                count++
                i++
            }        
            return count;
        }
    }

    public func getDetectedCharset(): String{
        return detector.getDetectedCharset();
    }

}

func skip(input: InputStream,n: Int64): Int64 {
    let  MAX_SKIP_BUFFER_SIZE = 2048
    var remaining: Int64 = n
    var nr: Int64

    if (n <= 0) { 
        return 0;
    }

    var size: Int64 = min(MAX_SKIP_BUFFER_SIZE, remaining);
    var skipBuffer: Array<Byte> = Array<Byte>(min(size, remaining), item: 0)
    while (remaining > 0) {
        nr = input.read(skipBuffer)
        if (nr < 0) {
            break;
        }
        remaining -= nr
    }

    return n - remaining;
}