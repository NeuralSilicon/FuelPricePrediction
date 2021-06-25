

//Ian Cooper

import Foundation
import Firebase

struct FuelFactors {
    var companyProfit: Double = 0.1
    var currentPrice: Double = 1.50
    var gallonsRequested: Double = 0
    var history: Double = 0
    var location: Double = 0
    
    init() {
    }

  init(from dictionary: [String: Any]) {
    companyProfit = dictionary["companyProfit"] as! Double
    currentPrice = dictionary["currentPrice"] as! Double
    gallonsRequested = dictionary["gallonsRequested"] as! Double
    history = dictionary["history"] as! Double
    location = dictionary["location"] as! Double
  }

  func asPropertyList() -> [String: Any] {
    return ["companyProfit": companyProfit,
            "currentPrice": currentPrice, "gallonsRequested": gallonsRequested,
            "history": history,"location":location]
  }

}
