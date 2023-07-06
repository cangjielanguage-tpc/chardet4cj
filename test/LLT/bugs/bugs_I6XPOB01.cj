// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14]
    intput.write(data)
    let str: EncodingDetectorOutputStream = EncodingDetectorOutputStream(intput)
    str.close()
    let bufs: Array<Byte> = Array<Byte>(3, item: 0)
    try {
        str.write(bufs)
    } catch(e: Exception) {
        return 0
    }
    return 1
}

