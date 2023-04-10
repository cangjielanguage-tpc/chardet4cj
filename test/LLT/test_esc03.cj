// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let str: EscCharsetProber = EscCharsetProber()
    str.reset()
    let src: ProbingState = str.getState()
    println(src)
    if (src != ProbingState.DETECTING) {
        return 1
    }
    return 0
}

