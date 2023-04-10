// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x02, 0x00]
    intput.write(data)
    var es = ""
    try{
        let str: UnicodeBOMInputStream = UnicodeBOMInputStream(intput)
    } catch (e: Exception){
        es = e.toString()
    }
    if (es != "IllegalArgumentException: The buffer cannot be empty: `buffer.size() = 0`!") {
        return 1
    }
    return 0
}

