// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj
from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

@Test
public class ChardetTest {
    var charsetp: CharsetProber = UTF8Prober()
    var tag: Bool = false
    @TestCase
    func testCharsetProber_Active_01(): Unit {
        tag = charsetp.isActive()
        @Assert(tag, true)
        var strRes: String = charsetp.getCharSetName()
        @Assert(strRes, "UTF-8")
        charsetp.setActive(1 > 0)
        tag = charsetp.isActive()
        @Assert(tag, true)
        charsetp.setActive(false)
        tag = charsetp.isActive()
        @Assert(tag, false)
        strRes = charsetp.getCharSetName()
        @Assert(strRes, "UTF-8")
    }
}
