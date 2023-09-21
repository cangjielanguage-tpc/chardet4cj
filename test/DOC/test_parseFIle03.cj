// DEPENDENCE: utf16le.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from chardet4cj import chardet4cj.*

main() {
    var testFiles2: File = File("./utf16le.txt",Open(true, false))
    var originalEncodings2: String = UniversalDetector.detectCharset(testFiles2)
    println(originalEncodings2)
    if (originalEncodings2 != "UTF-16LE") {
        return 1
    }
    return 0
}