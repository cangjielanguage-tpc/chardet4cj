package chardet4cj

from std import fs.*

from charset import charset.*
from charset import  charset.encoding.*

public class ReaderFactory {

    private init() {
        throw Exception("No instances allowed")
    }
    
    public static func createBufferedReader(file: File, defaultCharset: Charset): BufferedInputStream {
        var cs: Charset = defaultCharset
        var detectedEncoding: String = UniversalDetector.detectCharset(file)
        if (!detectedEncoding.isEmpty()) {
            cs = Charsets.forName(detectedEncoding).getOrThrow()
        }
        if (!cs.nameEquals("UTF-8") || !cs.nameEquals("UTF-16BE") || !cs.nameEquals("UTF-16LE")) {
            return BufferedInputStream(File(file.info.path, OpenOption.Open(true, false)))
        }
        var path = file.info.path

        return  BufferedInputStream(File(file.info.path, OpenOption.Open(true, false)))
    }

    public static func createBufferedReader(file: File): BufferedInputStream {
        return createBufferedReader(file, Charsets.UTF8)
    }
    
    public static func createReaderFromFile(file: File, defaultCharset: Charset): BufferedInputStream {
        return createBufferedReader(file, defaultCharset)
    }

    public static func createReaderFromFile(file: File): BufferedInputStream {
        return createReaderFromFile(file, Charsets.UTF8)
    }
}
 