// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream   = EncodingDetectorInputStream(intput)
    if (Int64(str.available()) == 0) {
        try {
            str.mark(58)
        } catch (e: ChardetException) {
            return 0
        }
        return 1
    }
    return 1
}