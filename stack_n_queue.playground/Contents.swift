protocol Queue {
    associatedtype T
    
    mutating func enqueue(_ element: T)
    mutating func dequeue() -> T?
    var isEmpty: Bool { get }
    var peek: T? { get }
}

struct QueueArray<T>: Queue {
    
    private var storage: [T] = []
    
    var isEmpty: Bool { return storage.isEmpty }
    
    var peek: T? { return storage.first }
    
    mutating func enqueue(_ element: T) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        return isEmpty ? nil : storage.removeFirst()
    }
    
}

struct QueueStack<T>: Queue {
    var dequeueStack: [T] = []
    var enqueueStack: [T] = []
    
    private var storage: [T] = []
    
    init() { }
    
    init(_ e:[T]) {
        enqueueStack = e
    }
    
    
    var isEmpty: Bool { return dequeueStack.isEmpty && enqueueStack.isEmpty  }
    
    var peek: T? {  return !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first }
    
    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }
    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
        
    }
}

extension QueueStack: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: T...) {
        enqueueStack = elements
    }
}


// STACK

struct Stack<T : Equatable> : Equatable {
    private var storage: [T] = [T]()
    var isEmpty : Bool {
        return peek() == nil
    }
    
    init() { }
    
    init(_ e:[T]) {
        storage = e
    }
    
    func peek() ->T? {
        return storage.last
    }
    
    mutating func push(_ e : T) {
        self.storage.append(e)
    }
    
    @discardableResult
    mutating func pop() -> T?{
        return storage.popLast()
    }
}

extension Stack : CustomStringConvertible {
    var description: String {
        return storage.map { "\($0)"}
            .joined(separator: " ")
    }
}


extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: T...) {
        storage = elements
    }
}


let s = "))(())))()(())(((()(())(()))))()(((()((())"
var myStack = Stack<Character>()
_ = s.map {
    if $0 == "(" || $0 == ")"{
        if myStack.isEmpty {
            myStack.push($0)
        } else {
            if myStack.peek() == $0
            {
                myStack.push($0)
                
            } else {
                myStack.pop()
                
            }
        }
    }
}

if myStack.isEmpty {
    print("yay! example inspired from raywenderlich.com course")
}
myStack
