// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x02, 0x00]
    intput.write(data)
    let str: UnicodeBOMInputStream = UnicodeBOMInputStream(intput,false)
    let buf: Array<Byte> = Array<Byte>(4, item: 0)
    str.read(buf)
    let sc = str.length
    println(sc)
    if (sc != 8) {
        return 1
    }
    return 0
}

