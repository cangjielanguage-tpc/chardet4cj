// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

/* 
public func write(b: Int32): Unit
public func write(b: Array<UInt8>): Unit
 */

@Test
public class EncodingDetectorOutputStreamTest {
    var enterStream:ByteArrayStream = ByteArrayStream()
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = -1
    var res: Int64 = 0
    var bufdata_2: Array<Byte> = [116, 101, 115, 116, 69, 110, 99, 111, 100, 105, 110, 103, 68, 49]

    @TestCase
    func testEncodingDetectorOutputStream_write_01():Unit{
        var bufdata: Array<Byte> = "testEncodingDetectorInputStream_read_01".toUtf8Array()
        enterStream.write(bufdata)
        println("bufdata:>> ${bufdata.size}")
        @Assert(bufdata.size, 39)

        var outputStream: EncodingDetectorOutputStream = EncodingDetectorOutputStream(enterStream)
        // public func write(b: Int32): Unit
        outputStream.write(12)  
        res = enterStream.length //40
        println("res:>> ${res}")
        @Assert(res, 40) 

        // public func write(b: Array<UInt8>): Unit
        outputStream.write(bufdata_2)
        res = enterStream.length 
        @Assert(res, 54) 

        try{
            outputStream.write(256) // 超出UInt8范围
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("OverflowException: typecast"), true)
            res = 0
            if(res != 0){
                returnFlag = 1
            }
        }

        outputStream.close() 
        try{
            outputStream.write(12) // 流已经关闭，预期抛异常
        }catch(e2:Exception){
            println("e2:>>>>${e2}")
            // @Assert(e1.toString().contains("mark/reset not supported"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorOutputStream_write_02():Unit{
        var bufdata: Array<Byte> = "testEncodingDetectorOutputStream_write_02".toUtf8Array()
        @Assert(bufdata.size, 41)

        var out = ByteArrayStream()
        var outputStream2: EncodingDetectorOutputStream = EncodingDetectorOutputStream(out)
        outputStream2.flush()
        // public func write(b: Int32): Unit
        outputStream2.write(12)  
        res = out.length //1
        @Assert(res, 1) 

        outputStream2.write(bufdata)
        res = out.length  // 15
        @Assert(res, 42) 

    }
}

