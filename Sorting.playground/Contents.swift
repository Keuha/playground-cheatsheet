func bubbleSort<T: Comparable> (_ array:inout [T]) {
    guard array.count > 1 else {
        return
    }
    
    for endOfArray in (1..<array.count).reversed() {

        var hasBeenSwapped = false
        
        for current in 0..<endOfArray {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                hasBeenSwapped = true
            }
        }
        if hasBeenSwapped == false {
            return
        }
    }
}

func selectionSort<T: Comparable> (_ array:inout [T]) {
    guard array.count > 1 else {
        return
    }
    
    for idx in (0..<(array.count - 1)) {
       var start = idx
        
        for to in (idx + 1)..<array.count {
            if array[start] > array[to] {
                //swap index
                start = to
            }
        }
        if idx < start {
            array.swapAt(start, idx)
        }
    }
}

func insertionSort<T: Comparable> (_ array:inout [T]) {
    guard array.count > 1 else {
        return
    }
    
    for start in 1..<array.count {
        for idx in (1...start).reversed() {
            if array[idx] < array[idx - 1] {
                array.swapAt(idx, idx - 1)
            }
        }
    }
}


func mergeSort<T: Comparable> (_ array: inout [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let middle = array.count / 2
    var leftArray = Array(array[..<middle])
    var rightArray = Array(array[middle...])
    let left = mergeSort(&leftArray)
    let right = mergeSort(&rightArray)
    return merge(left, right)
}

func merge<T: Comparable>(_ left:[T], _ right:[T]) -> [T] {
     var leftIndex = 0
    var rightIndex = 0
    var res : [T] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        if leftElement < rightElement {
            res.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            res.append(rightElement)
            rightIndex += 1
        } else {
            res.append(leftElement)
            res.append(rightElement)
            leftIndex += 1
            rightIndex += 1
        }
    }
    if leftIndex < left.count {
        res.append(contentsOf: left[leftIndex...])
    }
    if rightIndex < right.count {
        res.append(contentsOf: right[rightIndex...])
    }
    return res
}

var a = [5,4,3,6,7,8,3]
var b = a
var c = a
var d = a + a + a
bubbleSort(&a)
a
selectionSort(&b)
b
insertionSort(&c)
c
d = mergeSort(&d)
d
