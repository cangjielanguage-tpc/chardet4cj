package chardet4cj

from std import collection.*

public class MBCSGroupProber <: CharsetProber {

    private var state: ProbingState = ProbingState.DETECTING
    private var probers: ArrayList<CharsetProber> = ArrayList<CharsetProber>()

    private var bestGuess: ?CharsetProber =  Option<CharsetProber>.None
    private var activeNum: Int32 = 0

    public init() {
        super()
        probers.append(UTF8Prober())
        for (prober in this.probers) {
            prober.setActive(true)
            this.activeNum++
        }
    }

    public func reset() {
        this.activeNum = 0
        for (prober in this.probers) {
            prober.setActive(true)
            this.activeNum++
        }
        this.bestGuess = Option<CharsetProber>.None
        this.state = ProbingState.DETECTING
    }

    public func getCharSetName(): String {

        match (this.bestGuess) {
            case Some(v) => ()
            case None =>
                getConfidence()
                match (this.bestGuess) { 
                    case Some(v) => ()
                    case None =>
                        this.bestGuess = probers.get(0)
                }
        }
		return this.bestGuess.getOrThrow().getCharSetName()
    }

    public func getConfidence(): Float32 { 

        var bestConf: Float32 = 0.0
        var cf: Float32 = 0.0

        if (this.state == ProbingState.FOUND_IT) {
            return 0.99
        } else if (this.state == ProbingState.NOT_ME) {
            return 0.01
        } else {
            for(prober in probers) {
        		if (!prober.isActive()) {
        			continue
        		}
        		cf = prober.getConfidence()
                if (bestConf < cf) {
                    bestConf = cf
                    this.bestGuess = prober
                }
        	}
        }

        return bestConf
    }

    public func getState(): ProbingState {
        return this.state
    }

    public func handleData(buf: Array<Byte>, offset: Int32, length: Int32): ProbingState {

        var st: ProbingState = ProbingState.NOT_ME

        var keepNext: Bool = true
        var highbyteBuf: Array<Byte> = Array<Byte>(Int64(length), item: 0)
        var highpos: Int32 = 0
        var maxPos: Int32 = offset + length

        for (i in offset..maxPos) {
            if ((buf[Int64(i)] & 0x80) != 0) {
                highbyteBuf[Int64(highpos)] = buf[Int64(i)]
                highpos++
                keepNext = true
            } else {
                if (keepNext) {
                    highbyteBuf[Int64(highpos)] = buf[Int64(i)]
                    highpos++
                    keepNext = false
                }
            }
        }

        for(prober in probers) {

            if (!prober.isActive()) {
        		continue
        	}
        	st = prober.handleData(highbyteBuf, 0, highpos)
        	if (st == ProbingState.FOUND_IT) {
                this.bestGuess = prober
                this.state = ProbingState.FOUND_IT
                break
            } else if (st == ProbingState.NOT_ME) {
                prober.setActive(false)
                this.activeNum--
                if (this.activeNum <= 0) {
                    this.state = ProbingState.NOT_ME
                    break
                }
            }
        }
        return this.state
    }
}