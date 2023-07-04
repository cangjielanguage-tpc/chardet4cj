// 3rd_party_lib:chardet4cj/build/chardet4cj
// 3rd_party_lib:chardet4cj/build/charset


from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*


@Test
public class UTF8ProberTest {
    var charsetp: UTF8Prober = UTF8Prober()
    var res: Int64 = 0
    @TestCase
    func testUTF8Prober_combination_01():Unit{
        var bufdata: Array<Byte> = "testCharsetProber_filterWithEnglishLetters_01".toUtf8Array()
       /*  public func filterWithEnglishLetters(buf: Array<Byte>, offset: Int32, length: Int32): ByteBuffer */
        var bytebuf_1: ByteBuffer= charsetp.filterWithoutEnglishLetters(bufdata,0,Int32(bufdata.size-10))
        let str: String = bytebuf_1.toString()
        @Assert(str, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=35 cap=35]")

        /* public func getCharSetName(): String */
        var strRes:String = charsetp.getCharSetName()
        @Assert(strRes, "UTF-8")  

        /* public func getState(): ProbingState */
        var state:ProbingState = charsetp.getState() // DETECTING
        println("state:>> ${state}")
        @Assert(state.toString(), "DETECTING") 
        
        /* public func getConfidence(): Float32 */
        var confidence:Float32 = charsetp.getConfidence() // 0.010000
        println("confidence:>> ${confidence}")
        @Assert(confidence.toString(), "0.010000") 


        /* public func reset() */
        charsetp.reset() 
        state = charsetp.getState() // DETECTING
        println("state:>> ${state}")
        @Assert(state.toString(), "DETECTING") 

    }

}

