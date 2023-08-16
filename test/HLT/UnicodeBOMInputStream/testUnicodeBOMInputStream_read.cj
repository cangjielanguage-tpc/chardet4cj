// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

/* 
    public init(inputStream: InputStream)
    public init(inputStream: InputStream, skipIfFound: Bool) 
*/

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class UnicodeBOMInputStreamTest {
    var enterStream:ByteArrayStream = ByteArrayStream()
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var resStr: String = ""
    var resData: Array<Byte> = Array<Byte>()

    @TestCase
    func testUnicodeBOMInputStream_read_01():Unit{
        var bufdata: Array<Byte> = "testUnicodeBOMInputStream_read_01".toUtf8Array()
        enterStream.write(bufdata)
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream)
        @Assert(bufdata.size, 33)
        // public func read(buffer: Array<Byte>)
        ins_1.read(bufdata)
        res = bufdata.size // 33 
        println("res:>> ${res}")
        @Assert(res, 33) 

    }

    @TestCase
    func testUnicodeBOMInputStream_read_02():Unit{
        returnFlag = -1
        var bufdata: Array<Byte> = "testUnicodeBOMInputStream_read_02".toUtf8Array()
        enterStream.write(bufdata)
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream) 
        var resData2: Array<Byte> = Array<Byte>()
        try{
            ins_1.read(resData2)
            res = resData2.size 
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            @Assert(e1.toString().contains("IllegalArgumentException: The buffer cannot be empty"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUnicodeBOMInputStream_read_03():Unit{
        var bufdata: Array<Byte> = "testUnicodeBOMInputStream_read_03".toUtf8Array()
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream) //缓冲区为空
        @Assert(bufdata.size, 33)
        // public func read(buffer: Array<Byte>)
        ins_1.read(bufdata)
        res = bufdata.size // 33 
        println("res:>> ${res}")
        @Assert(res, 33) 
    }

}

