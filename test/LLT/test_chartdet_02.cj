// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

main() {

    var detector: UniversalDetector = UniversalDetector()
    var bufdata: Array<Byte> = [0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x02, 0x00]
    let str = UniversalDetector.detectCharsetFromBOM(bufdata)
    println(str)
    if (str != "") {
        return 1
    }
    return 0
}

