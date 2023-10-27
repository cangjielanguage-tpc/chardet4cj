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
    // public init(input: InputStream)
    var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(ByteArrayStream())
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = 0
    var res: Int64 = 0

    @TestCase
    func testEncodingDetectorInputStream_01():Unit{


        // public func available(): Int32
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 
        // public func close()
        inputStream.close()

        availableTag = inputStream.available() // 0
        @Assert(availableTag, 0) 
        // public func read(): Int64
        try{
            res = inputStream.read() // 
        }catch(e1:ChardetException){
            // println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("Exception: this input stream close"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorInputStream_02():Unit{
        // public func available(): Int32
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 
        // public func reset(): Unit
        try{
            inputStream.reset() 
        }catch(e1:ChardetException){
            // println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("mark/reset not supported"), true)
        }
        availableTag = inputStream.available() // 0
        @Assert(availableTag, 0) 
        // public func getDetectedCharset(): String
        var charset:String = inputStream.getDetectedCharset() // 
        // println("charset:>> ${charset}")
        @Assert(charset, "") 

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorInputStream_03():Unit{
        // public func mark(readlimit: Int32): Unit
        var availableTag:Int32 = inputStream.available() // 0代表可用
        @Assert(availableTag, 0) 
        // public func mark(readlimit: Int32): Unit
        try{
            inputStream.mark(12) // readlimit非0抛异常
        }catch(e1:ChardetException){
            // println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("mark is not null"), true)
        }
        // public func markSupported(): Bool
        var markTag:Bool = inputStream.markSupported() 
        @Assert(markTag, false) 
        inputStream.mark(0)
        // public func getDetectedCharset(): String
        var charset:String = inputStream.getDetectedCharset() // 
        @Assert(charset, "") 

        @Assert(returnFlag, 0)
    }

}

