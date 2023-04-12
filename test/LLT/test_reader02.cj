// DEPENDENCE: utf16le.txt
// DEPENDENCE: utf8n.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*
from std import fs.*
from charset import charset.*
from charset import  charset.encoding.*

main() {

    var testFile1: File = File("./utf16le.txt",Open(true, false))
    var testFile2: File = File("./utf8n.txt",Open(true, false))

    var originalEncoding1: BufferedInputStream = ReaderFactory.createBufferedReader(testFile1)
    var originalEncoding2: BufferedInputStream = ReaderFactory.createReaderFromFile(testFile2)
    let str = originalEncoding1.length
    let str2 = originalEncoding2.length
    println(str)
    if (str != 2128) {
        return 1
    }
    if (str2 != 1765) {
        return 1
    }
    return 0
}

