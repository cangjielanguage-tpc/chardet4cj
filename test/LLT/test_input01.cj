// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream   = EncodingDetectorInputStream(intput)
    let src =  str.available()
    str.close()
    str.mark(0)
    println(src)
    if (src != 0) {
        return 1
    }
    return 0
}

