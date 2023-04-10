// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from chardet4cj import chardet4cj.*
from okio import nio.ByteBuffer
main() {
    var charsetp: CharsetProber = UTF8Prober()
    
    var bufdata: Array<Byte> = [8, 9, 10, 11, 12, 13, 14, 15]
    var bytebuf: ByteBuffer = charsetp.filterWithEnglishLetters(bufdata,0,8)
    let str: String = bytebuf.toString()
    println(str)
    if (str != "ByteBuffer: [offset=0 mark=-1 pos=0 lim=8 cap=8]"){
        return 1
    }
    return 0
}

