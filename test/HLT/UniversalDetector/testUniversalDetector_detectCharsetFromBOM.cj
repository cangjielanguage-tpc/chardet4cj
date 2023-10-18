// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset


/* 
public init (listener: ?CharsetListener)
public init()
public static func detectCharsetFromBOM(buf: Array<Byte>): String
 */

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class UniversalDetectorTest {
    var detector: UniversalDetector = UniversalDetector()
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var resStr: String = ""

    @TestCase
    func testUniversalDetector_detectCharsetFromBOM_01():Unit{
        var bufdata: Array<Byte> = "testUniversalDetector_detectCharsetFromBOM_01".toUtf8Array()
        try{
            resStr = UniversalDetector.detectCharsetFromBOM(bufdata)
        }catch(e1:ChardetException){
            println("e1:>> ${e1}")
            returnFlag = 1
        }
        // public func dataEnd()
        detector.dataEnd()
        @Assert(resStr, "")

        // public func getDetectedCharset(): String
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        // public func reset()
        detector.reset() // 重置检测器
        @Assert(returnFlag, 0)

    }

    @TestCase
    func testUniversalDetector_detectCharsetFromBOM_02():Unit{
        var bufdata: Array<Byte> = "testUniversalDetector_detectCharsetFromBOM_01".toUtf8Array()
        try{
            resStr = UniversalDetector.detectCharsetFromBOM(bufdata)
        }catch(e1:ChardetException){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:>> ${resStr}")
        // public func dataEnd()
        detector.dataEnd()
        @Assert(resStr, "")

        detector.reset() // 重置检测器
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        try{
            resStr = UniversalDetector.detectCharsetFromBOM(Array<Byte>()) // 源数据buf为空时，业务返回为空，无异常抛出
        }catch(e2:ChardetException){
            println("e2_2:>> ${e2}")
            returnFlag = 1
        }
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

}

