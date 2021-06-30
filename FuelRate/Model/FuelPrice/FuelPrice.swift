// Khalid 
import Foundation
import Firebase

protocol FuelPriceDelegate {
    func calculated(value:FuelQuote, address:Address)
}

class FuelPrice{
    
    var fuelQuote:FuelQuote!
    var fuelFactor:FuelFactors
    var address:Address!
    var ref: DatabaseReference!
    var delegate:FuelPriceDelegate?
    var uuid:String?
    var group:DispatchGroup!
    
    init(fuelQuote:FuelQuote) {
        ref = Database.database(url: "https://fuelrate-7520e-default-rtdb.firebaseio.com/").reference()// write and read from database
        self.fuelQuote = fuelQuote
        self.uuid = UserDefaults.standard.value(forKey: "uuid") as? String ?? nil
        self.fuelFactor = FuelFactors(); self.address = Address(); self.group = DispatchGroup()
    }

    func calculate(){
        guard uuid != nil else {
            return
        }
        
        self.group.enter()
        DatabaseStack.shared.RetrieveList()
        DatabaseStack.shared.group.notify(queue: .main) {
            self.fuelFactor.history = DatabaseStack.shared.fuelQuotes.count > 0 ? 0.01 : 0
            print("done Fuel")
        }
        
        DatabaseStack.shared.RetrieveAddress()
        DatabaseStack.shared.group.notify(queue: .main) {
            self.address = DatabaseStack.shared.address
            self.fuelFactor.location = self.address.state == "TX" ? 0.02:0.04 //check if state equals Texas
            self.group.leave()
            print("done with address")
        }
        
        group.notify(queue: .main) {
            self.calculatePrice()

            self.delegate?.calculated(value:  self.fuelQuote, address:  self.address)
        }
    }
    
    func calculatePrice(){
        self.fuelFactor.gallonsRequested = self.fuelQuote.gallonsRequested > 1000 ? 0.02 : 0.03 //check if gallons quantity is 1000 or more 
        self.fuelFactor.companyProfit = 0.1
        self.fuelFactor.currentPrice = 1.50

        self.fuelQuote.margin = ( self.fuelFactor.location -  self.fuelFactor.history + self.fuelFactor.gallonsRequested +  self.fuelFactor.companyProfit) *  self.fuelFactor.currentPrice
        
        self.fuelQuote.suggestedPricePerGallon =  self.fuelQuote.margin +  self.fuelFactor.currentPrice
        self.fuelQuote.suggestedPricePerGallon = Double(round(1000 * self.fuelQuote.suggestedPricePerGallon)/1000)
        
        self.fuelQuote.totalAmountDue =  self.fuelQuote.suggestedPricePerGallon *  self.fuelQuote.gallonsRequested
        self.fuelQuote.totalAmountDue = Double(round(1000 * self.fuelQuote.totalAmountDue)/1000)
    }
    
    func saveQuote(){
                
        let userRef = self.ref.child("Client")
        
        userRef.observe(.value, with: { snapshot in
         
            if snapshot.exists() && snapshot.hasChildren(){
                self.ref.child("Client").child(self.uuid!).child("FuelQuotes").child(self.fuelQuote.requestedDate).setValue(self.fuelQuote.asPropertyList())
            }
            userRef.removeAllObservers()
        })

    }
    
}
