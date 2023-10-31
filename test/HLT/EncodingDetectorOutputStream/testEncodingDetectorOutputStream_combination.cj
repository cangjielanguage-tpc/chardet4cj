// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj
from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

@Test
public class EncodingDetectorOutputStreamTest {
    var outputStream: EncodingDetectorOutputStream = EncodingDetectorOutputStream(ByteArrayStream())
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = -1
    var res: Int64 = 0

    @TestCase
    func testEncodingDetectorOutputStream_01(): Unit {
        returnFlag = 0
        var charset: String = outputStream.getDetectedCharset()
        @Assert(charset, "")
        outputStream.write(12)
        outputStream.flush()
        outputStream.close()
        try {
            charset = outputStream.getDetectedCharset()
        } catch (e1: ChardetException) {
            returnFlag = 1
        }
        @Assert(charset, "")
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testEncodingDetectorOutputStream_02(): Unit {
        returnFlag = 0
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
        var out = ByteArrayStream()
        out.write(bufdata)
        var outputStream: EncodingDetectorOutputStream = EncodingDetectorOutputStream(out)
        var charset: String = outputStream.getDetectedCharset()
        @Assert(charset, "")
        try {
            outputStream.flush()
        } catch (e1: ChardetException) {
            returnFlag = 1
        }
        @Assert(returnFlag, 0)
    }
}
