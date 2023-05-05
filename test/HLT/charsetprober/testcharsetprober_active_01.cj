// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

@Test
public class ChardetTest {
    var charsetp: CharsetProber = UTF8Prober()
    var tag: Bool = false
    @TestCase
    func testCharsetProber_Active_01():Unit{
       /*  public func isActive(): Bool */
        tag = charsetp.isActive()
        println("tag:1:>> ${tag}")
        @Assert(tag, true)
        /* public func getCharSetName(): String */
        var strRes:String = charsetp.getCharSetName()
        @Assert(strRes, "UTF-8")
        /* public func setActive(active: Bool): Unit */
        charsetp.setActive(1 > 0)
        tag = charsetp.isActive()
        @Assert(tag, true)
        charsetp.setActive(false)
        tag = charsetp.isActive()
        println("tag:3:>> ${tag}")
        @Assert(tag, false)
        strRes = charsetp.getCharSetName()
        @Assert(strRes, "UTF-8")
    }

}
