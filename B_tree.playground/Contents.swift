import Foundation

class BinaryNode<T> {
    var value: T
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    
    init(value: T) {
        self.value = value
    }
}

extension BinaryNode {
    func traverseInOrder(visit: (T) -> Void){
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    func traversePreOrder(visit: (T) -> Void){
        visit(value)
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    func traversePostOrder(visit: (T) -> Void){
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
        visit(value)
    }
}


let tree : BinaryNode<Int> =  {
    let first = BinaryNode(value: 1)
   let second = BinaryNode(value: 2)
    let third = BinaryNode(value: 3)
    let fourth = BinaryNode(value: 4)
    let fifth = BinaryNode(value: 5)
    let sixth = BinaryNode(value: 6)
    let seventh = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let ninth = BinaryNode(value: 9)
    
    fifth.leftChild = third
    third.rightChild = fourth
    third.leftChild = first
    first.rightChild = second
    
    
    fifth.rightChild = seventh
    seventh.leftChild = sixth
    seventh.rightChild = ninth
    ninth.leftChild = eight
    
    return fifth
}()

print("===traverseInOrder start===")
tree.traverseInOrder(visit: {print("--\($0)--")})
print("===traverseInOrder over===")
print("===traversePreOrder start===")
tree.traversePreOrder(visit: {print("--\($0)--")})
print("===traversePreOrder over===")
print("===traversePostOrder start===")
tree.traversePostOrder(visit: {print("--\($0)--")})
print("===traversePostOrder over===")
