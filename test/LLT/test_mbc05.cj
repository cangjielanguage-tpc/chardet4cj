// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {

    let intput: MBCSGroupProber = MBCSGroupProber()
    let sc = intput.reset()
    let str = intput.getCharSetName()
    println(str)
    if (str != "UTF-8") {
        return 1
    }
    var con = intput.getConfidence()
    println(con)
    if (con > 0.0) {
        return 0
    }
    return 1
}

