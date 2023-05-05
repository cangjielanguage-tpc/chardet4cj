// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//dependence:../util_test/util_common.cj

/* 
    public init(inputStream: InputStream)
    public init(inputStream: InputStream, skipIfFound: Bool) 
*/

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

@Test
public class UnicodeBOMInputStreamTest {
    var enterStream:ByteArrayStream = ByteArrayStream()
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var resStr: String = ""
    var resData: Array<Byte> = Array<Byte>()

    @TestCase
    func testUnicodeBOMInputStream_getBOM_01():Unit{
        var bufdata: Array<Byte> = "testUnicodeBOMInputStream_getBOM_01".toUtf8Array()
        enterStream.write(bufdata)
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream)
        // public func getBOM(): BOM  public func toString(): String
        var bom:BOM = ins_1.getBOM()
        resStr = bom.toString() // NONE
        println("resStr:>> ${resStr}")
        @Assert(resStr, "NONE") 

        println("bufdata:>> ${bufdata.size}")
        @Assert(bufdata.size, 35)
        // public func getBytes(): Array<Byte>
        res = bom.getBytes().size // 0
        println("res:>> ${res}")

        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUnicodeBOMInputStream_getBOM_02():Unit{
        returnFlag = 0
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream) //缓冲区为空
        // public func getBOM(): BOM  public func toString(): String
        try{
            var bom:BOM = ins_1.getBOM()
            resStr = bom.toString() // NONE
            @Assert(resStr, "NONE")
            res = bom.getBytes().size // 0
            @Assert(res, 0)
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUnicodeBOMInputStream_getBOM_03():Unit{
        var bufdata: Array<Byte> = "testUnicodeBOMInputStream_getBOM_03".toUtf8Array()
        enterStream.write(bufdata)
        let ins_1:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream,true)
        var bom:BOM = ins_1.getBOM()
        resStr = bom.toString() // NONE
        println("resStr:>> ${resStr}")
        @Assert(resStr, "NONE") 

        println("bufdata:>> ${bufdata.size}")
        @Assert(bufdata.size, 35)
        let ins_2:UnicodeBOMInputStream = UnicodeBOMInputStream(enterStream,false)
        res = ins_2.getBOM().getBytes().size // 0
        println("res:>> ${res}")
        @Assert(res, 0) 

    }
}

