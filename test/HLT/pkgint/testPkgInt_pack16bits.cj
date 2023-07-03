// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset


from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class PkgIntTest {
    var returnFlag: Int64 = 0
    var res: Int32 = 0

    @TestCase
    func testPkgInt_pack16bits_01():Unit{
        // public static func pack16bits(a: Int32, b: Int32): Int32
        res = PkgInt.pack16bits(Int32(0),Int32(2))  // 131072
        println("res:>> ${res}")
        @Assert(res, 131072) 

        try{
            res = PkgInt.pack16bits(Int32(0),Int32(0))  // 0
        }catch(e1:Exception){
            println("e1:>>>>${e1}")
            returnFlag = 1
        }
        @Assert(res, 0)

        try{
            res = PkgInt.pack16bits(Int32(-2),Int32(0))  // -2
        }catch(e2:Exception){
            println("e2:>>>>${e2}")
            returnFlag = 2
        }
        @Assert(res, -2)

        try{
            res = PkgInt.pack16bits(Int32(25654),Int32(0))  // 25654
        }catch(e3:Exception){
            println("e3:>>>>${e3}")
            returnFlag = 3
        }
        @Assert(res, 25654)

        try{
            res = PkgInt.pack16bits(Int32(25654),Int32(-231))  // -15113162
        }catch(e4:Exception){
            println("e4:>>>>${e4}")
            returnFlag = 4
        }
        @Assert(res, -15113162)

        @Assert(returnFlag, 0)
    }

}
