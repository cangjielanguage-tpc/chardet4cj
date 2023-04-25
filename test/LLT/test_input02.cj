// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from chardet4cj import chardet4cj.*
from std import io.*

main() {
    let intput: ByteArrayStream = ByteArrayStream()
    let str: EncodingDetectorInputStream = EncodingDetectorInputStream(intput)

    let src = str.markSupported()
	try {
        let src1 = str.read()
    } catch(e: Exception) {
        return 0
    }
    if (src != false) {
        return 1
    }

    return 0
}

