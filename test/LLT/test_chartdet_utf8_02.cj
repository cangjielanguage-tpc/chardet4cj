// DEPENDENCE: utf8.txt
// DEPENDENCE: utf8n.txt
// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from std import fs.*
from std import io.*
from chardet4cj import chardet4cj.*

main() {

    let data: String = "概要"
    var input: ByteArrayStream = ByteArrayStream()
    input.write(data.toArray())
    var originalEncoding: String = UniversalDetector.detectCharset(input)
    println(originalEncoding)

    if (originalEncoding != "UTF-8") {
        return 1
    }
    return 0
}

