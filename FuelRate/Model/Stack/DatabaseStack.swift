
//Ian Cooper

import Foundation
import Firebase

class DatabaseStack{
    static var shared = DatabaseStack()
    var group = DispatchGroup()
    
    var client:Client!
    var address:Address!
    var fuelQuotes:[FuelQuote]!
    
    private var ref: DatabaseReference!
    private var uuid:String?
    
    init() {
        ref = Database.database(url: ").reference()
        self.uuid = UserDefaults.standard.value(forKey: "uuid") as? String ?? nil
    }

    func RetrieveList(){
        guard let uuid = UserDefaults.standard.value(forKey: "uuid") as? String else {
            return
        }

        self.group.enter()
        let fuelquotes = self.ref.child("Client").child(uuid).child("FuelQuotes")
        
        fuelquotes.queryOrdered(byChild: "requestedDate").observe(.value, with: { snapshot in
            
            self.fuelQuotes = []
            
            if !snapshot.hasChildren(){
                self.group.leave()
                fuelquotes.removeAllObservers()
                return
            }
  
            for (i, child) in snapshot.children.enumerated() {
                if let new = child as? DataSnapshot{
                    self.fuelQuotes.append(FuelQuote(snapshot: new) ?? FuelQuote())
                }
            
                if i == snapshot.childrenCount - 1{
                    self.group.leave()
                    fuelquotes.removeAllObservers()
                }
            }
        })

    }

    func RetrieveAddress(){
        guard let uuid = UserDefaults.standard.value(forKey: "uuid") as? String else {
            return
        }
        self.address = Address()
        self.group.enter()
        let addressRef = self.ref.child("Client").child(uuid).child("Address")
        addressRef.observe(.value, with: { snapshot in

            if !snapshot.hasChildren(){
                self.group.leave()
                addressRef.removeAllObservers()
                return
            }
            self.address = Address.init(snapshot: snapshot)
      
            self.group.leave()
            addressRef.removeAllObservers()
        })
    }
    
    func RetrieveClient(){
        guard let uuid = UserDefaults.standard.value(forKey: "uuid") as? String else {
            return
        }
        self.group.enter()
        let userRef = self.ref.child("Client").child(uuid).child("User")
        
        //calling database to check for client with our id
        userRef.observe(.value, with: { snapshot in
         
            if !snapshot.hasChildren(){
                self.group.leave()
                userRef.removeAllObservers()
                return
            }
            self.client = Client.init(snapshot: snapshot)
            self.group.leave()
            userRef.removeAllObservers()
        })
        
    }
}
