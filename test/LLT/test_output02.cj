// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x4b, 0x03, 0x00]
    let str: EncodingDetectorOutputStream = EncodingDetectorOutputStream(intput)
    str.write(data)
    str.close()
    str.flush()
    let src = str.getDetectedCharset()
    println(src)
    if (!src.isEmpty()) {
        return 1
    }
    return 0
}

