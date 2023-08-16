// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/chardet4cj
// 3rd_party_lib_ohos:chardet4cj/build/aarch64-linux-ohos/charset

//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class SMModelTest {
    let ins_UTF8SMModel:SMModel = UTF8SMModel()
    let ins_HZSMModel:SMModel = HZSMModel()
    let ins_ISO2022CNSMModel:SMModel = ISO2022CNSMModel()
    var returnFlag: Int64 = 0
    var res:String = ""

    @TestCase
    func testSMModel_getName_01():Unit{
        // public func getName(): String
        res = ins_UTF8SMModel.getName() // 
        println("res:>> ${res}")
        @Assert(res, "UTF-8") 

        res = ins_HZSMModel.getName() // 1
        println("res:>> ${res}")
        @Assert(res, "HZ-GB-2312") 

        res = ins_ISO2022CNSMModel.getName() // 1
        println("res:>> ${res}")
        @Assert(res, "ISO-2022-CN") 
    }

}
