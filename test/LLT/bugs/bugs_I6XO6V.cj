// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let strs: EscCharsetProber = EscCharsetProber()
    let data: Array<Byte> = Array<Byte>()
    try {
        strs.handleData(data,0,Int32(data.size))
    } catch(e: Exception) {
        return 0
    }
    return 1
}


