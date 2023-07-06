// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let intput1: ByteArrayStream = ByteArrayStream()
    let intput2: ByteArrayStream = ByteArrayStream()
    let data: Array<Byte> = [0x50, 0x4b, 0x03]
    let data1: Array<Byte> = [0x50, 0x4b]
    let data2: Array<Byte> = [0x50]
    intput.write(data)
    intput1.write(data1)
    intput2.write(data2)
    let str: UnicodeBOMInputStream = UnicodeBOMInputStream(intput,false)
    
    let boms = str.getBOM().toString()
    println(boms)
    if (boms != "NONE") {
        return 1
    }
    return 0
}

