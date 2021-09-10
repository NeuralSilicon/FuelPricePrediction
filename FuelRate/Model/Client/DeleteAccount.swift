
//Ian Cooper

import UIKit
import Firebase
import os

class DeleteAccount {
    
    var uuid:String?
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database(url: "").reference()
        guard let uuid = UserDefaults.standard.value(forKey: "uuid") as? String else {return}
        self.uuid = uuid
    }
    
    func deleteAccount(deleted:@escaping(Bool)->Void){
        guard let uuid = uuid else {
            return
        }
        
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
            os_log("\(error.localizedDescription)")
            deleted(false)
          } else {
            self.ref.child("Client").child(uuid).removeValue()
            deleted(true)
          }
        }
        
    }
}
