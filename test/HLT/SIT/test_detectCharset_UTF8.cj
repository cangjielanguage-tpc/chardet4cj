// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset
//data_file:../util_test/utf8.txt

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

    @TestCase
    func test_detectCharset_UTF8():Unit{
        // public static func detectCharset(file: File): String
        try{
            resStr = UniversalDetector.detectCharset(file_1) // UTF-8
        }catch(e1:Exception){
            println("e2_1:>> ${e1}")
            returnFlag = 1
        }
        println("resStr:>> ${resStr}")
        @Assert(resStr, "UTF-8")

        @Assert(returnFlag, 0)
    }

}

