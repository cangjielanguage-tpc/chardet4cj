// EXEC: cjc %import-path %L %l %f  
// EXEC: ./main

from chardet4cj import chardet4cj.*

main() {
    var codingstate: CodingStateMachine  = CodingStateMachine(UTF8SMModel())
    
    let model: String = codingstate.getCodingStateMachine()
    println(model)

    if (model != "UTF-8") {
        return 1
    }
    codingstate.reset()
    let model2: String = codingstate.getCodingStateMachine()
    
    if (model != "") {
        return 0
    }
    return 1
}

