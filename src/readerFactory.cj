/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */
package chardet4cj

from std import fs.*

from charset import charset.*
from charset import  charset.encoding.*

public class ReaderFactory {

    private init() {
        throw ChardetException("no instances allowed")
    }
    
    public static func createBufferedReader(file: File, defaultCharset: Charset): File {
        var cs: Charset = defaultCharset
        var detectedEncoding: String = UniversalDetector.detectCharset(file)
        if (!detectedEncoding.isEmpty()) {
            cs = Charsets.forName(detectedEncoding).getOrThrow()
        }
        if (!cs.nameEquals("UTF-8") || !cs.nameEquals("UTF-16BE") || !cs.nameEquals("UTF-16LE")) {
            return File(file.info.path, OpenOption.Open(true, false))
        }

        return  File(file.info.path, OpenOption.Open(true, false))
    }

    public static func createBufferedReader(file: File): File {
        return createBufferedReader(file, Charsets.UTF8)
    }
    
    public static func createReaderFromFile(file: File, defaultCharset: Charset): File {
        return createBufferedReader(file, defaultCharset)
    }

    public static func createReaderFromFile(file: File): File {
        return createReaderFromFile(file, Charsets.UTF8)
    }
}
 