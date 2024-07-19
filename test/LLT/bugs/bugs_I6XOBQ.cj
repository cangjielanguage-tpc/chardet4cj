// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import chardet4cj.*
import std.io.*

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

