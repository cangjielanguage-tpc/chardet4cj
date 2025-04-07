// 3rd_party_lib:chardet4cj/build/release/chardet4cj
// 3rd_party_lib:chardet4cj/build/release/charset
// 3rd_party_lib_ohos:chardet4cj/build/release/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/release/aarch64-linux-ohos/charset

//data_file:../util_test/utf8.txt
import std.fs.*
import std.io.*
import chardet4cj.*
import charset4cj.charset.*

var returnFlag1: Int64 = -1
var dataLen: Int64 = 0

@When[os == "Linux"]
func exception(file_1:File):Unit{
        try {
            var originalEncoding2: File = ReaderFactory.createReaderFromFile(file_1, Charsets.UTF16BE)
            dataLen = originalEncoding2.length
        } catch (e1: ChardetException) {
            @Assert(e1.toString().contains("ChardetException: this inputStream is empty"), true)
            returnFlag1 = 0
        }
}

@When[os == "Windows"]
func exception(file_1:File):Unit{
        try {
            var originalEncoding2: File = ReaderFactory.createReaderFromFile(file_1, Charsets.UTF16BE)
            dataLen = originalEncoding2.length
        } catch (e1: FSException) {
            @Assert(e1.toString().contains("FSException: The file not opened, can not to read"), true)
            returnFlag1 = 0
        }
}


@Test
public class ReaderFactoryTest {
    var returnFlag: Int64 = -1

    @TestCase
    func testReaderFactory_createReaderFromFile_01(): Unit {
        var file_1: File = File("../util_test/utf8.txt", Open(true, false)) //文件utf8格式
        var originalEncoding1: File = ReaderFactory.createReaderFromFile(file_1, Charsets.UTF8)
        dataLen = originalEncoding1.length
        @Assert(dataLen, 1768)
        exception(file_1)
        @Assert(returnFlag1, 0)
    }

    @TestCase
    func testReaderFactory_createReaderFromFile_02(): Unit {
        returnFlag = -1
        try {
            var file_1: File = File("../util_test/utf8_0000.cj", Open(true, false)) //文件路径不存在
            ReaderFactory.createReaderFromFile(file_1, Charsets.UTF8)
        } catch (e1: FSException) {
            @Assert(e1.toString().contains("FSException: The file does not exist or permission denied!"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }
}
