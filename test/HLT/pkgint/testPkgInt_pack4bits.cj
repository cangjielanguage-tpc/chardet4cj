// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset
from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

@Test
public class PkgIntTest {
    var returnFlag: Int64 = 0
    var res: Int32 = 0

    @TestCase
    func testPkgInt_pack4bits_01(): Unit {
        res = PkgInt.pack4bits(Int32(0), Int32(2), Int32(0), Int32(0), Int32(-2), Int32(0), Int32(25654), Int32(0)) // -131040
        @Assert(res, -131040)

        try {
            res = PkgInt.pack4bits(Int32(0), Int32(0), Int32(0), Int32(0), Int32(0), Int32(0), Int32(0), Int32(0)) // 0
        } catch (e1: ChardetException) {
            returnFlag = 1
        }
        @Assert(res, 0)

        try {
            res = PkgInt.pack4bits(Int32(2), Int32(0), Int32(25654), Int32(0), Int32(25654), Int32(0), Int32(-2),
                Int32(-231)) 
        } catch (e2: ChardetException) {
            returnFlag = 2
        }
        @Assert(res, -25807358)
        @Assert(returnFlag, 0)
    }
}
