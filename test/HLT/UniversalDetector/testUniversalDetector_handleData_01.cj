// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

/* 
public init (listener: ?CharsetListener)
public init()
public func handleData(b: Array<Byte>)
public func handleData(buf: Array<Byte>, off: Int32, len: Int32)
 */

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class UniversalDetectorTest {
    var detector: UniversalDetector = UniversalDetector()
    var commonUtils_ins: CommonUtils = CommonUtils()
    // var out: ByteBuffer = ByteBuffer.allocate(Int64(length))
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var isDone: Bool = false
    var resStr: String = ""

    @TestCase
    func testUniversalDetector_handleData_01():Unit{
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        try{
            detector.handleData(bufdata)
        }catch(e1:Exception){
            println("e1:>> ${e1}")
            returnFlag = 1
        }
        
        // public func isDone(): Bool
        isDone = detector.isDone()
        @Assert(isDone, false)

        // public func getDetectedCharset(): String
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_handleData_02():Unit{
        var detector_2: UniversalDetector = UniversalDetector(Option<CharsetListener>.None)
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        try{
            detector_2.handleData(bufdata)
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        
        // public func isDone(): Bool
        isDone = detector_2.isDone()
        @Assert(isDone, false)

        // public func handleData(buf: Array<Byte>, off: Int32, len: Int32)
        detector_2.handleData(bufdata,0,10)
        resStr = detector_2.getDetectedCharset() // kong
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_handleData_03():Unit{
        returnFlag = -1
        var detector_3: UniversalDetector = UniversalDetector(Option<CharsetListener>.None)
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        // public func isDone(): Bool
        isDone = detector_3.isDone()
        @Assert(isDone, false)
        @Assert(bufdata.size, 45)

        // public func handleData(buf: Array<Byte>, off: Int32, len: Int32)
        try{
            detector_3.handleData(bufdata,46,3)
            resStr = detector_3.getDetectedCharset() 
        }catch(e1:Exception){
            println("e3_1:>> ${e1}")
            @Assert(e1.toString().contains("IndexOutOfBoundsException"), true)
            returnFlag = 0
        }
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_handleData_04():Unit{
        returnFlag = -1
        var detector_4: UniversalDetector = UniversalDetector(Option<CharsetListener>.None)
        var bufdata: Array<Byte> = Array<Byte>()
        @Assert(bufdata.size, 0)

        try{
            detector_4.handleData(bufdata,1,6)
            resStr = detector_4.getDetectedCharset() 
        }catch(e1:Exception){
            println("e4_1:>> ${e1}")
            @Assert(e1.toString().contains("Exception: this buf is Empty"), true)
            returnFlag = 0
        }
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

}

