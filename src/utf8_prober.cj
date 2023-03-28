package chardet4cj


public class UTF8Prober <: CharsetProber {

    public static let ONE_CHAR_PROB: Float32 = 0.50

    private var codingSM: CodingStateMachine
    private var state: ProbingState
    private var numOfMBChar: Int32

    private static let smModel: SMModel = UTF8SMModel()

    public init() {
        super()
        this.numOfMBChar = 0
        this.codingSM = CodingStateMachine(smModel)
        this.state = ProbingState.DETECTING
    }

    public func getCharSetName(): String {
        return Constants.CHARSET_UTF_8
    }

    public func handleData(buf: Array<Byte>, offset: Int32, length: Int32): ProbingState {

        var codingState: Int32 = 0

        let maxPos: Int32 = offset + length

        for (i in offset..maxPos) {
            codingState = this.codingSM.nextState(buf[Int64(i)])
            if (codingState == SMModel.ERROR) {
                this.state = ProbingState.NOT_ME
                break
            }
            if (codingState == SMModel.ITSME) {
                this.state = ProbingState.FOUND_IT
                break
            }
            if (codingState == SMModel.START) {
                if (this.codingSM.getCurrentCharLen() >= 2) {
                    this.numOfMBChar++
                }
            }
        }
        if (this.state == ProbingState.DETECTING) {
            if (this.getConfidence() > CharsetProber.SHORTCUT_THRESHOLD) {
                this.state = ProbingState.FOUND_IT
            }
        }
        
        return this.state
    }

    public func getState(): ProbingState {
        return this.state
    }

    public func getConfidence(): Float32 {
        var unlike: Float32 = 0.99
        
        if (this.numOfMBChar < 6) {
            for (i in 0..this.numOfMBChar) {
                unlike *= ONE_CHAR_PROB
            }
            return (1.0 - unlike)
        } else {
            return 0.99
        }
    }
}
