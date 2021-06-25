

//Ian Cooper

import Foundation
import Firebase

struct FuelQuote {
    var useruuid: String = ""
    var delivaryDate: String = ""
    var gallonsRequested: Double = 0
    var margin: Double = 0
    var requestedDate: String = ""
    var suggestedPricePerGallon: Double = 0
    var totalAmountDue: Double = 0
    init() {
    }
    
    init(fuelQuote:FuelQuote) {
        self = fuelQuote
    }

    init(from dictionary: [String: Any]) {
        useruuid = dictionary["useruuid"] as! String
        delivaryDate = dictionary["delivaryDate"] as! String
        requestedDate = dictionary["requestedDate"] as! String
        gallonsRequested = dictionary["gallonsRequested"] as! Double
        margin = dictionary["margin"] as! Double
        suggestedPricePerGallon = dictionary["suggestedPricePerGallon"] as! Double
        totalAmountDue = dictionary["totalAmountDue"] as! Double
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let uuid = value["useruuid"] as? String,
        let delivaryDate = value["delivaryDate"] as? String,
        let requestedDate = value["requestedDate"] as? String,
        let gallonsRequested = value["gallonsRequested"] as? Double,
        let margin = value["margin"] as? Double,
        let suggestedPricePerGallon = value["suggestedPricePerGallon"] as? Double,
        let totalAmountDue = value["totalAmountDue"] as? Double
        else {
        return
      }

        self.useruuid = uuid
        self.delivaryDate = delivaryDate
        self.gallonsRequested = gallonsRequested
        self.margin = margin
        self.requestedDate = requestedDate
        self.suggestedPricePerGallon = suggestedPricePerGallon
        self.totalAmountDue = totalAmountDue
    }


    func asPropertyList() -> [String: Any] {
        return ["useruuid": useruuid,
                "delivaryDate": delivaryDate, "requestedDate": requestedDate,
                "gallonsRequested": gallonsRequested,"margin":margin
                ,"suggestedPricePerGallon":suggestedPricePerGallon,"totalAmountDue":totalAmountDue]
    }

}
