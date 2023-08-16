// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class MBCSGroupProberTest {
    var charsetp: MBCSGroupProber = MBCSGroupProber()
    var commonUtils_ins: CommonUtils = CommonUtils()
    var returnFlag: Int64 = 0
    var res: Int64 = 0
    var state: ProbingState = ProbingState.NOT_ME
    @TestCase
    func testMBCSGroupProber_handleData_01():Unit{
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
       /*  public func handleData(buf: Array<Byte>, offset: Int32, length: Int32): ProbingState */
        state = charsetp.handleData(bufdata,0,Int32(bufdata.size-10))
        @Assert(state == DETECTING,true)

        try{
            state = charsetp.handleData(bufdata,-1,Int32(bufdata.size-10))
        }catch(e1:Exception){
            println("Except:1:>> ${e1}")
            @Assert(e1.toString().contains("IndexOutOfBoundsException"), true)
            res = 1
            if(res != 1){
                returnFlag = 1
            }
        }

        try{
            state = charsetp.handleData(bufdata,0,-10)  
        }catch(e2:Exception){
            println("Except:2:>> ${e2}")
            @Assert(e2.toString().contains("NegativeArraySizeException"), true)
            res = 2
            if(res != 2){
                returnFlag = 2
            }
        }
        @Assert(state == DETECTING,true)

        try{
            state = charsetp.handleData(bufdata,2,Int32(bufdata.size + 2))
            println(state.toString())  // ByteBuffer: [offset=0 mark=-1 pos=0 lim=55 cap=55]
        }catch(e3:Exception){
            println("Except:3:>> ${e3}")
            @Assert(e3.toString().contains("IndexOutOfBoundsException"), true)
            res = 3
            if(res != 3){
                returnFlag = 3
            }
        }
        @Assert(state == DETECTING,true)
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testMBCSGroupProber_handleData_02():Unit{
        returnFlag = -1
        var bufdata_2: Array<Byte> = Array<Byte>() //源数据为空,预期抛异常 
        try{
            state = charsetp.handleData(bufdata_2,0,Int32(bufdata_2.size)) 
            println("state_22:>> ${state.toString()}")
        }catch(e4:Exception){
            println("Except:4:>> ${e4}")
            // @Assert(e4.toString().contains("IllegalArgumentException"), true)
            returnFlag = 0
        }
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testMBCSGroupProber_handleData_03():Unit{
        var bufdata_3: Array<Byte> = commonUtils_ins.getStrWithEnglishLetters(10).toUtf8Array() //源数据超长
        state = charsetp.handleData(bufdata_3,0,Int32(bufdata_3.size ))
        @Assert(state == DETECTING,true)
        @Assert(bufdata_3.size, 431)

    }

    @TestCase
    func testMBCSGroupProber_handleData_04():Unit{
        returnFlag = 0
        var bufdata_4: Array<Byte> = "testCharsetProber_UTF8_handleData_04元数据含中文哦".toUtf8Array() 
        try{
            state = charsetp.handleData(bufdata_4,0,Int32(bufdata_4.size - 5)) // FOUND_IT
        }catch(e5:Exception){
            println("Exception5:>> ${e5}")
            returnFlag = 1
        }
        @Assert(bufdata_4.size, 57)
        @Assert(state == FOUND_IT,true)
        @Assert(returnFlag,0)
    }

    @TestCase
    func testMBCSGroupProber_handleData_05():Unit{
        returnFlag = 0
        var bufdata_5: Array<Byte> = "元数据全中文哦".toUtf8Array() 
        try{
            state = charsetp.handleData(bufdata_5,0,Int32(bufdata_5.size - 5))
        }catch(e6:Exception){
            println("Exception5:>> ${e6}")
            returnFlag = 1
        }
        @Assert(bufdata_5.size, 21)
        @Assert(state == NOT_ME,true)
        @Assert(returnFlag,0)
    }

}

