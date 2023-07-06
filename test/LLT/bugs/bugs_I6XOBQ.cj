// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)
    var temp = Array<Byte>(1,item:0)
    try {
        str.read(temp)
    } catch(e: Exception) {
        return 0
    }
    try {
        str.skip(1)
    } catch(e: Exception) {
        return 0
    }
    return 1
}

