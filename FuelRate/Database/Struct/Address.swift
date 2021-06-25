

//Ian Cooper

import Foundation
import Firebase

struct Address {
    var useruuid: String = ""
    var addressLineOne: String = ""
    var addressLineTwo: String = ""
    var city: String = ""
    var state: String = ""
    var zipcode: String = ""
    
    init() {}

    init(from dictionary: [String: Any]) {
        useruuid = dictionary["useruuid"] as! String
        addressLineOne = dictionary["addressLineOne"] as! String
        addressLineTwo = dictionary["addressLineTwo"] as! String
        city = dictionary["city"] as! String
        state = dictionary["state"] as! String
        zipcode = dictionary["zipcode"] as! String
    }

    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let uuid = value["useruuid"] as? String,
        let addressLineOne = value["addressLineOne"] as? String,
        let addressLineTwo = value["addressLineTwo"] as? String,
        let city = value["city"] as? String,
        let state = value["state"] as? String,
        let zipcode = value["zipcode"] as? String
        else {
        return
      }
        self.useruuid = uuid
        self.addressLineOne = addressLineOne
        self.addressLineTwo = addressLineTwo
        self.city = city
        self.state = state
        self.zipcode = zipcode
    }
    
    func asPropertyList() -> [String: Any] {
        return ["useruuid": useruuid,
                "addressLineOne": addressLineOne,
                "addressLineTwo":addressLineTwo,
                "city": city,
                "state": state,"zipcode":zipcode]
    }

}
