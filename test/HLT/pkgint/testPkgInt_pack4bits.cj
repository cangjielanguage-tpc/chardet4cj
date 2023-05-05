// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

@Test
public class PkgIntTest {
    var returnFlag: Int64 = 0
    var res: Int32 = 0

    @TestCase
    func testPkgInt_pack4bits_01():Unit{
        // public static func pack4bits(a: Int32, b: Int32, c: Int32, d: Int32, e: Int32, f: Int32, g: Int32, h: Int32): Int32
        res = PkgInt.pack4bits(Int32(0),Int32(2),Int32(0),Int32(0),Int32(-2),Int32(0),Int32(25654),Int32(0))  // -131040
        println("res:>> ${res}")
        @Assert(res, -131040) 

        try{
            res = PkgInt.pack4bits(Int32(0),Int32(0),Int32(0),Int32(0),Int32(0),Int32(0),Int32(0),Int32(0))  // 0
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }
        @Assert(res, 0)

        try{
            res = PkgInt.pack4bits(Int32(2),Int32(0),Int32(25654),Int32(0),Int32(25654),Int32(0),Int32(-2),Int32(-231))  // -25807358
        }catch(e2:Exception){
            println("e2:>>>>${e2}")
            returnFlag = 2
        }
        @Assert(res, -25807358)

        @Assert(returnFlag, 0)
    }

}
