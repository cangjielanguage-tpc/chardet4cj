// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {

    let intput: MBCSGroupProber = MBCSGroupProber()
    let str: ProbingState = intput.getState()
    if (str != ProbingState.DETECTING) {
        return 1
    }
    return 0
}

