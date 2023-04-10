// DEPENDENCE: utf8n.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*
from std import fs.*
from charset import charset.*
from charset import  charset.encoding.*

main() {

    var testFile1: File = File("./utf8n.txt",Open(true, false))
    var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(testFile1,Charsets.UTF8)
    let str = originalEncoding1.length
    println(str)
    if (str != 1765) {
        return 1
    }
    return 0
}

