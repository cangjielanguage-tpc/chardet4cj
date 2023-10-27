// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class EncodingDetectorInputStreamTest {
    var enterStream:ByteArrayStream = ByteArrayStream()
    // public init(input: InputStream)
    
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = -1
    var res: Int64 = 0

    @TestCase
    func testEncodingDetectorInputStream_skip_01():Unit{
        returnFlag = 0
        var bufdata: Array<Byte> = "testEncodingDetectorInputStream_read_01".toUtf8Array()
        enterStream.write(bufdata)
        var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(enterStream)
        // public func available(): Int32
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 

        

        // public func skip(n: Int64): Int64
        try{
            res = inputStream.skip(0)  // -1
        }catch(e1:ChardetException){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }
        @Assert(res, -1) 

        res = inputStream.skip(4)  // 3
        println("res:>> ${res}")
        @Assert(res, 3) 

        try{
            res = inputStream.skip(-5)  // 
        }catch(e2:ChardetException){
            println("e2:>>>>${e2}")
            returnFlag = 2
        }
        @Assert(res, -1) 

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorInputStream_skip_02():Unit{
        returnFlag = -1
        var enterStream:ByteArrayStream = ByteArrayStream()

        var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(enterStream) // 缓冲区为空
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 
        println("enterStream:>>>>${enterStream.length}")

        try{
            res = inputStream.skip(5)  //  异常 ？？
        }catch(e2:ChardetException){
            println("e2:>>>>${e2}") 
            @Assert(e2.toString().contains("ChardetException: this input is empty"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

}

