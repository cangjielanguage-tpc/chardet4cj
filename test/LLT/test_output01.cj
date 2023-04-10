// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorOutputStream = EncodingDetectorOutputStream(intput)
    str.write(6)
    let src = str.getDetectedCharset()
    println(src)
    if (!src.isEmpty()) {
        return 1
    }
    return 0
}

