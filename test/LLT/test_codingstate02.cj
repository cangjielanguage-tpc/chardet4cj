// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from chardet4cj import chardet4cj.*

main() {
    var codingstate: CodingStateMachine  = CodingStateMachine(ISO2022CNSMModel())
    
    let model: String = codingstate.getCodingStateMachine()
    println(model)

    if (model != "ISO-2022-CN") {
        return 1
    }
    return 0
}

