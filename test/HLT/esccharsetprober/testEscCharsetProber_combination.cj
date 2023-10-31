// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj
from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

@Test
public class EscCharsetProberTest {
    var charsetp: EscCharsetProber = EscCharsetProber()
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = -1
    var res: Int64 = 0
    @TestCase
    func testEscCharsetProber_combination_01(): Unit {
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        var bytebuf_1: ByteBuffer = charsetp.filterWithoutEnglishLetters(bufdata, 0, Int32(bufdata.size - 10))
        let str: String = bytebuf_1.toString()
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=35 cap=35]")
        var strRes: String = charsetp.getCharSetName() 
        @Assert(strRes, "") 
        var confidence: Float32 = charsetp.getConfidence()
        @Assert(confidence, 0.990000)
        var state: ProbingState = charsetp.getState() 
        @Assert(state.toString(), "DETECTING")
        charsetp.reset()
        state = charsetp.getState() 
        @Assert(state.toString(), "DETECTING")
    }
}
