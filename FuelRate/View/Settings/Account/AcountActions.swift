
//Ian Cooper

import UIKit
import Firebase
import os

extension AccountManagment{
    
    func signOut(){
        
        do{
            try Auth.auth().signOut()

            UserDefaults.standard.setValue(nil, forKey: "uuid")
            UserDefaults.standard.setValue(nil, forKey: "password")
            NotificationCenter.default.post(name: .SignOut, object: nil)

        }catch{
            os_log("\(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        let activity = UIAlertController(title: "Are you sure?", message: "This will delete your account along with all the information, permanently!", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .destructive) { _ in
            DeleteAccount().deleteAccount { deleted in
                if deleted{
                    self.signOut()
                }
            }
        }
        let no = UIAlertAction(title:"No", style: .cancel)
        activity.addAction(yes) ; activity.addAction(no)
        self.present(activity, animated: true, completion: nil)
    }
    
}
