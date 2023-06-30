// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from chardet4cj import chardet4cj.*

main() {
    var charsetp: CharsetProber = UTF8Prober()
    
    var bufdata: Array<Byte> = [0x50, 0x4b, 0x03]
    try {
        var bytebuf: ByteBuffer = charsetp.filterWithEnglishLetters(bufdata,0,0)
    } catch(e: Exception) {
        return 0
    }
    var datas: Array<Byte> = Array<Byte>()
    try {
        var bytebuf: ByteBuffer = charsetp.filterWithEnglishLetters(datas,0,8)
    } catch(e: Exception) {
        return 0
    }
    return 1
}
