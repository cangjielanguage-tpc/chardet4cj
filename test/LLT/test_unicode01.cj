// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    var es = ""
    try{
        let str: UnicodeBOMInputStream = UnicodeBOMInputStream(intput)
    } catch (e: Exception){
        es = e.toString()
    }
    if (es != "IllegalArgumentException: invalid input stream: null is not allowed") {
        return 1
    }
    return 0
}

