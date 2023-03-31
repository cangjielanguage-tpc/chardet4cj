// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x4b, 0x03, 0x00]
    intput.write(data)
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)
    let bufs: Array<Byte> = Array<Byte>(5, item: 0)
    str.read(bufs)
    let src = str.skip(0)
    println(src)
    if (src != -1) {
        return 1
    }
    return 0
}

