import UIKit

// Objects need to be declared as @objc and to inherit from NSObject to be observable
@objc class User : NSObject {
    /*
    ** The value you want to observe needs to be both
    ** declared as @objc and dynamic
    */
    @objc dynamic var name : String
    
    init(withName: String) {
        self.name = withName
        super.init()
    }
}

class UserManager: NSObject {
    /*
     ** the NSKeyValueObservation need to be store, or it is release immediatly after being declared
     ** in this example, we store the object with its observer
     */
    
    var userObs = [(user:User, observer:NSKeyValueObservation)]()
    
    init(withArrayOfUsers: [User]) {
        super.init()
        withArrayOfUsers.compactMap { addUser($0) }
    }
    
    func addUsers(withArrayOfUsers : [User]) {
        withArrayOfUsers.compactMap { addUser($0) }
    }
    
    func addUser(_ user :User) {
        // here we declare an observer with option new and old se we can keep track of the oldValue and the new value
       let obs = user.observe(\.name, options: [.new, .old]) {
            object, change in
            // unwrapping oldValue and newValue
            if let oldValue = change.oldValue, let newValue = change.newValue {
                print("new name is \(String(describing: newValue))")
                print("old name was \(String(describing: oldValue))")
                // we can even find back what User object was changed
                if let index = self.userObs.index(where: {($0.user == object )}) {
                    print("usr\(index) was changed")
                }

            }
        }
        self.userObs.append((user, obs))
    }
}


var usr0 = User(withName: "Bob")
var usr1 = User(withName: "John")
var usr2 = User(withName: "Mike")
var usr3 = User(withName: "Bobby")
var usr4 = User(withName: "Eric")
var usr5 = User(withName: "Denis")

var userMngr = UserManager(withArrayOfUsers: [usr0, usr1, usr2, usr3, usr4, usr5])

usr1.name = "Alex"
usr4.name = "Dan"


