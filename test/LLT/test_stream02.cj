// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream   = EncodingDetectorInputStream(intput)
    str.available()
    str.close()
    try {
        str.mark(1)
    } catch (e: Exception) {
        return 0
    }
    return 1
    
}