// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class EncodingDetectorOutputStreamTest {
    // public init(out: OutputStream)
    var outputStream: EncodingDetectorOutputStream = EncodingDetectorOutputStream(ByteArrayStream())
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = -1
    var res: Int64 = 0

    @TestCase
    func testEncodingDetectorOutputStream_01():Unit{
        returnFlag = 0

        // public func getDetectedCharset(): String
        var charset:String = outputStream.getDetectedCharset() 
        @Assert(charset, "") 
        outputStream.write(12)  

        // public func flush(): Unit
        outputStream.flush()

        // public func close()
        outputStream.close() 
        try{
            charset = outputStream.getDetectedCharset() 
        }catch(e1:ChardetException){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }
        // println("charset:>>>>${charset}")
        @Assert(charset, "") 

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorOutputStream_02():Unit{
        returnFlag = 0
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        var out = ByteArrayStream()
        out.write(bufdata)
        var outputStream: EncodingDetectorOutputStream = EncodingDetectorOutputStream(out)
        // public func getDetectedCharset(): String
        var charset:String = outputStream.getDetectedCharset() 
        println("charset:>22> ${charset}")
        @Assert(charset, "") 

        try{
            outputStream.flush() 
        }catch(e1:ChardetException){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }

        @Assert(returnFlag, 0)
    }

}

