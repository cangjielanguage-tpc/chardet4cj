// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class EncodingDetectorInputStreamTest {
    var enterStream:ByteArrayStream = ByteArrayStream()
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = 0
    var res: Int64 = 0

    @TestCase
    func testEncodingDetectorInputStream_read_01():Unit{
        var bufdata: Array<Byte> = "testEncodingDetectorInputStream_read_01".toUtf8Array()
        enterStream.write(bufdata)
        var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(enterStream)
        // public func available(): Int32
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 
        // public func read(b: Array<Byte>): Int64
        res = inputStream.read(bufdata)  // 39
        // println("res:>> ${res}")
        @Assert(res, 39) 

        var bufdata_2: Array<Byte> = [116, 101, 115, 116, 69, 110, 99, 111, 100, 105, 110, 103, 68] // bufdata的子集
        try{
            res = inputStream.read(bufdata_2)  // 0 
        }catch(e1:Exception){
            // println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("Exception: this input is Empty"), true)
            returnFlag = 0
        }
        inputStream.close()

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorInputStream_read_02():Unit{
        returnFlag = -1
        var bufdata: Array<Byte> = "testEncodingDetectorInputStream_read_01".toUtf8Array()
        enterStream.write(bufdata)
        var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(enterStream)

        try{
            res = inputStream.read(Array<Byte>())   // 
        }catch(e1:Exception){
            // println("e2:>>>>${e1}")
            @Assert(e1.toString().contains("Exception: this buf is Empty"), true)
            returnFlag = 0
        }

        var bufdata_2: Array<Byte> = [116, 101, 115, 116, 69, 110, 99, 111, 100, 105, 110, 103, 68, 49] // bufdata的子集
        res = inputStream.read(bufdata_2)  // 14
        // println("res:>> ${res}")
        @Assert(res, 14) 
        inputStream.close()

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorInputStream_read_03():Unit{
        returnFlag = -1
        var inputStream_3: EncodingDetectorInputStream = EncodingDetectorInputStream(ByteArrayStream()) // 缓冲区为空
        var bufdata_2: Array<Byte> = [116, 101, 115, 116, 69, 110, 99, 111, 100, 105, 110, 103, 68, 49] // bufdata的子集
        try{
            res = inputStream_3.read(bufdata_2)  
        }catch(e1:Exception){
            // println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("Exception: this input is Empty"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

}

