
// Ian cooper


import Foundation
import Firebase
import os

protocol RegisterationDelegate {
    func savedClient(value:Bool)
    func createdUser(value:Bool)
}

class Registeration{
    
    var client:Client!
    var address:Address!
    var ref: DatabaseReference!
    var delegate:RegisterationDelegate?
    
    init(client:Client, address:Address) {
        ref = Database.database(url: "https://fuelrate-7520e-default-rtdb.firebaseio.com/").reference(); self.client = client
        self.address = address
    }
    
    func createUser(){
         Auth.auth().createUser(withEmail: (self.client.username), password: (self.client.password)) { (result, error) in
            if let _eror = error {
                print(_eror.localizedDescription )
                self.delegate?.createdUser(value: false)
            }else{
                UserDefaults.standard.setValue(Auth.auth().currentUser!.uid, forKey: "uuid")
                UserDefaults.standard.setValue(self.client.password, forKey: "password")
                self.delegate?.createdUser(value: true)
            }
        }
    }
    
    func saveClient(){
        
        do{
            self.client.password = try Encryption().aesEncrypt(KEY: "keykeykeykeykeyk", IV: "drowssapdrowssap", password: self.client.password)
        }
        catch{
            os_log("failed to encrypt")
        }
        
        self.ref.child("Client").child(self.client.uuid).child("User").setValue(self.client.asPropertyList())
        self.ref.child("Client").child(self.client.uuid).child("Address").setValue(self.address.asPropertyList())
  
        self.delegate?.savedClient(value: true)
    }
    
}

