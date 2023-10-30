// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset
//data_file:../util_test/iso_2022_cn.txt
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
    func test_detectCharset_ISO_2022_CN(): Unit {
        returnFlag = 0
        var file5_1: File = File("../util_test/iso_2022_cn.txt", Open(true, false)) // iso_2022_cn.txt 的中文字符经java检测为UTF-8
        try {
            resStr = UniversalDetector.detectCharset(file5_1) // UTF-8  对标java
        } catch (e1: ChardetException) {
            returnFlag = 1
        }
        @Assert(resStr, "UTF-8")
        @Assert(returnFlag, 0)
    }
}
