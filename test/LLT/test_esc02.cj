// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let str: EscCharsetProber = EscCharsetProber()
    str.reset()
    let src = str.getConfidence()
    println(src)
    if (src != 0.990000) {
        return 1
    }
    return 0
}

