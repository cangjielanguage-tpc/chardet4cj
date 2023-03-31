// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer
main() {
    var charsetp: CharsetProber = UTF8Prober()
    
    var bufdata: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x02, 0x00]
    var bytebuf: ByteBuffer = charsetp.filterWithoutEnglishLetters(bufdata,0,8)
    let str: String = bytebuf.toString()
    println(str)
    if (str != "ByteBuffer: [offset=0 mark=-1 pos=0 lim=8 cap=8]"){
        return 1
    }
    return 0
}

