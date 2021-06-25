
//Ian Cooper


import Foundation
import Firebase


struct Client {
    var uuid:String = ""
    var username: String = ""
    var password:String = ""
    var fullname:String = ""
    
    init() {}

  init(from dictionary: [String: Any]) {
    uuid = dictionary["uuid"] as! String
    username = dictionary["username"] as! String
    password = dictionary["password"] as! String
    fullname = dictionary["fullname"] as! String
  }

    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let uuid = value["uuid"] as? String,
        let username = value["username"] as? String,
        let password = value["password"] as? String,
        let fullname = value["fullname"] as? String
        else {
        return
      }
        self.uuid = uuid
        self.username = username
        self.password = password
        self.fullname = fullname
    }
    
  func asPropertyList() -> [String: Any] {
    return ["uuid": uuid,
            "username": username, "password": password,
            "fullname": fullname
    ]
  }

}
