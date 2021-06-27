
import Foundation

class FuelPriceDummy{
    
    var fuelQuote:FuelQuote!
    var fuelFactor:FuelFactors
    var address:Address!
    var uuid:String?
    
    init(fuelQuote:FuelQuote) {
        self.fuelQuote = fuelQuote
        self.uuid = UserDefaults.standard.value(forKey: "uuid") as? String ?? nil
        self.fuelFactor = FuelFactors(); self.address = Address()
    }

    func calculate(){
        guard uuid != nil else {
            return
        }
        
        self.fuelFactor.history = 0
        self.fuelFactor.location = self.address.state == "TX" ? 0.02:0.04
        calculatePrice()
    }
    
    func calculatePrice(){
        self.fuelFactor.gallonsRequested = self.fuelQuote.gallonsRequested > 1000 ? 0.02 : 0.03
        self.fuelFactor.companyProfit = 0.1
        self.fuelFactor.currentPrice = 1.50

        self.fuelQuote.margin = ( self.fuelFactor.location -  self.fuelFactor.history + self.fuelFactor.gallonsRequested +  self.fuelFactor.companyProfit) *  self.fuelFactor.currentPrice
        
        self.fuelQuote.suggestedPricePerGallon =  self.fuelQuote.margin +  self.fuelFactor.currentPrice
        self.fuelQuote.suggestedPricePerGallon = Double(round(1000 * self.fuelQuote.suggestedPricePerGallon)/1000)
        
        self.fuelQuote.totalAmountDue =  self.fuelQuote.suggestedPricePerGallon *  self.fuelQuote.gallonsRequested
        self.fuelQuote.totalAmountDue = Double(round(1000 * self.fuelQuote.totalAmountDue)/1000)
    }

}
