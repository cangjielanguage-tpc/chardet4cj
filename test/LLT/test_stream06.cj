// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x4b, 0x03, 0x03, 0x04, 0x15, 0x00, 0x02, 0x00]
    intput.write(data)
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)
    try{
        str.skip(15)
        return 1
    } catch (e: Exception) {
        return 0
    }
}
