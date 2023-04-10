// DEPENDENCE: utf16be.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*
from std import fs.*
from charset import charset.*
from charset import  charset.encoding.*

main() {

    var testFile1: File = File("./utf16be.txt",Open(true, false))
    var originalEncoding1: BufferedInputStream = ReaderFactory.createBufferedReader(testFile1,Charsets.UTF8)
    let src = originalEncoding1.length
    println(src)
    if (src != 2128) {
        return 1
    }
    return 0
}

