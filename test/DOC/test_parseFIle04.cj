// DEPENDENCE: utf8.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from chardet4cj import chardet4cj.*

main() {
    var testFiles: File = File("./utf8.txt",Open(true, false))
    var originalEncodings: String = UniversalDetector.detectCharset(testFiles)
    println("ISO-2022-CN")
    if (originalEncodings != "UTF-8") {
        return 1
    }
    return 0
}