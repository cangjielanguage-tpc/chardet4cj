// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//data_file:../util_test/utf8.txt
//data_file:../util_test/utf-16be.txt
//data_file:../util_test/utf-16le.txt

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer
from charset import charset.*

/* 
   public static func createReaderFromFile(file: File): BufferedInputStream
 */

@Test
public class ReaderFactoryTest {
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var dataLen:Int64  = 0

    var file_1:File = File("../util_test/utf8.txt",Open(true,false))
    var file_2:File = File("../util_test/utf-16be.txt",Open(true,false))
    var file_3:File = File("../util_test/utf-16le.txt",Open(true,false))


    @TestCase
    func testReaderFactory_createReaderFromFile_01():Unit{
        var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(file_1)
        dataLen = originalEncoding1.length
        println("dataLen:>>>>${dataLen}")
        @Assert(dataLen, 1768) 

        try{
            var originalEncoding3: BufferedInputStream = ReaderFactory.createReaderFromFile(file_3) //默认编码为utf8
            dataLen = originalEncoding3.length
        }catch(e2:Exception){
            println("e2:>>>>${e2}")
            returnFlag = 2
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testReaderFactory_createReaderFromFile_02():Unit{
        returnFlag = -1
        try{
            var file_1:File = File("../../../util_test/utf8_16.txt",Open(true,false)) //文件路径不存在
            var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(file_1)
        }catch(e1:Exception){
            @Assert(e1.toString().contains("FSException: The path"), true) // FSException: The path `../../../util_test` does not exist.
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testReaderFactory_createReaderFromFile_03():Unit{
        returnFlag = -1
        var file_1:File = File("../util_test/utf8.txt",Append) //文件不可读,只有写权限
        try{
            var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(file_1)
        }catch(e1:Exception){
            // println("e31:>>>>${e1}")
            @Assert(e1.toString().contains("Exception: this inputStream is Empty"), true) 
            returnFlag = 0
        }

        @Assert(returnFlag, 0)
    }

}
