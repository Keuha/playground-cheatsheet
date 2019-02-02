import Foundation

var runQueue = DispatchQueue(label: "firstQueue", attributes: .concurrent)
var completionQueue = DispatchQueue(label: "secondQueue", attributes: .concurrent)
var group = DispatchGroup()

// EXAMPLE 1

runQueue.async(group: group) {
    let time = UInt32.random(in: 0 ..< 10)
    sleep(time)
    print("firstQueue just ended task !")
}

completionQueue.async(group: group) {
    let time = UInt32.random(in: 0 ..< 10)
    sleep(time)
    print("second just ended task !")
}

group.notify(queue: DispatchQueue.main) {
    print("all queue are complete")
}

//synchronous, dont call on main thread or -> risk of dead lock
group.wait(timeout: DispatchTime.distantFuture)

// EXAMPLE 2

func sleepAsync(runQueue: DispatchQueue, completionQueue: DispatchQueue,
              completion: @escaping (Int, Error?) -> ()) {
    runQueue.async {
        var error: Error?
        error = .none
        let result = sleepRandomly()
        completionQueue.async { completion(result, error) }
    }
}

func sleepRandomly() -> Int {
    let time = UInt32.random(in: 0 ..< 10)
    sleep(time)
    return Int(time)
}

for _ in 0..<10 {
    sleepAsync(runQueue: runQueue, completionQueue: completionQueue) {
        result, error in
        print("Result = \(result)")
    }
}
group.notify(queue: DispatchQueue.main) {
    print("sleep over")
}
