// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset

//data_file:../util_test/utf8.txt

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

from charset import charset.*

/* 
   public static func  createReaderFromFile(file: File, defaultCharset: Charset): BufferedInputStream
 */

@Test
public class ReaderFactoryTest {
    var returnFlag: Int64 = -1
    var res: Int32 = 0
    var dataLen:Int64  = 0

    @TestCase
    func testReaderFactory_createReaderFromFile_01():Unit{
        var file_1:File = File("../util_test/utf8.txt",Open(true,false)) //文件utf8格式
        var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(file_1,Charsets.UTF8)
        dataLen = originalEncoding1.length
        println("dataLen:>>>>${dataLen}")
        @Assert(dataLen, 1768) 

        try{
            var originalEncoding2: BufferedInputStream = ReaderFactory.createReaderFromFile(file_1,Charsets.UTF16BE) // 异常
            dataLen = originalEncoding2.length
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testReaderFactory_createReaderFromFile_02():Unit{
        returnFlag = -1
        try{
            var file_1:File = File("../util_test/utf8_0000.cj",Open(true,false)) //文件路径不存在
            ReaderFactory.createReaderFromFile(file_1,Charsets.UTF8)
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("FSException: The file does not exist or permission denied!"), true)
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

}
