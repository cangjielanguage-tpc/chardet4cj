// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let str: EscCharsetProber = EscCharsetProber()
    str.reset()
    let src = str.getCharSetName()
    println(src)
    if (!src.isEmpty()) {
        return 1
    }
    return 0
}

