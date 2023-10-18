// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//data_file:../util_test/utf8.txt
//data_file:../util_test/utf-16be.txt
//data_file:../util_test/utf-16le.txt
//data_file:../util_test/utf-16le.cj

/* 
public init (listener: ?CharsetListener)
public init()
public static func detectCharset(path: Path): String
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

    var file_1:File = File("../util_test/utf8.txt",Open(true,false))
    var file_2:File = File("../util_test/utf-16be.txt",Open(true,false))
    var file_3:File = File("../util_test/utf-16le.txt",Open(true,false))


    @TestCase
    func testUniversalDetector_detectCharsetByPath_01():Unit{
        let path_1:Path = Path("../util_test/utf-16be.txt")
        // public static func detectCharset(path: Path): String
        try{
            resStr = UniversalDetector.detectCharset(path_1) // UTF-16BE
        }catch(e1:ChardetException){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:>> ${resStr}")
        @Assert(resStr, "UTF-16BE")

        // public func getDetectedCharset(): String
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        @Assert(returnFlag, 0)

    }

    @TestCase
    func testUniversalDetector_detectCharsetByPath_02():Unit{
        let path_1:Path = Path("../util_test/utf-16le.cj") //对文件格式不做校验
        // public static func detectCharset(path: Path): String
        try{
            resStr = UniversalDetector.detectCharset(path_1) // UTF-16LE
        }catch(e1:ChardetException){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:>> ${resStr}")
        @Assert(resStr, "UTF-16LE")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByPath_03():Unit{
        let path_1:Path = Path("../util_test/utf8.txt") 
        // public static func detectCharset(path: Path): String
        try{
            resStr = UniversalDetector.detectCharset(path_1) // UTF-8
        }catch(e1:ChardetException){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        @Assert(resStr, "UTF-8")

        let path_2:Path = Path("../util_test/utf8我不在.docx") //文件不存在
        // public static func detectCharset(path: Path): String
        try{
            resStr = UniversalDetector.detectCharset(path_2) 
        }catch(e2:FSException){
            println("e2_2:>> ${e2}")
            @Assert(e2.toString().contains("FSException: The file does not exist or permission denied!"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

}

