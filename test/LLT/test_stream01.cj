// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream   = EncodingDetectorInputStream(intput)
    if (!str.markSupported()) {
        try {
            str.mark(0)
        } catch (e: Exception) {
            return 1
        }
        return 0
    }
    return 1
}