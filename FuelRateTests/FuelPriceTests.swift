

//Ian Cooper

import XCTest
@testable import FuelRate

class FuelPriceTests: XCTestCase {
    var fuelPrice:FuelPriceDummy!
    
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        fuelPrice = FuelPriceDummy(fuelQuote: FuelQuote())
    }

    override func tearDownWithError() throws {
        fuelPrice = nil
      try super.tearDownWithError()
    }
    
    func testPrice() {

        var fuelQuote = FuelQuote()
        fuelQuote.gallonsRequested = 1500
        
        var fuelFactor = FuelFactors()
        fuelFactor.history = 0.01
        fuelFactor.location = 0.02


        fuelPrice.fuelQuote = fuelQuote
        fuelPrice.fuelFactor = fuelFactor
        fuelPrice.calculatePrice()
        

        XCTAssertEqual(fuelPrice.fuelQuote.totalAmountDue,2542.50, "Wrong Total Amount")
        XCTAssertEqual(fuelPrice.fuelQuote.suggestedPricePerGallon,1.695, "Wrong suggestedPricePerGallon")
    }
    
    func testPriceTwo() {

        var fuelQuote = FuelQuote()
        fuelQuote.gallonsRequested = 25
        
        var fuelFactor = FuelFactors()
        fuelFactor.history = 0
        fuelFactor.location = 0.03

        fuelPrice.fuelQuote = fuelQuote
        fuelPrice.fuelFactor = fuelFactor
        fuelPrice.calculatePrice()
        
        XCTAssertEqual(fuelPrice.fuelQuote.totalAmountDue,43.5, "Wrong Total Amount")
        XCTAssertEqual(fuelPrice.fuelQuote.suggestedPricePerGallon,1.74, "Wrong suggestedPricePerGallon")
    }
    
    func testCalculate(){
        var fuelQuote = FuelQuote()
        fuelQuote.gallonsRequested = 25
        
        var fuelFactor = FuelFactors()
        fuelFactor.history = 0
        fuelFactor.location = 0.03

        fuelPrice.fuelQuote = fuelQuote
        fuelPrice.fuelFactor = fuelFactor
        fuelPrice.uuid = UUID.init().uuidString
        
        XCTAssertNoThrow(fuelPrice.calculate())
        
        fuelPrice.uuid = nil
        XCTAssertNoThrow(fuelPrice.calculate())
        
    }
    
}
