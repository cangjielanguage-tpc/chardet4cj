// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//data_file:../util_test/utf8.txt
//data_file:../util_test/utf-16be.txt
//data_file:../util_test/utf-16le.txt
from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from charset import charset.*

@Test
public class ReaderFactoryTest {
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var dataLen: Int64 = 0
    var file_1: File = File("../util_test/utf8.txt", Open(true, false))
    var file_2: File = File("../util_test/utf-16be.txt", Open(true, false))
    var file_3: File = File("../util_test/utf-16le.txt", Open(true, false))

    @TestCase
    func testReaderFactory_createBufferedReader_01(): Unit {
        var originalEncoding1: File = ReaderFactory.createBufferedReader(file_1)
        dataLen = originalEncoding1.length
        @Assert(dataLen, 1768)

        try {
            var originalEncoding2: File = ReaderFactory.createBufferedReader(file_2) //默认编码为utf8
            dataLen = originalEncoding2.length
        } catch (e1: FSException) {
            returnFlag = 1
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testReaderFactory_createBufferedReader_02(): Unit {
        returnFlag = -1
        try {
            var file_1: File = File("../../../util_test/utf8_16.txt", Open(true, false)) //文件路径不存在
            ReaderFactory.createBufferedReader(file_1)
        } catch (e1: FSException) {
            @Assert(e1.toString().contains("FSException: The path"), true) // FSException: The path `../../../util_test` does not exist.
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testReaderFactory_createBufferedReader_03(): Unit {
        returnFlag = -1
        var file_1: File = File("../util_test/utf8.txt", Open(false, false)) //文件不可读
        try {
            ReaderFactory.createBufferedReader(file_1)
        } catch (e1: FSException) {
            @Assert(e1.toString().contains("FSException: The file does not have the read permission."), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }
}
