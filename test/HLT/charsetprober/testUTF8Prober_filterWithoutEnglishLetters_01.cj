// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class ChardetTest {
    var charsetp: CharsetProber = UTF8Prober()
    var commonUtils_ins: CommonUtils = CommonUtils()
    // var out: ByteBuffer = ByteBuffer.allocate(Int64(length))
    var returnFlag: Int64 = -1
    var res: Int64 = 0
    @TestCase
    func testUTF8Prober_filterWithoutEnglishLetters_01():Unit{
        var bufdata: Array<Byte> = "testUTF8Prober_filterWithoutEnglishLetters_01".toUtf8Array()
       /*  public func filterWithEnglishLetters(buf: Array<Byte>, offset: Int32, length: Int32): ByteBuffer */
        var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata,0,Int32(bufdata.size-10))
        let str: String = bytebuf_1.toString()
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=35 cap=35]")

        try{
            charsetp.filterWithoutEnglishLetters(bufdata,-1,Int32(bufdata.size-10))
        }catch(e1:Exception){
            println("Except:1:>> ${e1}")
            @Assert(e1.toString().contains("IndexOutOfBoundsException"), true)
            res = 1
            if(res != 1){
                returnFlag = 1
            }
        }

        try{
            charsetp.filterWithoutEnglishLetters(bufdata,0,-10)
        }catch(e2:Exception){
            println("Except:2:>> ${e2}")
            @Assert(e2.toString().contains("IllegalArgumentException"), true)
            res = 2
            if(res != 2){
                returnFlag = 2
            }
        }

        try{
            var bytebuf_4: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata,55,Int32(bufdata.size + 2))
            // println(bufdata.size)  // 53
            println(bytebuf_4.toString())  // ByteBuffer: [offset=0 mark=-1 pos=0 lim=55 cap=55]
        }catch(e3:Exception){
            println("Except:3:>> ${e3}")
            @Assert(e3.toString().contains("IndexOutOfBoundsException"), true)
            returnFlag = 0
        }

        // @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=43 cap=43]")
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUTF8Prober_filterWithoutEnglishLetters_02():Unit{
        returnFlag = -1
        var bufdata_2: Array<Byte> = Array<Byte>() //源数据为空,预期抛异常 ？？
        try{
            var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata_2,0,Int32(bufdata_2.size))
            bytebuf_1.toString() // ByteBuffer: [offset=0 mark=-1 pos=0 lim=0 cap=0]
        }catch(e4:Exception){
            println("Except:4:>> ${e4}")
            // @Assert(e4.toString().contains("IllegalArgumentException"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testUTF8Prober_filterWithoutEnglishLetters_03():Unit{
        var bufdata_3: Array<Byte> = commonUtils_ins.getStrWithEnglishLetters(10).toUtf8Array() //源数据超长
        var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata_3,0,Int32(bufdata_3.size ))
        let str: String = bytebuf_1.toString()
        println("bufdata_3: ${bufdata_3.size}")
        @Assert(bufdata_3.size, 431)
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=431 cap=431]")
    }

    @TestCase
    func testUTF8Prober_filterWithoutEnglishLetters_04():Unit{
        var bufdata_4: Array<Byte> = "testCharsetProber_UTF8_filterWithoutEnglishLetters_04元数据含中文哦".toUtf8Array() 
        var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata_4,0,Int32(bufdata_4.size - 5))
        let str: String = bytebuf_1.toString()
        println("bufdata_4: ${bufdata_4.size}")
        @Assert(bufdata_4.size, 74)
        println(str)
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=16 lim=69 cap=69]")
    }

    @TestCase
    func testUTF8Prober_filterWithoutEnglishLetters_05():Unit{
        var bufdata_5: Array<Byte> = "元数据全中文哦".toUtf8Array() 
       /*  public func filterWithoutEnglishLetters(buf: Array<Byte>, offset: Int32, length: Int32): ByteBuffer */
        var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata_5,0,Int32(bufdata_5.size - 5))
        let str: String = bytebuf_1.toString()
        @Assert(bufdata_5.size, 21)
        println(str)
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=16 lim=16 cap=16]")
    }

}

