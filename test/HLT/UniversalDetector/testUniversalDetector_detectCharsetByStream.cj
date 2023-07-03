// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset

//data_file:../util_test/utf8.txt
//data_file:../util_test/utf-16be.txt
//data_file:../util_test/utf-16le.txt
//data_file:../util_test/utf-16le.cj

/* 
public init (listener: ?CharsetListener)
public init()
public static func detectCharset(inputStream: InputStream): String
 */

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class UniversalDetectorTest {
    var detector: UniversalDetector = UniversalDetector()
    var enterStream:ByteArrayStream = ByteArrayStream()
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var resStr: String = ""

    var file_1:File = File("../util_test/utf8.txt",Open(true,false))
    var file_2:File = File("../util_test/utf-16be.txt",Open(true,false))
    var file_3:File = File("../util_test/utf-16le.txt",Open(true,false))


    @TestCase
    func testUniversalDetector_detectCharsetByStream_01():Unit{
        // public static func detectCharset(inputStream: InputStream): String
        var bufdata: Array<Byte> = "testUniversalDetector_detectCharsetByStream_01".toUtf8Array()
        enterStream.write(bufdata)
        let unicodeBOMInputStreamIns_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream)
        try{
            resStr = UniversalDetector.detectCharset(unicodeBOMInputStreamIns_1) // US-ASCII
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr1:>> ${resStr}")
        // @Assert(resStr, "UTF-16BE")

        // public func getDetectedCharset(): String
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        @Assert(returnFlag, 0)

    }

    @TestCase
    func testUniversalDetector_detectCharsetByStream_02():Unit{
        returnFlag = -1
        let byteArrayStreamIns_1:ByteArrayStream = ByteArrayStream()// 缓冲区为空
        try{
            resStr = UniversalDetector.detectCharset(byteArrayStreamIns_1) 
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByStream_03():Unit{
        returnFlag = -1
        var enterStream_1:ByteArrayStream = ByteArrayStream()
        var bufdata: Array<Byte> = "testUniversalDetector_detectCharsetByStream_03".toUtf8Array()
        var inputStream: EncodingDetectorInputStream = EncodingDetectorInputStream(enterStream_1)
        println("enterStream_1:>> ${enterStream_1.length}")
        try{
            resStr = UniversalDetector.detectCharset(inputStream) 
        }catch(e1:Exception){
            @Assert(e1.toString().contains("Exception: this input is Empty"), true)
            returnFlag = 0
        }
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }


}

