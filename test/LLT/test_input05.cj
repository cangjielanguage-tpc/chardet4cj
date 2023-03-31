// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x4b, 0x03]
    intput.write(data)
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)
    var exc = ""
    try{
        let src = str.reset()
    } catch (e: Exception){
        exc = e.toString()
    }
    if (exc != "Exception: mark/reset not supported") {
        return 1
    }
    return 0
}

