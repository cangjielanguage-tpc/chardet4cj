// DEPENDENCE: utf8.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*
from std import fs.*

main() {
    var testFile: File = File("./utf8.txt",Open(true, false))
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(testFile)
    let bufs: Array<Byte> = Array<Byte>(5, item: 0)
    str.read(bufs)
    let src = str.skip(1)
    str.getDetectedCharset()
    println(src)
    if (src != 1) {
        return 1
    }
    return 0
}

