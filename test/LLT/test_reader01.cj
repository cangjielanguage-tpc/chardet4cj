// DEPENDENCE: utf8.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*
from std import fs.*
from charset import charset.*
from charset import  charset.encoding.*

main() {

    var testFile1: File = File("./utf8.txt",Open(true, false))
    var es = ""
    try{
        var originalEncoding1: BufferedInputStream = ReaderFactory.createBufferedReader(testFile1,Charsets.UTF8)
    } catch (e: Exception){
        es = e.toString()
    }
    try{
        var originalEncoding1: BufferedInputStream = ReaderFactory.createReaderFromFile(testFile1,Charsets.UTF8)
    } catch (e: Exception){
        es = e.toString()
    }
    if (es != "FSException: The file already exists!") {
        return 1
    }
    return 0
}

