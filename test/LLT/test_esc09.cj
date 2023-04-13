// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let strs: EscCharsetProber = EscCharsetProber()
    let data: Array<Byte> = [0x4b, 0x03, 0x04, 0x15, 0x00, 0x02, 0x00]
    strs.handleData(data,0,Int32(data.size))
    let name = strs.getCharSetName()
    println(name)
    if (!name.isEmpty()) {
        return 1
    }
    return 0
}

