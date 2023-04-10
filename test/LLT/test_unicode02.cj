// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x02, 0x00]
    intput.write(data)
    let str: UnicodeBOMInputStream = UnicodeBOMInputStream(intput,false)
    let boms = str.getBOM().toString()
    println(boms)
    if (boms != "NONE") {
        return 1
    }
    return 0
}

