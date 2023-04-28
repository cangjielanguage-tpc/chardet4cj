// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//data_file:../util_test/utf8.txt
//data_file:../util_test/utf-16be.txt
//data_file:../util_test/utf-16le.txt
//data_file:../util_test/utf-16le.cj
//data_file:../util_test/iso_2022_cn.txt

/* 
public init (listener: ?CharsetListener)
public init()
public static func detectCharset(file: File): String
 */

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

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
    func testUniversalDetector_detectCharsetByFile_01():Unit{
        // public static func detectCharset(file: File): String
        try{
            resStr = UniversalDetector.detectCharset(file_1) // UTF-8
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:>> ${resStr}")
        @Assert(resStr, "UTF-8")

        // public func getDetectedCharset(): String
        resStr = detector.getDetectedCharset() // kong
        @Assert(resStr, "")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByFile_02():Unit{
        returnFlag = -1
        // public static func detectCharset(path: Path): String
        try{
            var file2_1:File = File("../util_test/utf-16be.py",Open(true,false))
            resStr = UniversalDetector.detectCharset(file2_1) // UTF-16BE
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            @Assert(e1.toString().contains("FSException: The file does not exist!"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByFile_03():Unit{
        returnFlag = -1
        try{
            resStr = UniversalDetector.detectCharset(file_2) // UTF-16BE
        }catch(e1:Exception){
            println("e3_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:3>> ${resStr}")
        @Assert(resStr, "UTF-16BE")

        try{
            var file3_1:File = File("../util_test/仓颉utf-16be.txt",Open(true,false))//文件不存在
            resStr = UniversalDetector.detectCharset(file3_1) 
        }catch(e2:Exception){
            println("e3_2:>> ${e2}")
            @Assert(e2.toString().contains("FSException: The file does not exist!"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByFile_04():Unit{
        returnFlag = -1
        resStr = UniversalDetector.detectCharset(file_3) // UTF-16LE
        @Assert(resStr, "UTF-16LE")
        try{
            var file4_1:File = File("../util_test/utf-16le.txt",Open(false,false))
            resStr = UniversalDetector.detectCharset(file4_1) 
        }catch(e1:Exception){
            println("e4_1:>> ${e1}")
            @Assert(e1.toString().contains("FSException: The file does not have the read permission"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUniversalDetector_detectCharsetByFile_05():Unit{
        returnFlag = 0
        var file5_1:File = File("../util_test/iso_2022_cn.txt",Open(true,false)) // iso_2022_cn.txt 的中文字符经java检测为UTF-8
        try{
            resStr = UniversalDetector.detectCharset(file5_1) // UTF-8  对标java
        }catch(e1:Exception){
            println("e4_1:>> ${e1}")
            returnFlag = 1
        }
        @Assert(resStr, "UTF-8")

        @Assert(returnFlag, 0)
    }

}

