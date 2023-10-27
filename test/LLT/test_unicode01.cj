// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    var es = ""
    try{
        UnicodeBOMInputStream(intput)
    } catch (e: ChardetException){
        es = e.toString()
    }
    if (es != "ChardetException: invalid input stream: null is not allowed") {
        return 1
    }
    return 0
}

