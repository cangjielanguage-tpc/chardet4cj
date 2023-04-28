// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset
// 3rd_party_lib:chardet4cj/build/cryptocj
// 3rd_party_lib:chardet4cj/build/okio
//dependence:../util_test/util_common.cj

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer

@Test
public class CodingStateMachineTest {
    let ins_UTF8SMModel:SMModel = UTF8SMModel()
    let ins_HZSMModel:SMModel = HZSMModel()
    let ins_ISO2022CNSMModel:SMModel = ISO2022CNSMModel()
    var returnFlag: Int64 = 0
    var res:Int32 = -1

    @TestCase
    func testCodingStateMachine_combination_01():Unit{
        let codingStateMachine_UTF8:CodingStateMachine = CodingStateMachine(ins_UTF8SMModel)
        // public func nextState(c: Byte): Int32
        res = codingStateMachine_UTF8.nextState(0) // 0
        // println("res:>> ${res}")
        @Assert(res, 0) 

        // public func getCurrentCharLen(): Int32
        res = codingStateMachine_UTF8.getCurrentCharLen() // 1
        // println("res:>> ${res}")
        @Assert(res, 1) 

    }
    
    @TestCase
    func testCodingStateMachine_combination_02():Unit{
        let codingStateMachine_HZSMModel:CodingStateMachine = CodingStateMachine(ins_HZSMModel)
        returnFlag = 0
       try{
            res = codingStateMachine_HZSMModel.nextState(255) // 1
        }catch(e1:Exception){
            println("Exception_1:>> ${e1}")
            returnFlag = 1
        }
        @Assert(res, 1) 
        // public func getCodingStateMachine(): String
        var codingStateMachine:String = codingStateMachine_HZSMModel.getCodingStateMachine()
        // println("codingStateMachine:>> ${codingStateMachine}")
        @Assert(codingStateMachine, "HZ-GB-2312")
        @Assert(returnFlag, 0)
    }

    @TestCase
    func testCodingStateMachine_combination_03():Unit{
        let codingStateMachine_ISO2022CNSMModel:CodingStateMachine = CodingStateMachine(ins_ISO2022CNSMModel)
        res = codingStateMachine_ISO2022CNSMModel.nextState(0x02) // 0
        @Assert(res, 0) 
        // public func reset()
        codingStateMachine_ISO2022CNSMModel.reset()
        res = codingStateMachine_ISO2022CNSMModel.nextState(12) // 0
        // println("res:>> ${res}")
        @Assert(res, 0)

        @Assert(returnFlag, 0)

    }
}
