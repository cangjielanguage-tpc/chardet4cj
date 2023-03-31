// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)

    let src = str.markSupported()
    let src1 = str.read()
    if (src != false) {
        return 1
    }
    if (src1 != -1) {
        return 2
    }
    return 0
}

